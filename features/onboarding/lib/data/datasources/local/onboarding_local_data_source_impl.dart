import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/cache_guard.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';

import 'onboarding_local_data_source.dart';

/// [SharedPreferencesAsync]-backed onboarding store.
///
/// Onboarding runs before authentication, so its facts live in lightweight
/// key-value storage rather than the user-scoped database. [CacheGuard]
/// converts any low-level storage error into a [CacheException] so the
/// repository can map it to a `Failure` without per-call try/catch.
class OnboardingLocalDataSourceImpl with CacheGuard implements OnboardingLocalDataSource {
  OnboardingLocalDataSourceImpl(this._prefs, this.logger);

  final SharedPreferencesAsync _prefs;

  @override
  final AppLogger logger;

  static const String _completedKey = 'onboarding_completed';

  @override
  Future<bool> hasCompletedOnboarding() {
    return cacheGuard(() async => await _prefs.getBool(_completedKey) ?? false);
  }

  @override
  Future<void> setCompleted() {
    return cacheGuard(() => _prefs.setBool(_completedKey, true));
  }
}
