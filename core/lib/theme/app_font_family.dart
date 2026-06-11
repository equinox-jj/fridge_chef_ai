/// Font family names registered in `core/pubspec.yaml`.
///
/// Use these constants instead of hardcoding family strings so the names stay
/// in sync with the `flutter.fonts` declarations.
abstract final class AppFontFamily {
  /// Fonts are bundled in the `core` package, so family names must be prefixed
  /// with `packages/core/` to resolve when used from the host app.
  static const String _package = 'packages/core/';

  /// Display / heading typeface (weights 400–800).
  static const String display = '${_package}Bricolage Grotesque';

  /// Body / UI typeface (weights 400–800, regular + italic 400/500).
  static const String body = '${_package}Plus Jakarta Sans';

  /// Monospace typeface for code, numbers and tabular data (weights 400–700).
  static const String mono = '${_package}JetBrains Mono';
}
