import 'dart:async';

import 'package:auth/domain/entities/user_entity.dart';
import 'package:auth/domain/usecases/sign_in_usecase.dart';
import 'package:auth/presentation/pages/sign_in/cubit/sign_in_cubit.dart';
import 'package:auth/presentation/pages/sign_in/cubit/sign_in_state.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fixtures.dart';
import '../helpers/mocks.dart';

void main() {
  late MockSignInUseCase signIn;

  const Failure failure = InvalidCredentialsFailure();

  setUpAll(
    () => registerFallbackValue(
      const SignInParams(email: '', password: ''),
    ),
  );

  setUp(() => signIn = MockSignInUseCase());

  test('emits loading then success carrying the user', () async {
    final UserEntity user = userEntity();
    when(
      () => signIn(any()),
    ).thenAnswer((_) async => Right<Failure, UserEntity>(user));

    final SignInCubit cubit = SignInCubit(signIn);
    final List<SignInState> states = <SignInState>[];
    final StreamSubscription<SignInState> sub = cubit.stream.listen(states.add);

    await cubit.signIn(email: 'ada@example.com', password: 'pw');
    await pumpEventQueue();

    expect(
      states.map((SignInState s) => s.signInStatus),
      <BlocStatus>[BlocStatus.loading, BlocStatus.success],
    );
    expect(states.last.signInResponse, user);

    await sub.cancel();
    await cubit.close();
  });

  test('emits loading then error carrying the failure', () async {
    when(
      () => signIn(any()),
    ).thenAnswer((_) async => const Left<Failure, UserEntity>(failure));

    final SignInCubit cubit = SignInCubit(signIn);
    final List<SignInState> states = <SignInState>[];
    final StreamSubscription<SignInState> sub = cubit.stream.listen(states.add);

    await cubit.signIn(email: 'ada@example.com', password: 'pw');
    await pumpEventQueue();

    expect(
      states.map((SignInState s) => s.signInStatus),
      <BlocStatus>[BlocStatus.loading, BlocStatus.error],
    );
    expect(states.last.signInFailure, failure);

    await sub.cancel();
    await cubit.close();
  });
}
