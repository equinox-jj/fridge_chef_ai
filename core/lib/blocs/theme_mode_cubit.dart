import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart' show ThemeMode;

import '../services/theme_mode_store.dart';

/// Holds the app's current [ThemeMode] and persists every change.
///
/// Defaults to [ThemeMode.light]; call [loadPersisted] once at startup to apply
/// the saved choice. Depends only on the [ThemeModeStore] abstraction, so it is
/// trivially testable with a fake store.
class ThemeModeCubit extends Cubit<ThemeMode> {
  ThemeModeCubit(this._store) : super(ThemeMode.light);

  final ThemeModeStore _store;

  /// Reads the saved mode and emits it. Safe to call at startup.
  Future<void> loadPersisted() async {
    emit(await _store.read());
  }

  /// Switches between light and dark, persisting the new choice.
  Future<void> setDark(bool isDark) async {
    final ThemeMode mode = isDark ? ThemeMode.dark : ThemeMode.light;
    if (mode == state) return;
    emit(mode);
    await _store.save(mode);
  }
}
