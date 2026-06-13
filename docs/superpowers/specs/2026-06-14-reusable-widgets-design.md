# Reusable Widgets Extraction — Design

**Date:** 2026-06-14
**Status:** Approved
**Scope:** Extract app-wide reusable UI widgets out of feature packages into the shared `core` package.

## Goal

Remove duplicated UI scaffolding from feature packages by extracting genuinely
app-wide reusable widgets into `core/lib/components/`. Feature-specific widgets
(e.g. `ingredient_tile`, `recipe_card`, `home_greeting`) stay where they are.

## Conventions (existing, followed)

- Location: `core/lib/components/<category>/app_<name>.dart`
- Class name: `App<Name>`
- Imports: direct path `package:core/components/<category>/<file>.dart` (no barrel files in this project)
- Theme tokens from `package:core/theme/*` (`AppSpacing`, `AppColors`, `AppTypography`, `AppFontFamily`, `AppLayout`)

## Components to create

### 1. `bottom_sheet/app_bottom_sheet.dart`

`AppBottomSheet` — a scaffold wrapper for modal bottom sheets that standardizes
the chrome shared by all four existing sheets.

Responsibilities:
- `SafeArea(top: false)`
- Outer `Padding` of `fromLTRB(s5, s0, s5, s6)`
- Keyboard avoidance via `MediaQuery.viewInsetsOf(context).bottom`
- A `Column(mainAxisSize: min, crossAxisAlignment: stretch)` with configurable `spacing`
- A display-font title (`headlineMedium` + `AppFontFamily.display` + bold), optionally centered
- Optional circular close button (matches `pick_image_source_sheet`'s `_SheetHeader`)

Props:
- `String title`
- `List<Widget> children`
- `double spacing` (default `AppSpacing.s4`)
- `bool centerTitle` (default `false`)
- `bool showCloseButton` (default `false`)

Static helper:
- `static Future<T?> show<T>(BuildContext context, {required Widget child, bool isScrollControlled})`
  wrapping `showModalBottomSheet<T>` with `showDragHandle: true`.

Refactor targets (keep unique body, drop scaffold/header boilerplate):
- `features/fridge_scan/lib/presentation/widgets/add_ingredient_sheet.dart` (spacing s4, keyboard inset)
- `features/fridge_scan/lib/presentation/widgets/pick_image_source_sheet.dart` (spacing s3, close button)
- `features/profile/lib/presentation/widgets/dietary_preference_sheet.dart` (spacing s4)
- `features/recipes/lib/presentation/widgets/save_rate_sheet.dart` (spacing s4, centered title, keyboard inset)

Note: title styling is unified. Buttons inside each sheet keep their existing
treatment (raw `FilledButton.icon` / `AppSubmitButton`) — not normalized in this pass.

### 2. `dialog/app_confirm_dialog.dart`

`AppConfirmDialog` — an `AlertDialog` confirmation with a cancel + confirm action,
returning a `bool` (true = confirmed).

Props:
- `String title`
- `String message`
- `String cancelLabel` (default `'Cancel'`)
- `String confirmLabel`
- `bool isDestructive` (default `false`) — confirm button uses `AppColors.danger`

Layout: cancel = `TextButton` popping `false`; confirm = `FilledButton` popping `true`.

Static helper:
- `static Future<bool> show(BuildContext context, {required String title, required String message, String cancelLabel, required String confirmLabel, bool isDestructive})`
  — returns `false` when dismissed (coalesces the `?? false` callers do today).

Refactor targets:
- `_PermissionDeniedDialog` in `features/fridge_scan/lib/presentation/pages/scan/scan_page.dart`
  (title "Permission needed", confirm "Open settings", non-destructive)
- `_SignOutDialog` in `features/profile/lib/presentation/pages/profile/profile_page.dart`
  (title "Sign out?", confirm "Sign out", destructive)

### 3. `loader/app_loading_indicator.dart`

`AppLoadingIndicator` — `Center(child: CircularProgressIndicator())`. Const constructor.

Refactor targets (replace inline copies):
- `features/fridge_scan/lib/presentation/pages/scan/scan_page.dart:167`
- `features/recipes/lib/presentation/pages/cookbook/cookbook_page.dart:113`
- `features/recipes/lib/presentation/pages/saved_detail/saved_recipe_detail_page.dart:39` and `:55`

### 4. `text_field/app_email_field.dart`

`AppEmailField` — a pre-configured email `TextFormField`.

Defaults: `keyboardType: emailAddress`, `autofillHints: [email]`, `validator: Validators.email`,
decoration `labelText: 'Email', hintText: 'you@example.com', prefixIcon: Icon(Icons.mail_outline)`.

Props:
- `TextEditingController controller`
- `TextInputAction textInputAction` (default `next`)
- `ValueChanged<String>? onFieldSubmitted`
- `FormFieldValidator<String>? validator` (default `Validators.email`)

### 5. `text_field/app_password_field.dart`

`AppPasswordField` — a self-contained password `TextFormField` that owns its
show/hide (obscure) state internally.

Behavior:
- Internal `bool _obscure` toggled by a visibility `IconButton` suffix
  (`visibility_outlined` / `visibility_off_outlined`)
- Decoration `labelText: 'Password', prefixIcon: Icon(Icons.lock_outline)`

Props:
- `TextEditingController controller`
- `List<String> autofillHints` (e.g. `[AutofillHints.password]` vs `[AutofillHints.newPassword]`)
- `TextInputAction textInputAction` (default `done`)
- `ValueChanged<String>? onFieldSubmitted`
- `FormFieldValidator<String>? validator` (default `Validators.password`)

State-management consequence (approved): obscure state moves into the widget, so
remove from cubits/states:
- `SignInCubit.toggleObscurePassword()` + `obscurePassword` in `SignInState` + the `BlocSelector` in `sign_in_card.dart`
- `SignUpCubit.toggleObscurePassword()` + `obscurePassword` in `SignUpState` + the `BlocSelector` in `sign_up_card.dart`

Refactor targets for email/password fields:
- `features/auth/lib/presentation/pages/sign_in/widgets/sign_in_card.dart`
- `features/auth/lib/presentation/pages/sign_up/widgets/sign_up_card.dart`
- `features/auth/lib/presentation/pages/forgot_password/widgets/forgot_password_card.dart` (email only)

## Out of scope

- Feature-specific widgets remain in their feature packages.
- Normalizing in-sheet buttons to `AppSubmitButton`.
- Any non-UI / behavioral change beyond the password-obscure move noted above.

## Testing / verification

- `flutter analyze` clean across `core` and all touched feature packages.
- App builds and the refactored screens (auth, scan preview, profile, cookbook,
  recipe detail, the four sheets) render and behave identically.
