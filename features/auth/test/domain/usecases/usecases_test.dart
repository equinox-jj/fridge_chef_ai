import 'package:auth/domain/entities/user_entity.dart';
import 'package:auth/domain/usecases/forgot_password_usecase.dart';
import 'package:auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:auth/domain/usecases/get_current_user_usecase.dart';
import 'package:auth/domain/usecases/sign_in_usecase.dart';
import 'package:auth/domain/usecases/sign_up_usecase.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.dart';

void main() {
  late MockAuthRepository repository;

  setUp(() => repository = MockAuthRepository());

  const Failure failure = ServerFailure();

  group('SignInUseCase', () {
    late SignInUseCase useCase;
    setUp(() => useCase = SignInUseCase(repository));

    test('forwards the credentials and returns the user on success', () async {
      final UserEntity user = userEntity();
      when(
        () => repository.signIn(email: 'ada@example.com', password: 'pw'),
      ).thenAnswer((_) async => Right<Failure, UserEntity>(user));

      final Either<Failure, UserEntity> result = await useCase(
        const SignInParams(email: 'ada@example.com', password: 'pw'),
      );

      expect(result, Right<Failure, UserEntity>(user));
      verify(
        () => repository.signIn(email: 'ada@example.com', password: 'pw'),
      ).called(1);
    });

    test('forwards the failure', () async {
      when(
        () => repository.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Left<Failure, UserEntity>(failure));

      final Either<Failure, UserEntity> result = await useCase(
        const SignInParams(email: 'ada@example.com', password: 'pw'),
      );

      expect(result, const Left<Failure, UserEntity>(failure));
    });
  });

  group('SignUpUseCase', () {
    late SignUpUseCase useCase;
    setUp(() => useCase = SignUpUseCase(repository));

    test('forwards every param and returns the user on success', () async {
      final UserEntity user = userEntity();
      when(
        () => repository.signUp(
          name: 'Ada',
          email: 'ada@example.com',
          password: 'pw',
        ),
      ).thenAnswer((_) async => Right<Failure, UserEntity>(user));

      final Either<Failure, UserEntity> result = await useCase(
        const SignUpParams(
          name: 'Ada',
          email: 'ada@example.com',
          password: 'pw',
        ),
      );

      expect(result, Right<Failure, UserEntity>(user));
      verify(
        () => repository.signUp(
          name: 'Ada',
          email: 'ada@example.com',
          password: 'pw',
        ),
      ).called(1);
    });

    test('forwards the failure', () async {
      when(
        () => repository.signUp(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Left<Failure, UserEntity>(failure));

      final Either<Failure, UserEntity> result = await useCase(
        const SignUpParams(
          name: 'Ada',
          email: 'ada@example.com',
          password: 'pw',
        ),
      );

      expect(result, const Left<Failure, UserEntity>(failure));
    });
  });

  group('ForgotPasswordUseCase', () {
    late ForgotPasswordUseCase useCase;
    setUp(() => useCase = ForgotPasswordUseCase(repository));

    test('forwards the email and returns unit on success', () async {
      when(
        () => repository.forgotPassword(email: 'ada@example.com'),
      ).thenAnswer((_) async => const Right<Failure, Unit>(unit));

      final Either<Failure, Unit> result = await useCase(
        const ForgotPasswordParams(email: 'ada@example.com'),
      );

      expect(result, const Right<Failure, Unit>(unit));
      verify(
        () => repository.forgotPassword(email: 'ada@example.com'),
      ).called(1);
    });

    test('forwards the failure', () async {
      when(
        () => repository.forgotPassword(email: any(named: 'email')),
      ).thenAnswer((_) async => const Left<Failure, Unit>(failure));

      expect(
        await useCase(const ForgotPasswordParams(email: 'ada@example.com')),
        const Left<Failure, Unit>(failure),
      );
    });
  });

  group('GetCurrentUserUseCase', () {
    late GetCurrentUserUseCase useCase;
    setUp(() => useCase = GetCurrentUserUseCase(repository));

    test('returns the current user on success', () async {
      final UserEntity user = userEntity();
      when(
        () => repository.getCurrentUser(),
      ).thenAnswer((_) async => Right<Failure, UserEntity?>(user));

      final Either<Failure, UserEntity?> result = await useCase(
        const NoParams(),
      );

      expect(result, Right<Failure, UserEntity?>(user));
      verify(() => repository.getCurrentUser()).called(1);
    });

    test('forwards the failure', () async {
      when(
        () => repository.getCurrentUser(),
      ).thenAnswer((_) async => const Left<Failure, UserEntity?>(failure));

      expect(
        await useCase(const NoParams()),
        const Left<Failure, UserEntity?>(failure),
      );
    });
  });

  group('GetCachedUserUseCase', () {
    late GetCachedUserUseCase useCase;
    setUp(() => useCase = GetCachedUserUseCase(repository));

    test('returns the cached user on success', () async {
      final UserEntity user = userEntity();
      when(
        () => repository.getCachedUser(),
      ).thenAnswer((_) async => Right<Failure, UserEntity?>(user));

      final Either<Failure, UserEntity?> result = await useCase(
        const NoParams(),
      );

      expect(result, Right<Failure, UserEntity?>(user));
      verify(() => repository.getCachedUser()).called(1);
    });

    test('forwards the failure', () async {
      when(
        () => repository.getCachedUser(),
      ).thenAnswer((_) async => const Left<Failure, UserEntity?>(failure));

      expect(
        await useCase(const NoParams()),
        const Left<Failure, UserEntity?>(failure),
      );
    });
  });
}
