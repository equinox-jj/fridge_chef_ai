import 'package:auth/data/repositories/auth_repository_impl.dart';
import 'package:auth/domain/entities/user_entity.dart';
import 'package:core/constants/dietary/dietary_preference.dart';
import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.dart';

void main() {
  late MockAuthRemoteDataSource remote;
  late MockAuthLocalDataSource local;
  late MockPendingDietaryPreferenceStore pendingStore;
  late AuthRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(userModel());
  });

  setUp(() {
    remote = MockAuthRemoteDataSource();
    local = MockAuthLocalDataSource();
    pendingStore = MockPendingDietaryPreferenceStore();
    repository = AuthRepositoryImpl(
      remoteDataSource: remote,
      localDataSource: local,
      pendingDietaryPreferenceStore: pendingStore,
      logger: FakeLogger(),
    );
  });

  group('signIn', () {
    test('caches the model and returns the mapped entity', () async {
      when(
        () => remote.signIn(email: 'ada@example.com', password: 'pw'),
      ).thenAnswer((_) async => userModel());
      when(() => local.cacheUser(user: any(named: 'user'))).thenAnswer(
        (_) async {},
      );

      final Either<Failure, UserEntity> result = await repository.signIn(
        email: 'ada@example.com',
        password: 'pw',
      );

      expect(result, Right<Failure, UserEntity>(userEntity()));
      verify(() => local.cacheUser(user: userModel())).called(1);
    });

    test('maps a thrown exception to a Left Failure', () async {
      when(
        () => remote.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(const InvalidCredentialsException());

      final Either<Failure, UserEntity> result = await repository.signIn(
        email: 'ada@example.com',
        password: 'pw',
      );

      expect(result.isLeft(), isTrue);
      result.match(
        (Failure f) => expect(f, isA<InvalidCredentialsFailure>()),
        (_) => fail('expected Left'),
      );
      verifyNever(() => local.cacheUser(user: any(named: 'user')));
    });
  });

  group('signUp', () {
    test(
      'forwards the pending preference, caches the model, clears the store',
      () async {
        when(
          () => pendingStore.read(),
        ).thenAnswer((_) async => DietaryPreference.vegan);
        when(
          () => remote.signUp(
            name: 'Ada',
            email: 'ada@example.com',
            password: 'pw',
            dietaryPreference: 'vegan',
          ),
        ).thenAnswer((_) async => userModel());
        when(() => local.cacheUser(user: any(named: 'user'))).thenAnswer(
          (_) async {},
        );
        when(() => pendingStore.clear()).thenAnswer((_) async {});

        final Either<Failure, UserEntity> result = await repository.signUp(
          name: 'Ada',
          email: 'ada@example.com',
          password: 'pw',
        );

        expect(result, Right<Failure, UserEntity>(userEntity()));
        verify(
          () => remote.signUp(
            name: 'Ada',
            email: 'ada@example.com',
            password: 'pw',
            dietaryPreference: 'vegan',
          ),
        ).called(1);
        verify(() => local.cacheUser(user: userModel())).called(1);
        verify(() => pendingStore.clear()).called(1);
      },
    );

    test('forwards a null preference when nothing is pending', () async {
      when(() => pendingStore.read()).thenAnswer((_) async => null);
      when(
        () => remote.signUp(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          dietaryPreference: null,
        ),
      ).thenAnswer((_) async => userModel());
      when(() => local.cacheUser(user: any(named: 'user'))).thenAnswer(
        (_) async {},
      );
      when(() => pendingStore.clear()).thenAnswer((_) async {});

      await repository.signUp(
        name: 'Ada',
        email: 'ada@example.com',
        password: 'pw',
      );

      verify(
        () => remote.signUp(
          name: 'Ada',
          email: 'ada@example.com',
          password: 'pw',
          dietaryPreference: null,
        ),
      ).called(1);
    });

    test('maps a thrown exception to a Left Failure', () async {
      when(() => pendingStore.read()).thenAnswer((_) async => null);
      when(
        () => remote.signUp(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          dietaryPreference: any(named: 'dietaryPreference'),
        ),
      ).thenThrow(const UserAlreadyExistsException());

      final Either<Failure, UserEntity> result = await repository.signUp(
        name: 'Ada',
        email: 'ada@example.com',
        password: 'pw',
      );

      expect(result.isLeft(), isTrue);
      result.match(
        (Failure f) => expect(f, isA<UserAlreadyExistsFailure>()),
        (_) => fail('expected Left'),
      );
      verifyNever(() => local.cacheUser(user: any(named: 'user')));
      verifyNever(() => pendingStore.clear());
    });
  });

  group('forgotPassword', () {
    test('returns Right(unit) on success', () async {
      when(
        () => remote.forgotPassword(email: 'ada@example.com'),
      ).thenAnswer((_) async {});

      final Either<Failure, Unit> result = await repository.forgotPassword(
        email: 'ada@example.com',
      );

      expect(result, const Right<Failure, Unit>(unit));
      verify(() => remote.forgotPassword(email: 'ada@example.com')).called(1);
    });

    test('maps a thrown exception to a Left Failure', () async {
      when(
        () => remote.forgotPassword(email: any(named: 'email')),
      ).thenThrow(const ServerException());

      final Either<Failure, Unit> result = await repository.forgotPassword(
        email: 'ada@example.com',
      );

      expect(result.isLeft(), isTrue);
      result.match(
        (Failure f) => expect(f, isA<ServerFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });

  group('getCurrentUser', () {
    test('caches and maps the remote user', () async {
      when(() => remote.getCurrentUser()).thenAnswer((_) async => userModel());
      when(() => local.cacheUser(user: any(named: 'user'))).thenAnswer(
        (_) async {},
      );

      final Either<Failure, UserEntity?> result = await repository
          .getCurrentUser();

      expect(result, Right<Failure, UserEntity?>(userEntity()));
      verify(() => local.cacheUser(user: userModel())).called(1);
    });

    test('returns a null entity when there is no remote user', () async {
      when(() => remote.getCurrentUser()).thenAnswer((_) async => null);

      final Either<Failure, UserEntity?> result = await repository
          .getCurrentUser();

      expect(result, const Right<Failure, UserEntity?>(null));
      verifyNever(() => local.cacheUser(user: any(named: 'user')));
    });

    test('falls back to the cached user on a NetworkException', () async {
      when(() => remote.getCurrentUser()).thenThrow(const NetworkException());
      when(() => local.getCachedUser()).thenAnswer((_) async => userModel());

      final Either<Failure, UserEntity?> result = await repository
          .getCurrentUser();

      expect(result, Right<Failure, UserEntity?>(userEntity()));
      verify(() => local.getCachedUser()).called(1);
    });

    test('returns null when offline with nothing cached', () async {
      when(() => remote.getCurrentUser()).thenThrow(const NetworkException());
      when(() => local.getCachedUser()).thenAnswer((_) async => null);

      final Either<Failure, UserEntity?> result = await repository
          .getCurrentUser();

      expect(result, const Right<Failure, UserEntity?>(null));
    });
  });

  group('getCachedUser', () {
    test('returns the mapped cached entity', () async {
      when(() => local.getCachedUser()).thenAnswer((_) async => userModel());

      final Either<Failure, UserEntity?> result = await repository
          .getCachedUser();

      expect(result, Right<Failure, UserEntity?>(userEntity()));
    });

    test('returns a null entity when nothing is cached', () async {
      when(() => local.getCachedUser()).thenAnswer((_) async => null);

      final Either<Failure, UserEntity?> result = await repository
          .getCachedUser();

      expect(result, const Right<Failure, UserEntity?>(null));
    });
  });
}
