# Auth UI Revamp — Design Spec
**Date:** 2026-06-14  
**Branch:** refactor-theme  
**Source:** FridgeChef AI 2 design system (screens A.1–A.5)

---

## Overview

Replace the green-gradient hero auth layout with the new dark-canvas design from the FridgeScan AI design system. Affects sign in, sign up, forgot password, and adds a new "reset link sent" confirmation screen.

---

## Design System Reference

- Dark canvas: `AppColors.surfaceCanvas` (`#181308`)
- Card surface: `AppColors.surfaceCard` (`#221D13`)
- Primary green: `AppColors.primary` (`#138062`)
- Primary tint: `AppColors.primaryTint` (dark green-50)
- Primary text: `AppColors.primaryText` (bright green on dark)
- Coral danger: `AppColors.danger` / `AppColors.dangerTint` / `AppColors.dangerText`
- Shadows: `AppShadow.primary` (green glow for brand mark)

---

## Section 1 — AuthScaffold (refactored)

**File:** `features/auth/lib/presentation/widgets/auth_scaffold.dart`

Slim down to a slot-based wrapper. Remove gradient, remove hero logic.

```
AuthScaffold({
  Widget? header,       // optional 56px top bar
  required Widget body, // main content, scrollable
  Widget? footer,       // optional bottom link area
})
```

Internals:
- `Scaffold(backgroundColor: AppColors.surfaceCanvas)`
- `GestureDetector(onTap: unfocus, behavior: HitTestBehavior.opaque)`
- `SafeArea`
- Column: `header?` / `Expanded(SingleChildScrollView(child: body))` / `footer?`

**Delete:** `auth_hero_section.dart` — no longer used.

---

## Section 2 — Sign In (A.1 + A.2 error)

**Files:**
- `presentation/pages/sign_in/widgets/sign_in_body.dart` (rename from `sign_in_card.dart`)
- `presentation/pages/sign_in/sign_in_page.dart`

### SignInPage
- No header slot.
- Footer slot: `AppInlineLink(text: 'New here? ', linkLabel: 'Create an account', onTap: toSignUp)`
- `BlocListener` for success → `toDashboard()`. Error → no longer shows SnackBar (handled inline in body).

### SignInBody layout
```
Column(
  children: [
    SizedBox(height: s8),  // top spacing

    // Brand mark
    Container(
      width: 64, height: 64, borderRadius: 18,
      decoration: BoxDecoration(
        gradient: LinearGradient(green500 → green700),
        boxShadow: AppShadow.primary,
      ),
      child: Icon(Icons.kitchen_outlined, size: 32, color: white),
    ),

    SizedBox(height: s3),

    Text('Welcome back', style: AppType.h1),
    Text('Sign in to start cooking', style: AppType.sm [muted]),

    SizedBox(height: s5),

    // Error banner — visible only when signInStatus == BlocStatus.error
    if (isError)
      Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(color: AppColors.dangerTint, borderRadius: rMd),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: AppColors.dangerText),
            SizedBox(width: 10),
            Expanded(Text("That didn't match. Check your details and try again.",
              style: AppType.sm [dangerText])),
          ],
        ),
      ),

    SizedBox(height: s4),

    AppEmailField(controller: emailController),
    SizedBox(height: s4),
    AppPasswordField(controller: passwordController, onSubmit: _submit),
    SizedBox(height: s2),

    // Forgot password link
    Align(alignment: Alignment.centerRight,
      child: GestureDetector(onTap: toForgotPassword,
        child: Text('Forgot password?',
          style: AppType.sm.copyWith(color: AppColors.primaryText, fontWeight: w600)))),

    SizedBox(height: s4),
    AppSubmitButton(label: 'Sign in', icon: Icons.login, ...),
  ],
)
```

**Error handling change:** `SignInPage._onStateChanged` removes the `AppSnackbar.error` call on error. The `SignInBody` reads `state.signInStatus` to show/hide the inline coral banner.

---

## Section 3 — Sign Up (A.3)

**Files:**
- `presentation/pages/sign_up/widgets/sign_up_body.dart` (rename from `sign_up_card.dart`)
- `presentation/pages/sign_up/sign_up_page.dart`

### SignUpPage
- Header slot: `_AuthBackHeader()` — 56px row, back `IconButton` only (no title).
- Footer slot: `AppInlineLink(text: 'Already have an account? ', linkLabel: 'Sign in', onTap: toSignIn)`

### SignUpBody layout
```
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Create your account', style: AppType.h1),
    SizedBox(height: s1),
    Text('Free to start — 15 scans a day.', style: AppType.sm [muted]),
    SizedBox(height: s5),

    // Name field (TextFormField, unchanged)
    SizedBox(height: s4),
    AppEmailField(...),
    SizedBox(height: s4),
    AppPasswordField(...),
    SizedBox(height: s4),

    AppSubmitButton(label: 'Create account', ...),
    SizedBox(height: s3),

    Text(
      'By continuing you agree to our Terms and Privacy Policy.',
      style: AppType.xs [faint], textAlign: center,
    ),
  ],
)
```

---

## Section 4 — Forgot Password (A.4)

**Files:**
- `presentation/pages/forgot_password/widgets/forgot_password_body.dart` (rename from `forgot_password_card.dart`)
- `presentation/pages/forgot_password/forgot_password_page.dart`

### ForgotPasswordPage
- Header slot: `_AuthTitledHeader(title: 'Reset password')` — 56px row, back `IconButton` + title text.
- Footer slot: `Row([Icon(Icons.chevron_left), Text('Back to sign in', green, bold)])` → `toSignIn()`.
- On success: navigate to `ForgotPasswordConfirmationRoute(email: _emailController.text.trim())`.
- On error: `AppSnackbar.error(...)` (keep snackbar for this screen, no inline banner in design).

### ForgotPasswordBody layout
```
Column(
  children: [
    SizedBox(height: s5),

    // Lock icon tile (centered)
    Center(child: Container(
      width: 80, height: 80, borderRadius: 24,
      color: AppColors.primaryTint,
      child: Icon(Icons.lock_outline, size: 38, color: AppColors.primaryText),
    )),

    SizedBox(height: s4),

    Text('Forgot your password?', style: AppType.h2, textAlign: center),
    SizedBox(height: s2),
    ConstrainedBox(maxWidth: 240,
      child: Text('Enter your email and we\'ll send a link to reset it.',
        style: AppType.sm [muted], textAlign: center)),

    SizedBox(height: s5),

    AppEmailField(controller: emailController, onSubmit: _submit),
    SizedBox(height: s4),

    // Submit button with cooldown countdown label
    AppSubmitButton(
      label: isCoolingDown ? 'Resend in ${countdown}s' : 'Send reset link',
      icon: Icons.mark_email_read_outlined,
      isLoading: isLoading,
      onPressed: isCoolingDown ? null : _submit,
    ),
  ],
)
```

---

## Section 5 — Reset Link Sent (A.5) — new screen

**New files:**
- `presentation/pages/forgot_password/forgot_password_confirmation_page.dart`

**Route addition in `auth_routes.dart`:**
```dart
@TypedGoRoute<ForgotPasswordConfirmationRoute>(
  path: AppRoute.forgotPasswordConfirmationPath,
  name: AppRoute.forgotPasswordConfirmationName,
)
class ForgotPasswordConfirmationRoute extends GoRouteData {
  const ForgotPasswordConfirmationRoute({required this.email});
  final String email;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (_) => GetIt.I<ForgotPasswordCubit>(),
      child: ForgotPasswordConfirmationPage(email: email),
    );
  }
}
```

**Route constants** (add to `AppRoute`):
- `forgotPasswordConfirmationPath = '/forgot-password/confirmation'`
- `forgotPasswordConfirmationName = 'forgotPasswordConfirmation'`

**`AppNavigator`**: add `toForgotPasswordConfirmation(String email)` method.

**Page layout** (no header, vertically centered):
```
Scaffold(bg: surfaceCanvas,
  body: SafeArea(
    child: Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: gutter),
        child: Column(
          mainAxisAlignment: center,
          children: [
            // Mail icon
            Container(
              width: 92, height: 92,
              decoration: BoxDecoration(
                color: AppColors.primaryTint,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.mail_outline, size: 42, color: AppColors.primaryText),
            ),

            SizedBox(height: s5),

            Text('Check your email', style: AppType.h1, textAlign: center),
            SizedBox(height: s2),

            // Rich text with bold email
            RichText(text: TextSpan(children: [
              TextSpan('We sent a reset link to ', style: AppType.sm [muted]),
              TextSpan(email, style: AppType.sm.copyWith(color: textBody, fontWeight: w600)),
              TextSpan('. It expires in 30 minutes.', style: AppType.sm [muted]),
            ])),

            SizedBox(height: s6),

            // Open mail app
            AppSubmitButton(
              label: 'Open mail app',
              icon: Icons.open_in_new,
              onPressed: () => launchUrl(Uri.parse('mailto:')),
            ),

            SizedBox(height: s3),

            // Back to sign in (outlined)
            OutlinedButton.icon(
              icon: Icon(Icons.arrow_back),
              label: Text('Back to sign in'),
              onPressed: () => SignInRoute().go(context),
            ),

            SizedBox(height: s4),

            // Resend link
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) {
                final isCooling = state.resendCountdown > 0;
                return GestureDetector(
                  onTap: isCooling ? null : () =>
                    context.read<ForgotPasswordCubit>().forgotPassword(email: email),
                  child: RichText(text: TextSpan(children: [
                    TextSpan("Didn't get it? ", style: AppType.sm [muted]),
                    TextSpan(
                      isCooling ? 'Resend in ${state.resendCountdown}s' : 'Resend',
                      style: AppType.sm.copyWith(
                        color: isCooling ? textFaint : primaryText, fontWeight: w600)),
                  ])),
                );
              },
            ),
          ],
        ),
      ),
    ),
  ),
)
```

---

## Shared private widgets

Two small header widgets, private to the auth feature (not exported). Both live at the bottom of `auth_scaffold.dart`:

**`_AuthBackHeader`** — used by sign up:
```dart
// 56px row, back IconButton only (no title)
```

**`_AuthTitledHeader`** — used by forgot password:
```dart
// 56px row, back IconButton + Text(title, AppType.h3)
```

---

## Files changed

| File | Action |
|------|--------|
| `presentation/widgets/auth_scaffold.dart` | Refactor — remove gradient, add header/body/footer slots |
| `presentation/widgets/auth_hero_section.dart` | **Delete** |
| `presentation/pages/sign_in/sign_in_page.dart` | Update — remove error snackbar, add footer slot |
| `presentation/pages/sign_in/widgets/sign_in_card.dart` | Rename → `sign_in_body.dart`, remove AppCard, new layout |
| `presentation/pages/sign_up/sign_up_page.dart` | Update — add header/footer slots |
| `presentation/pages/sign_up/widgets/sign_up_card.dart` | Rename → `sign_up_body.dart`, remove AppCard, new layout |
| `presentation/pages/forgot_password/forgot_password_page.dart` | Update — add header/footer, navigate to confirmation on success |
| `presentation/pages/forgot_password/widgets/forgot_password_card.dart` | Rename → `forgot_password_body.dart`, remove AppCard, new layout |
| `presentation/pages/forgot_password/forgot_password_confirmation_page.dart` | **New** |
| `auth_routes.dart` + `auth_routes.g.dart` | Add `ForgotPasswordConfirmationRoute` |
| `core/lib/router/app_route.dart` | Add confirmation path/name constants |
| `core/lib/router/app_navigator.dart` | Add `toForgotPasswordConfirmation(email)` method |

---

## New dependency

**`url_launcher`** — required for the "Open mail app" button on the A.5 confirmation screen (`launchUrl(Uri.parse('mailto:'))`). Not currently in any pubspec. Must be added to `dependencies/pubspec.yaml` and the platform packages (`android/`, `ios/`).

---

## Out of scope

- Onboarding / splash screens (separate initiative)
- Social auth providers (documented as next step in design system)
- Light mode (app is dark-first)
- New custom fonts (Bricolage Grotesque, Plus Jakarta Sans, JetBrains Mono) — separate font setup task
