import 'package:core/router/app_route.dart';
import 'package:core/router/auth_redirect.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('authGuardRedirect', () {
    group('when signed out', () {
      test('redirects protected routes to sign-in', () {
        for (final String path in <String>[
          AppRoute.fridgeScanPath,
          AppRoute.recipesPath,
          AppRoute.profilePath,
        ]) {
          expect(
            authGuardRedirect(isLoggedIn: false, location: path),
            AppRoute.signInPath,
          );
        }
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
      test('redirects auth pages to home (scan tab)', () {
        for (final String path in <String>[
          AppRoute.signInPath,
          AppRoute.signUpPath,
          AppRoute.forgotPasswordPath,
        ]) {
          expect(
            authGuardRedirect(isLoggedIn: true, location: path),
            AppRoute.fridgeScanPath,
          );
        }
      });

      test('allows protected routes', () {
        for (final String path in <String>[
          AppRoute.fridgeScanPath,
          AppRoute.recipesPath,
          AppRoute.profilePath,
        ]) {
          expect(
            authGuardRedirect(isLoggedIn: true, location: path),
            isNull,
          );
        }
      });
    });
  });
}
