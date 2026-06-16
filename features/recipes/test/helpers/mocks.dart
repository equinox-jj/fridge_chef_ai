import 'package:core/events/app_event_bus.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/services/connectivity_service.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes/data/datasources/local/recipe_local_data_source.dart';
import 'package:recipes/data/datasources/remote/recipe_remote_data_source.dart';
import 'package:recipes/domain/repositories/recipe_repository.dart';
import 'package:recipes/domain/usecases/get_cookbook_usecase.dart';
import 'package:recipes/domain/usecases/watch_cookbook_usecase.dart';

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
class MockRecipeRepository extends Mock implements RecipeRepository {}

class MockRecipeRemoteDataSource extends Mock
    implements RecipeRemoteDataSource {}

class MockRecipeLocalDataSource extends Mock implements RecipeLocalDataSource {}

class MockConnectivityService extends Mock implements ConnectivityService {}

// Use-cases (for the bloc).
class MockGetCookbookUseCase extends Mock implements GetCookbookUseCase {}

class MockWatchCookbookUseCase extends Mock implements WatchCookbookUseCase {}

// Supabase plumbing (for the remote data source).
class MockSupabaseService extends Mock implements SupabaseService {}

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockUser extends Mock implements User {}

class MockSupabaseQueryBuilder extends Mock implements SupabaseQueryBuilder {}

class MockPostgrestFilterBuilder<T> extends Mock
    implements PostgrestFilterBuilder<T> {}

class MockPostgrestTransformBuilder<T> extends Mock
    implements PostgrestTransformBuilder<T> {}

/// Re-export so tests can build the bus without a second import.
AppEventBus newEventBus() => AppEventBus();
