import 'dart:async';

import 'package:auth/domain/entities/user_entity.dart';
import 'package:auth/domain/usecases/sign_up_usecase.dart';
import 'package:auth/presentation/pages/sign_up/cubit/sign_up_cubit.dart';
import 'package:auth/presentation/pages/sign_up/cubit/sign_up_state.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fixtures.dart';
import '../helpers/mocks.dart';

void main() {
  late MockSignUpUseCase signUp;

  const Failure failure = UserAlreadyExistsFailure();

  setUpAll(
    () => registerFallbackValue(
      const SignUpParams(name: '', email: '', password: ''),
    ),
  );

  setUp(() => signUp = MockSignUpUseCase());

  test('emits loading then success carrying the user', () async {
    final UserEntity user = userEntity();
    when(
      () => signUp(any()),
    ).thenAnswer((_) async => Right<Failure, UserEntity>(user));

    final SignUpCubit cubit = SignUpCubit(signUp);
    final List<SignUpState> states = <SignUpState>[];
    final StreamSubscription<SignUpState> sub = cubit.stream.listen(states.add);

    await cubit.signUp(name: 'Ada', email: 'ada@example.com', password: 'pw');
    await pumpEventQueue();

    expect(
      states.map((SignUpState s) => s.signUpStatus),
      <BlocStatus>[BlocStatus.loading, BlocStatus.success],
    );
    expect(states.last.signUpResponse, user);

    await sub.cancel();
    await cubit.close();
  });

  test('emits loading then error carrying the failure', () async {
    when(
      () => signUp(any()),
    ).thenAnswer((_) async => const Left<Failure, UserEntity>(failure));

    final SignUpCubit cubit = SignUpCubit(signUp);
    final List<SignUpState> states = <SignUpState>[];
    final StreamSubscription<SignUpState> sub = cubit.stream.listen(states.add);

    await cubit.signUp(name: 'Ada', email: 'ada@example.com', password: 'pw');
    await pumpEventQueue();

    expect(
      states.map((SignUpState s) => s.signUpStatus),
      <BlocStatus>[BlocStatus.loading, BlocStatus.error],
    );
    expect(states.last.signUpFailure, failure);

    await sub.cancel();
    await cubit.close();
  });
}
