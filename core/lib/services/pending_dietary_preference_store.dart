import 'package:dependencies/shared_preferences/shared_preferences.dart';

import '../constants/dietary/dietary_preference.dart';
import '../logger/app_logger.dart';

/// Cross-feature handoff for the dietary preference chosen during onboarding,
/// before the user has an account.
///
/// Onboarding runs pre-auth, so the choice can't be written to the user's
/// profile yet. It is parked here (on-device) and adopted by the `users` row
/// the moment sign-up creates it, then cleared. Lives in `core` because two
/// features share it: `onboarding` writes, `auth` reads and clears.
///
/// Every operation is best-effort: this is a convenience cache, never a source
/// of truth, so a storage error is logged and swallowed rather than allowed to
/// break onboarding completion or sign-up.
class PendingDietaryPreferenceStore {
  PendingDietaryPreferenceStore(
    this._prefs,
    this._logger,
  );

  final SharedPreferencesAsync _prefs;
  final AppLogger _logger;

  static const String _key = 'onboarding_pending_dietary_preference';

  /// Parks the [preference] for sign-up to pick up.
  Future<void> save(DietaryPreference preference) async {
    try {
      await _prefs.setString(_key, preference.value);
    } catch (e, stackTrace) {
      _logger.warning(
        'Failed to save pending dietary preference',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Returns the parked preference, or `null` when none was saved.
  Future<DietaryPreference?> read() async {
    try {
      final String? token = await _prefs.getString(_key);
      return token == null ? null : DietaryPreference.fromValue(token);
    } catch (e, stackTrace) {
      _logger.warning(
        'Failed to read pending dietary preference',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Drops the parked preference once it has been adopted by the profile.
  Future<void> clear() async {
    try {
      await _prefs.remove(_key);
    } catch (e, stackTrace) {
      _logger.warning(
        'Failed to clear pending dietary preference',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}
