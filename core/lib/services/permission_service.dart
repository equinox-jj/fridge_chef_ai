import 'package:dependencies/permission_handler/permission_handler.dart';

/// The actionable outcome of asking for a permission, collapsing the many
/// platform-specific [PermissionStatus] values into the three states a caller
/// actually has to handle.
enum PermissionResult {
  /// The permission is usable (granted, limited or provisional access).
  granted,

  /// The permission was denied but can be requested again.
  denied,

  /// The permission was permanently denied or restricted; the only way to
  /// recover is to send the user to the OS app settings.
  permanentlyDenied;

  /// Whether the underlying permission can be used.
  bool get isGranted => this == PermissionResult.granted;

  /// Whether a follow-up request would just be denied and the user must change
  /// the permission from app settings instead.
  bool get needsSettings => this == PermissionResult.permanentlyDenied;
}

/// Seam for reading a permission's current status. Defaults to the real
/// `permission_handler` extension; overridable in tests.
typedef PermissionStatusResolver =
    Future<PermissionStatus> Function(
      Permission permission,
    );

/// Seam for requesting a single permission. Defaults to the real
/// `permission_handler` extension; overridable in tests.
typedef PermissionRequester =
    Future<PermissionStatus> Function(
      Permission permission,
    );

/// Seam for opening the OS app settings page. Defaults to
/// `permission_handler`'s `openAppSettings`; overridable in tests.
typedef AppSettingsOpener = Future<bool> Function();

/// Reusable wrapper around `permission_handler` that centralises permission
/// flows and stays testable.
///
/// The platform calls are injected as function seams that default to the real
/// `permission_handler` API, so production code constructs it with no
/// arguments while tests pass fakes:
///
/// ```dart
/// final service = PermissionService(); // production
///
/// final service = PermissionService(   // test
///   checkStatus: (_) async => PermissionStatus.denied,
///   request: (_) async => PermissionStatus.granted,
/// );
/// ```
class PermissionService {
  PermissionService({
    PermissionStatusResolver? checkStatus,
    PermissionRequester? request,
    AppSettingsOpener? openSettings,
  }) : _checkStatus = checkStatus ?? ((Permission permission) => permission.status),
       _request = request ?? ((Permission permission) => permission.request()),
       _openSettings = openSettings ?? openAppSettings;

  final PermissionStatusResolver _checkStatus;
  final PermissionRequester _request;
  final AppSettingsOpener _openSettings;

  /// Returns [permission]'s current status without prompting the user.
  Future<PermissionResult> status(Permission permission) async {
    return _map(await _checkStatus(permission));
  }

  /// Ensures [permission] is usable, prompting the user only when the status is
  /// still undecided. Already-granted permissions short-circuit without a
  /// prompt, and permanently denied ones return without one.
  Future<PermissionResult> ensure(Permission permission) async {
    final PermissionResult current = _map(await _checkStatus(permission));
    if (current != PermissionResult.denied) {
      return current;
    }
    return _map(await _request(permission));
  }

  /// Ensures every permission in [permissions] is usable, returning a status
  /// per permission. Permissions are resolved sequentially so the user sees one
  /// prompt at a time.
  Future<Map<Permission, PermissionResult>> ensureAll(
    Iterable<Permission> permissions,
  ) async {
    final Map<Permission, PermissionResult> results = <Permission, PermissionResult>{};
    for (final Permission permission in permissions) {
      results[permission] = await ensure(permission);
    }
    return results;
  }

  /// Opens the OS app settings page so the user can change a permanently denied
  /// permission. Returns `true` when the settings page was opened.
  Future<bool> openSettings() => _openSettings();

  PermissionResult _map(PermissionStatus status) {
    if (status.isGranted || status.isLimited || status.isProvisional) {
      return PermissionResult.granted;
    }
    if (status.isPermanentlyDenied || status.isRestricted) {
      return PermissionResult.permanentlyDenied;
    }
    return PermissionResult.denied;
  }
}
