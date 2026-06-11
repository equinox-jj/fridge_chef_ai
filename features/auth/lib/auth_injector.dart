import 'package:core/services/supabase_service.dart';
import 'package:dependencies/get_it/get_it.dart';

import 'data/datasources/remote/auth_remote_data_source.dart';
import 'data/datasources/remote/auth_remote_data_source_impl.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/forgot_password_usecase.dart';
import 'domain/usecases/get_current_user_usecase.dart';
import 'domain/usecases/sign_in_usecase.dart';
import 'domain/usecases/sign_up_usecase.dart';
import 'presentation/pages/forgot_password/cubit/forgot_password_cubit.dart';
import 'presentation/pages/sign_in/cubit/sign_in_cubit.dart';
import 'presentation/pages/sign_up/cubit/sign_up_cubit.dart';

/// Registers the auth feature's dependencies on [getIt].
///
/// Call this after `Supabase.initialize(...)` has completed.
void initAuthInjector(GetIt getIt) {
  getIt
    // Data source
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt<SupabaseService>()),
    )
    // Repository
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
    )
    // Use cases
    ..registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(getIt<AuthRepository>()),
    )
    ..registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(getIt<AuthRepository>()),
    )
    ..registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(getIt<AuthRepository>()),
    )
    ..registerLazySingleton<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(getIt<AuthRepository>()),
    )
    // Cubits
    ..registerFactory<SignInCubit>(
      () => SignInCubit(getIt<SignInUseCase>()),
    )
    ..registerFactory<SignUpCubit>(
      () => SignUpCubit(getIt<SignUpUseCase>()),
    )
    ..registerFactory<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(getIt<ForgotPasswordUseCase>()),
    );
}
