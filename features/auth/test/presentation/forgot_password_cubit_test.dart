import 'package:auth/domain/usecases/forgot_password_usecase.dart';
import 'package:auth/presentation/pages/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  late MockForgotPasswordUseCase forgotPassword;

  const Failure failure = ServerFailure();

  setUpAll(
    () => registerFallbackValue(const ForgotPasswordParams(email: '')),
  );

  setUp(() => forgotPassword = MockForgotPasswordUseCase());

  test('success sets the email, success status, and a 60s cooldown', () async {
    when(
      () => forgotPassword(any()),
    ).thenAnswer((_) async => const Right<Failure, Unit>(unit));

    final ForgotPasswordCubit cubit = ForgotPasswordCubit(forgotPassword);

    await cubit.forgotPassword(email: 'ada@example.com');

    expect(cubit.state.forgotPasswordStatus, BlocStatus.success);
    expect(cubit.state.email, 'ada@example.com');
    expect(cubit.state.resendCountdown, 60);

    await cubit.close();
  });

  test('failure surfaces an error status with the failure', () async {
    when(
      () => forgotPassword(any()),
    ).thenAnswer((_) async => const Left<Failure, Unit>(failure));

    final ForgotPasswordCubit cubit = ForgotPasswordCubit(forgotPassword);

    await cubit.forgotPassword(email: 'ada@example.com');

    expect(cubit.state.forgotPasswordStatus, BlocStatus.error);
    expect(cubit.state.forgotPasswordFailure, failure);
    expect(cubit.state.resendCountdown, 0);

    await cubit.close();
  });

  test('a second request while the cooldown is active is ignored', () async {
    when(
      () => forgotPassword(any()),
    ).thenAnswer((_) async => const Right<Failure, Unit>(unit));

    final ForgotPasswordCubit cubit = ForgotPasswordCubit(forgotPassword);

    await cubit.forgotPassword(email: 'ada@example.com');
    // Cooldown is now running (60s); a second call must be a no-op.
    await cubit.forgotPassword(email: 'ada@example.com');

    verify(() => forgotPassword(any())).called(1);

    await cubit.close();
  });

  test('the cooldown counts down and the timer is cancelled on close', () {
    fakeAsync((FakeAsync async) {
      when(
        () => forgotPassword(any()),
      ).thenAnswer((_) async => const Right<Failure, Unit>(unit));

      final ForgotPasswordCubit cubit = ForgotPasswordCubit(forgotPassword);

      cubit.forgotPassword(email: 'ada@example.com');
      async.flushMicrotasks();
      expect(cubit.state.resendCountdown, 60);

      async.elapse(const Duration(seconds: 3));
      expect(cubit.state.resendCountdown, 57);

      cubit.close();
      // After close the timer is dead: further time does not change state.
      async.elapse(const Duration(seconds: 5));
      expect(cubit.state.resendCountdown, 57);
    });
  });
}
