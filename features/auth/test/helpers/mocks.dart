import 'package:auth/data/datasources/local/auth_local_data_source.dart';
import 'package:auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:auth/domain/repositories/auth_repository.dart';
import 'package:auth/domain/usecases/forgot_password_usecase.dart';
import 'package:auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:auth/domain/usecases/get_current_user_usecase.dart';
import 'package:auth/domain/usecases/sign_in_usecase.dart';
import 'package:auth/domain/usecases/sign_up_usecase.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/services/pending_dietary_preference_store.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';
import 'package:mocktail/mocktail.dart';

/// A no-op [AppLogger]: the guards log on the failure path, but tests assert on
/// the mapped `Failure`/exception, not on logging. Swallowing keeps test output
/// clean while still satisfying the injected dependency.
class FakeLogger implements AppLogger {
  @override
  void debug(String message, {Object? error, StackTrace? stackTrace}) {}

  @override
  void info(String message, {Object? error, StackTrace? stackTrace}) {}

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {}

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {}
}

// Domain / data-source seams.
class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockPendingDietaryPreferenceStore extends Mock
    implements PendingDietaryPreferenceStore {}

// Use-cases (for the cubits).
class MockSignInUseCase extends Mock implements SignInUseCase {}

class MockSignUpUseCase extends Mock implements SignUpUseCase {}

class MockForgotPasswordUseCase extends Mock
    implements ForgotPasswordUseCase {}

class MockGetCurrentUserUseCase extends Mock
    implements GetCurrentUserUseCase {}

class MockGetCachedUserUseCase extends Mock implements GetCachedUserUseCase {}

// Supabase plumbing (for the remote data source).
class MockSupabaseService extends Mock implements SupabaseService {}

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockUser extends Mock implements User {}

class MockAuthResponse extends Mock implements AuthResponse {}

class MockSupabaseQueryBuilder extends Mock implements SupabaseQueryBuilder {}

class MockPostgrestFilterBuilder<T> extends Mock
    implements PostgrestFilterBuilder<T> {}

class MockPostgrestTransformBuilder<T> extends Mock
    implements PostgrestTransformBuilder<T> {}
