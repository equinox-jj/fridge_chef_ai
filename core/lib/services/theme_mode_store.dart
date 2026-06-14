import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart' show ThemeMode;

import '../logger/app_logger.dart';

/// Persists the user's chosen [ThemeMode] (light or dark) across launches.
///
/// Best-effort, like [PendingDietaryPreferenceStore]: the toggle is a
/// convenience, never a source of truth, so a storage error is logged and
/// swallowed rather than allowed to break theming.
class ThemeModeStore {
  ThemeModeStore(this._prefs, this._logger);

  final SharedPreferencesAsync _prefs;
  final AppLogger _logger;

  static const String _key = 'theme_mode';
  static const String _dark = 'dark';
  static const String _light = 'light';

  /// Returns the persisted mode, or [ThemeMode.light] when none is saved.
  Future<ThemeMode> read() async {
    try {
      final String? token = await _prefs.getString(_key);
      return token == _dark ? ThemeMode.dark : ThemeMode.light;
    } catch (e, stackTrace) {
      _logger.warning(
        'Failed to read theme mode',
        error: e,
        stackTrace: stackTrace,
      );
      return ThemeMode.light;
    }
  }

  /// Persists [mode]. Only light/dark are stored; any other value maps to light.
  Future<void> save(ThemeMode mode) async {
    try {
      await _prefs.setString(_key, mode == ThemeMode.dark ? _dark : _light);
    } catch (e, stackTrace) {
      _logger.warning(
        'Failed to save theme mode',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}
