import 'package:dependencies/fpdart/fpdart.dart';

import '../constants/network/failure.dart';

/// Base contract for a domain use case that returns [T] on success or a
/// [Failure] on error, taking [P] as input.
abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

/// Base contract for a *reactive* use case: emits [T] (or a [Failure]) every
/// time the underlying source changes, taking [P] as input. Use this instead
/// of [UseCase] when the caller should react to live updates rather than a
/// one-shot read.
abstract class StreamUseCase<T, P> {
  Stream<Either<Failure, T>> call(P params);
}

/// Marker for use cases that take no input.
class NoParams {
  const NoParams();
}
