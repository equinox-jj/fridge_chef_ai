import 'package:core/router/app_route.dart';
import 'package:core/router/auth_redirect.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('authGuardRedirect', () {
    group('when signed out', () {
      test('redirects protected routes to sign-in', () {
        expect(
          authGuardRedirect(isLoggedIn: false, location: AppRoute.dashboardPath),
          AppRoute.signInPath,
        );
        expect(
          authGuardRedirect(
            isLoggedIn: false,
            location: AppRoute.fridgeScanPath,
          ),
          AppRoute.signInPath,
        );
      });

      test('allows public routes', () {
        for (final String path in <String>[
          AppRoute.onboardingPath,
          AppRoute.signInPath,
          AppRoute.signUpPath,
          AppRoute.forgotPasswordPath,
        ]) {
          expect(authGuardRedirect(isLoggedIn: false, location: path), isNull);
        }
      });
    });

    group('when signed in', () {
      test('redirects auth pages to dashboard', () {
        for (final String path in <String>[
          AppRoute.signInPath,
          AppRoute.signUpPath,
          AppRoute.forgotPasswordPath,
        ]) {
          expect(
            authGuardRedirect(isLoggedIn: true, location: path),
            AppRoute.dashboardPath,
          );
        }
      });

      test('allows protected routes', () {
        expect(
          authGuardRedirect(isLoggedIn: true, location: AppRoute.dashboardPath),
          isNull,
        );
        expect(
          authGuardRedirect(
            isLoggedIn: true,
            location: AppRoute.fridgeScanPath,
          ),
          isNull,
        );
      });
    });
  });
}
