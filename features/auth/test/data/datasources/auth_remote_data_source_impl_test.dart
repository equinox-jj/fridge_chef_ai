import 'dart:async';

import 'package:auth/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:auth/data/models/user_model.dart';
import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.dart';

typedef PMap = Map<String, dynamic>;
typedef PList = List<Map<String, dynamic>>;

/// A postgrest builder stand-in that is awaitable. PostgrestFilterBuilder is a
/// subtype of PostgrestTransformBuilder and of Future, so this single fake can
/// be returned wherever the chain expects either, and `await` resolves it via
/// the overridden [then].
class _FakeBuilder<T> extends Fake implements PostgrestFilterBuilder<T> {
  _FakeBuilder.value(T value) : _value = value, _error = null;
  _FakeBuilder.error(Object error) : _value = null, _error = error;

  final T? _value;
  final Object? _error;

  @override
  Future<U> then<U>(
    FutureOr<U> Function(T value) onValue, {
    Function? onError,
  }) {
    final Future<T> base = _error != null
        ? Future<T>.error(_error)
        : Future<T>.value(_value as T);
    return base.then(onValue, onError: onError);
  }
}

void main() {
  late MockSupabaseClient client;
  late MockGoTrueClient auth;
  late MockUser user;
  late SupabaseService service;

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    client = MockSupabaseClient();
    auth = MockGoTrueClient();
    user = MockUser();
    service = SupabaseService(client, FakeLogger());

    when(() => client.auth).thenReturn(auth);
    when(() => user.id).thenReturn('u1');
  });

  AuthRemoteDataSourceImpl buildDataSource() =>
      AuthRemoteDataSourceImpl(supabaseService: service);

  /// Stubs the `users` profile read chain used by `_fetchProfile`.
  void stubProfile(PMap row) {
    final MockSupabaseQueryBuilder qb = MockSupabaseQueryBuilder();
    final MockPostgrestFilterBuilder<PList> filter =
        MockPostgrestFilterBuilder<PList>();
    when(() => client.from('users')).thenAnswer((_) => qb);
    when(() => qb.select(any())).thenAnswer((_) => filter);
    when(() => filter.eq('id', 'u1')).thenAnswer((_) => filter);
    when(
      () => filter.single(),
    ).thenAnswer((_) => _FakeBuilder<PMap>.value(row));
  }

  AuthResponse authResponseWith(User? u) {
    final MockAuthResponse response = MockAuthResponse();
    when(() => response.user).thenReturn(u);
    return response;
  }

  group('signIn', () {
    test('returns the profile when the credentials are valid', () async {
      when(
        () => auth.signInWithPassword(
          email: 'ada@example.com',
          password: 'pw',
        ),
      ).thenAnswer((_) async => authResponseWith(user));
      stubProfile(userRow());

      final UserModel result = await buildDataSource().signIn(
        email: 'ada@example.com',
        password: 'pw',
      );

      expect(result.id, 'u1');
      expect(result.email, 'ada@example.com');
      expect(result.dietaryPreferences, 'vegan');
    });

    test('throws InvalidCredentialsException when the user is null', () {
      when(
        () => auth.signInWithPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => authResponseWith(null));

      expect(
        () => buildDataSource().signIn(email: 'ada@example.com', password: 'x'),
        throwsA(isA<InvalidCredentialsException>()),
      );
    });
  });

  group('signUp', () {
    void stubUpsert(PMap inserted) {
      final MockSupabaseQueryBuilder qb = MockSupabaseQueryBuilder();
      final MockPostgrestFilterBuilder<PList> upsert =
          MockPostgrestFilterBuilder<PList>();
      final MockPostgrestTransformBuilder<PList> selected =
          MockPostgrestTransformBuilder<PList>();
      when(() => client.from('users')).thenAnswer((_) => qb);
      when(
        () => qb.upsert(any(), onConflict: any(named: 'onConflict')),
      ).thenAnswer((_) => upsert);
      when(() => upsert.select()).thenAnswer((_) => selected);
      when(
        () => selected.single(),
      ).thenAnswer((_) => _FakeBuilder<PMap>.value(inserted));
    }

    test('creates the profile and returns the inserted model', () async {
      when(
        () => auth.signUp(
          email: 'ada@example.com',
          password: 'pw',
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => authResponseWith(user));
      stubUpsert(userRow());

      final UserModel result = await buildDataSource().signUp(
        name: 'Ada',
        email: 'ada@example.com',
        password: 'pw',
        dietaryPreference: 'vegan',
      );

      expect(result.id, 'u1');
      expect(result.name, 'Ada');
    });

    test('writes the dietary preference into the upsert payload', () async {
      when(
        () => auth.signUp(
          email: any(named: 'email'),
          password: any(named: 'password'),
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => authResponseWith(user));

      final MockSupabaseQueryBuilder qb = MockSupabaseQueryBuilder();
      final MockPostgrestFilterBuilder<PList> upsert =
          MockPostgrestFilterBuilder<PList>();
      final MockPostgrestTransformBuilder<PList> selected =
          MockPostgrestTransformBuilder<PList>();
      when(() => client.from('users')).thenAnswer((_) => qb);
      when(
        () => qb.upsert(any(), onConflict: any(named: 'onConflict')),
      ).thenAnswer((_) => upsert);
      when(() => upsert.select()).thenAnswer((_) => selected);
      when(
        () => selected.single(),
      ).thenAnswer((_) => _FakeBuilder<PMap>.value(userRow()));

      await buildDataSource().signUp(
        name: 'Ada',
        email: 'ada@example.com',
        password: 'pw',
        dietaryPreference: 'vegan',
      );

      final PMap payload =
          verify(
                () => qb.upsert(
                  captureAny(),
                  onConflict: any(named: 'onConflict'),
                ),
              ).captured.single
              as PMap;
      expect(payload['dietary_preference'], 'vegan');
      expect(payload['id'], 'u1');
    });

    test('omits the dietary preference when none is provided', () async {
      when(
        () => auth.signUp(
          email: any(named: 'email'),
          password: any(named: 'password'),
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => authResponseWith(user));

      final MockSupabaseQueryBuilder qb = MockSupabaseQueryBuilder();
      final MockPostgrestFilterBuilder<PList> upsert =
          MockPostgrestFilterBuilder<PList>();
      final MockPostgrestTransformBuilder<PList> selected =
          MockPostgrestTransformBuilder<PList>();
      when(() => client.from('users')).thenAnswer((_) => qb);
      when(
        () => qb.upsert(any(), onConflict: any(named: 'onConflict')),
      ).thenAnswer((_) => upsert);
      when(() => upsert.select()).thenAnswer((_) => selected);
      when(
        () => selected.single(),
      ).thenAnswer((_) => _FakeBuilder<PMap>.value(userRow()));

      await buildDataSource().signUp(
        name: 'Ada',
        email: 'ada@example.com',
        password: 'pw',
      );

      final PMap payload =
          verify(
                () => qb.upsert(
                  captureAny(),
                  onConflict: any(named: 'onConflict'),
                ),
              ).captured.single
              as PMap;
      expect(payload.containsKey('dietary_preference'), isFalse);
    });

    test('throws ServerException when sign up returns a null user', () {
      when(
        () => auth.signUp(
          email: any(named: 'email'),
          password: any(named: 'password'),
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => authResponseWith(null));

      expect(
        () => buildDataSource().signUp(
          name: 'Ada',
          email: 'ada@example.com',
          password: 'pw',
        ),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('forgotPassword', () {
    test('calls resetPasswordForEmail', () async {
      when(
        () => auth.resetPasswordForEmail(any()),
      ).thenAnswer((_) async {});

      await buildDataSource().forgotPassword(email: 'ada@example.com');

      verify(() => auth.resetPasswordForEmail('ada@example.com')).called(1);
    });
  });

  group('getCurrentUser', () {
    test('returns null when there is no signed-in user', () async {
      when(() => auth.currentUser).thenReturn(null);

      expect(await buildDataSource().getCurrentUser(), isNull);
    });

    test('fetches the profile for the signed-in user', () async {
      when(() => auth.currentUser).thenReturn(user);
      stubProfile(userRow());

      final UserModel? result = await buildDataSource().getCurrentUser();

      expect(result, isNotNull);
      expect(result!.id, 'u1');
    });

    test('maps a PostgrestException to a ServerException', () {
      when(() => auth.currentUser).thenReturn(user);
      final MockSupabaseQueryBuilder qb = MockSupabaseQueryBuilder();
      final MockPostgrestFilterBuilder<PList> filter =
          MockPostgrestFilterBuilder<PList>();
      when(() => client.from('users')).thenAnswer((_) => qb);
      when(() => qb.select(any())).thenAnswer((_) => filter);
      when(() => filter.eq('id', 'u1')).thenAnswer((_) => filter);
      when(() => filter.single()).thenAnswer(
        (_) => _FakeBuilder<PMap>.error(
          const PostgrestException(message: 'boom', code: '500'),
        ),
      );

      expect(
        () => buildDataSource().getCurrentUser(),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
