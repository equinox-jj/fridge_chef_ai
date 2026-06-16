import 'package:auth/data/datasources/local/auth_local_data_source_impl.dart';
import 'package:auth/data/models/user_model.dart';
import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.dart';

void main() {
  late AppDatabase database;
  late AuthLocalDataSourceImpl dataSource;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    dataSource = AuthLocalDataSourceImpl(
      database: database,
      logger: FakeLogger(),
    );
  });

  tearDown(() => database.close());

  test('getCachedUser returns null when nothing is cached', () async {
    expect(await dataSource.getCachedUser(), isNull);
  });

  test('cacheUser then getCachedUser round-trips the profile', () async {
    await dataSource.cacheUser(user: userModel());

    final UserModel? result = await dataSource.getCachedUser();

    expect(result, isNotNull);
    expect(result!.id, 'u1');
    expect(result.name, 'Ada');
    expect(result.email, 'ada@example.com');
    expect(result.avatarUrl, 'https://example.com/a.png');
    expect(result.dietaryPreferences, 'vegan');
    expect(result.createdAt!.isAtSameMomentAs(tCreatedAt), isTrue);
  });

  test('cacheUser replaces the previously cached profile', () async {
    await dataSource.cacheUser(user: userModel(id: 'old', name: 'Old'));
    await dataSource.cacheUser(user: userModel(id: 'new', name: 'New'));

    final UserModel? result = await dataSource.getCachedUser();

    expect(result!.id, 'new');
    expect(result.name, 'New');
  });

  test('clear empties the cache', () async {
    await dataSource.cacheUser(user: userModel());

    await dataSource.clear();

    expect(await dataSource.getCachedUser(), isNull);
  });

  test('a storage error surfaces as a CacheException', () async {
    // Drop the backing table so the next write hits a real SQL error inside
    // cacheGuard, which must surface as a CacheException.
    await database.customStatement('DROP TABLE user_profiles');

    expect(
      () => dataSource.cacheUser(user: userModel()),
      throwsA(isA<CacheException>()),
    );
  });
}
