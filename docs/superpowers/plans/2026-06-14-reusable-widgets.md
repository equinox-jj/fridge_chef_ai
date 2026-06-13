# Reusable Widgets Extraction Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Extract app-wide reusable UI widgets (loading indicator, confirm dialog, bottom-sheet scaffold, email/password fields) into the shared `core` package and refactor feature call-sites to use them.

**Architecture:** Pure-UI, dependency-free widgets in `core/lib/components/<category>/app_<name>.dart`, behavior driven entirely by constructor params. Feature widgets/pages import them by direct path and drop their duplicated scaffolding. The password field owns its obscure state, removing that flag from the auth cubits.

**Tech Stack:** Flutter, Melos monorepo, flutter_bloc, freezed (codegen via `melos run generate`).

**Testing note:** No UI/unit tests are written in this pass (per request). Verification is `flutter analyze` + app build/manual check. Code must stay testable: const constructors where possible, no hidden/global state, behavior via params.

---

## Conventions

- New files: `core/lib/components/<category>/app_<name>.dart`, class `App<Name>`.
- Import in features as `package:core/components/<category>/<file>.dart`.
- Theme tokens: `package:core/theme/app_spacing.dart`, `app_colors.dart`, `app_typography.dart`, `app_font_family.dart`, `app_layout.dart`.
- `context.textTheme` via `package:core/extensions/context_ext.dart`.
- Run analyze from repo root: `flutter analyze` (covers all packages in the workspace).

---

## Task 1: AppLoadingIndicator

**Files:**
- Create: `core/lib/components/loader/app_loading_indicator.dart`
- Modify: `features/fridge_scan/lib/presentation/pages/scan/scan_page.dart:167`
- Modify: `features/recipes/lib/presentation/pages/cookbook/cookbook_page.dart:113`
- Modify: `features/recipes/lib/presentation/pages/saved_detail/saved_recipe_detail_page.dart:39` and `:55`

- [ ] **Step 1: Create the widget**

```dart
import 'package:flutter/material.dart';

/// A centered [CircularProgressIndicator] for full-area loading states.
///
/// Pure UI — replaces the inline `Center(child: CircularProgressIndicator())`
/// repeated across feature pages.
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
```

- [ ] **Step 2: Refactor scan_page.dart**

Add import near the other `package:core/components/...` imports:
```dart
import 'package:core/components/loader/app_loading_indicator.dart';
```
Replace line 167 `return const Center(child: CircularProgressIndicator());` with:
```dart
                return const AppLoadingIndicator();
```

- [ ] **Step 3: Refactor cookbook_page.dart**

Add the same import. Replace line 113 with:
```dart
          return const AppLoadingIndicator();
```

- [ ] **Step 4: Refactor saved_recipe_detail_page.dart**

Add the same import. Replace both occurrences (`:39` and `:55`) of `const Center(child: CircularProgressIndicator())` with `const AppLoadingIndicator()`. Keep surrounding code identical (e.g. `if (recipe == null) return const AppLoadingIndicator();`).

- [ ] **Step 5: Analyze**

Run: `flutter analyze`
Expected: No new issues in the four files.

- [ ] **Step 6: Commit**

```bash
git add core/lib/components/loader/app_loading_indicator.dart \
  features/fridge_scan/lib/presentation/pages/scan/scan_page.dart \
  features/recipes/lib/presentation/pages/cookbook/cookbook_page.dart \
  features/recipes/lib/presentation/pages/saved_detail/saved_recipe_detail_page.dart
git commit -m "refactor: extract AppLoadingIndicator into core components"
```

---

## Task 2: AppConfirmDialog

**Files:**
- Create: `core/lib/components/dialog/app_confirm_dialog.dart`
- Modify: `features/fridge_scan/lib/presentation/pages/scan/scan_page.dart` (remove `_PermissionDeniedDialog`, update `_showSettingsDialog`)
- Modify: `features/profile/lib/presentation/pages/profile/profile_page.dart` (remove `_SignOutDialog`, update `_confirmSignOut`)

- [ ] **Step 1: Create the widget**

```dart
import 'package:core/theme/app_colors.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/material.dart';

/// A confirmation [AlertDialog] with a cancel and a confirm action.
///
/// Resolves to `true` when the user confirms and `false` when they cancel or
/// dismiss the dialog. Set [isDestructive] to colour the confirm button with
/// [AppColors.danger] for actions that drop data or sessions.
class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    super.key,
    this.cancelLabel = 'Cancel',
    this.isDestructive = false,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;

  /// Shows the dialog and resolves to `true` only when confirmed.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AppConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(cancelLabel),
        ),
        FilledButton(
          style: isDestructive
              ? FilledButton.styleFrom(backgroundColor: AppColors.danger)
              : null,
          onPressed: () => context.pop(true),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
```

- [ ] **Step 2: Refactor scan_page.dart `_showSettingsDialog`**

Add import:
```dart
import 'package:core/components/dialog/app_confirm_dialog.dart';
```
Replace the body of `_showSettingsDialog` so it uses the helper instead of `showDialog<bool>(... _PermissionDeniedDialog ...)`:
```dart
  Future<void> _showSettingsDialog(BuildContext context) async {
    final ScanBloc bloc = context.read<ScanBloc>();
    final bool openSettings = await AppConfirmDialog.show(
      context,
      title: 'Permission needed',
      message:
          'Capturing a fridge photo needs camera and photo access. Turn it on '
          'in Settings to continue.',
      cancelLabel: 'Not now',
      confirmLabel: 'Open settings',
    );
    if (openSettings) {
      bloc.add(const ScanEvent.settingsRequested());
    }
  }
```
Then delete the entire `_PermissionDeniedDialog` class at the bottom of the file (the `AlertDialog` with title "Permission needed").

- [ ] **Step 3: Refactor profile_page.dart `_confirmSignOut`**

Add import:
```dart
import 'package:core/components/dialog/app_confirm_dialog.dart';
```
Replace the body of `_confirmSignOut`:
```dart
  Future<void> _confirmSignOut(BuildContext context) async {
    final ProfileCubit cubit = context.read<ProfileCubit>();
    final bool confirmed = await AppConfirmDialog.show(
      context,
      title: 'Sign out?',
      message: "You'll need to sign in again to use your account.",
      confirmLabel: 'Sign out',
      isDestructive: true,
    );
    if (confirmed) {
      cubit.signOut();
    }
  }
```
Then delete the entire `_SignOutDialog` class at the bottom of the file.

- [ ] **Step 4: Check for now-unused imports**

In both files, remove any import only used by the deleted dialog classes (e.g. an `app_colors.dart` import in `profile_page.dart` if `AppColors` is no longer referenced). Leave imports still in use.

- [ ] **Step 5: Analyze**

Run: `flutter analyze`
Expected: No new issues; no "unused import" / "unused element" warnings for the removed dialogs.

- [ ] **Step 6: Commit**

```bash
git add core/lib/components/dialog/app_confirm_dialog.dart \
  features/fridge_scan/lib/presentation/pages/scan/scan_page.dart \
  features/profile/lib/presentation/pages/profile/profile_page.dart
git commit -m "refactor: extract AppConfirmDialog into core components"
```

---

## Task 3: AppBottomSheet (scaffold + header)

**Files:**
- Create: `core/lib/components/bottom_sheet/app_bottom_sheet.dart`
- Modify: `features/fridge_scan/lib/presentation/widgets/add_ingredient_sheet.dart`
- Modify: `features/fridge_scan/lib/presentation/widgets/pick_image_source_sheet.dart`
- Modify: `features/profile/lib/presentation/widgets/dietary_preference_sheet.dart`
- Modify: `features/recipes/lib/presentation/widgets/save_rate_sheet.dart`

- [ ] **Step 1: Create the widget**

```dart
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Standard chrome for the app's modal bottom sheets: a safe-area inset,
/// horizontal padding, keyboard avoidance, a display-font [title] (optionally
/// centered, optionally with a close button) and a vertically-stacked body.
///
/// Pure UI — callers supply only the [title] and the body [children]. Open it
/// with [AppBottomSheet.show] to get the shared drag-handle treatment.
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    required this.title,
    required this.children,
    super.key,
    this.spacing = AppSpacing.s4,
    this.centerTitle = false,
    this.showCloseButton = false,
  });

  final String title;
  final List<Widget> children;
  final double spacing;
  final bool centerTitle;
  final bool showCloseButton;

  /// Opens [child] as a modal bottom sheet with the app's drag-handle styling.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      showDragHandle: true,
      builder: (BuildContext context) => child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s5,
            AppSpacing.s0,
            AppSpacing.s5,
            AppSpacing.s6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: spacing,
            children: <Widget>[
              _Header(
                title: title,
                centerTitle: centerTitle,
                showCloseButton: showCloseButton,
              ),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

/// The sheet's display-font title, optionally centered and/or trailed by a
/// circular close button.
class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.centerTitle,
    required this.showCloseButton,
  });

  final String title;
  final bool centerTitle;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    final Text titleText = Text(
      title,
      textAlign: centerTitle ? TextAlign.center : TextAlign.start,
      style: context.textTheme.headlineMedium?.copyWith(
        fontFamily: AppFontFamily.display,
        fontWeight: AppFontWeight.bold,
      ),
    );

    if (!showCloseButton) return titleText;

    return Row(
      children: <Widget>[
        Expanded(child: titleText),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close_rounded),
          tooltip: 'Close',
          style: IconButton.styleFrom(
            backgroundColor: AppColors.backgroundTertiary,
            foregroundColor: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
```

- [ ] **Step 2: Refactor add_ingredient_sheet.dart**

Replace `openSheet` to use the helper:
```dart
  static Future<NewIngredient?> openSheet(BuildContext context) {
    return AppBottomSheet.show<NewIngredient>(
      context,
      child: const AddIngredientSheet(),
    );
  }
```
Replace the `build` method's returned tree (the `Padding > SafeArea > Padding > Column` with the `'Add an ingredient'` title) so the wrapper is `AppBottomSheet` and only the body widgets remain:
```dart
  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: 'Add an ingredient',
      children: <Widget>[
        TextField(
          controller: _nameController,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Name',
            hintText: 'e.g. mushrooms',
            prefixIcon: Icon(Icons.edit_outlined),
          ),
        ),
        Row(
          spacing: AppSpacing.s3,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: TextField(
                controller: _quantityController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  hintText: 'e.g. 200',
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _unitController,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                decoration: const InputDecoration(
                  labelText: 'Unit',
                  hintText: 'g',
                ),
              ),
            ),
          ],
        ),
        ValueListenableBuilder<IngredientCategory>(
          valueListenable: _category,
          builder: (_, IngredientCategory category, _) => _CategoryPicker(
            selected: category,
            onSelected: (IngredientCategory selected) => _category.value = selected,
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _canSubmit,
          builder: (_, bool canSubmit, _) => FilledButton.icon(
            onPressed: canSubmit ? _submit : null,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add ingredient'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(AppLayout.tapTarget),
            ),
          ),
        ),
      ],
    );
  }
```
Add import `import 'package:core/components/bottom_sheet/app_bottom_sheet.dart';`. Remove now-unused imports (`go_router`, `app_font_family`; keep `app_layout`, `app_spacing`, `app_typography`, `app_colors` — still used by `_CategoryPicker` and the Row spacing). Verify against analyzer in Step 6. Keep `_CategoryPicker` unchanged.

- [ ] **Step 3: Refactor pick_image_source_sheet.dart**

Replace `openSheet`:
```dart
  static Future<ImageSourceOption?> openSheet(BuildContext context) {
    return AppBottomSheet.show<ImageSourceOption>(
      context,
      child: const PickImageSourceSheet(),
      isScrollControlled: false,
    );
  }
```
Replace `build` to use `AppBottomSheet` with `spacing: AppSpacing.s3` and `showCloseButton: true`, keeping the two action buttons and the note. Delete the local `_SheetHeader` class (now provided by `AppBottomSheet`):
```dart
  @override
  Widget build(BuildContext context) {
    const Size actionSize = Size.fromHeight(_actionHeight);
    final TextStyle? actionTextStyle = context.textTheme.titleMedium?.copyWith(
      fontSize: AppTextSize.lg,
      fontWeight: AppFontWeight.semiBold,
    );

    return AppBottomSheet(
      title: 'Add a photo',
      spacing: AppSpacing.s3,
      showCloseButton: true,
      children: <Widget>[
        FilledButton.icon(
          onPressed: () => context.pop(ImageSourceOption.camera),
          icon: const Icon(Icons.photo_camera_rounded),
          label: const Text('Take a photo'),
          style: FilledButton.styleFrom(
            minimumSize: actionSize,
            textStyle: actionTextStyle,
          ),
        ),
        OutlinedButton.icon(
          onPressed: () => context.pop(ImageSourceOption.gallery),
          icon: const Icon(Icons.photo_library_rounded),
          label: const Text('Choose from gallery'),
          style: OutlinedButton.styleFrom(
            minimumSize: actionSize,
            textStyle: actionTextStyle,
            foregroundColor: AppColors.textPrimary,
            backgroundColor: AppColors.surfaceCard,
            side: const BorderSide(color: AppColors.borderStrong),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.s1),
          child: Text(
            'Photos are compressed to 1280px before scanning.',
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.textFaint,
            ),
          ),
        ),
      ],
    );
  }
```
Add the `app_bottom_sheet.dart` import. Remove now-unused `app_font_family.dart` import (only the deleted `_SheetHeader` used it). Keep `go_router` (used by `context.pop`).

- [ ] **Step 4: Refactor dietary_preference_sheet.dart**

Replace `openSheet`:
```dart
  static Future<DietaryPreference?> openSheet(
    BuildContext context, {
    required DietaryPreference current,
  }) {
    return AppBottomSheet.show<DietaryPreference>(
      context,
      child: DietaryPreferenceSheet(current: current),
    );
  }
```
Replace `build`:
```dart
  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: 'Dietary preference',
      children: <Widget>[
        Text(
          'Applied to every recipe Gemini writes for you.',
          style: context.textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
        ),
        ValueListenableBuilder<DietaryPreference>(
          valueListenable: _selected,
          builder: (_, DietaryPreference selected, _) => DietaryPreferenceChips(
            selected: selected,
            onSelected: (DietaryPreference diet) => _selected.value = diet,
          ),
        ),
        AppSubmitButton(
          label: 'Save',
          icon: Icons.check_rounded,
          onPressed: _save,
        ),
      ],
    );
  }
```
Add the `app_bottom_sheet.dart` import. Remove now-unused `app_font_family.dart` import. Keep the rest.

- [ ] **Step 5: Refactor save_rate_sheet.dart**

Replace `openSheet`:
```dart
  static Future<RecipeRating?> openSheet(BuildContext context) {
    return AppBottomSheet.show<RecipeRating>(
      context,
      child: const SaveRateSheet(),
    );
  }
```
Replace `build` with `AppBottomSheet(title: 'Save to cookbook', centerTitle: true, ...)`, keeping the subtitle, star control, note field and Done button:
```dart
  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: 'Save to cookbook',
      centerTitle: true,
      children: <Widget>[
        Text(
          'How did it turn out?',
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
        ),
        Center(
          child: ValueListenableBuilder<int>(
            valueListenable: _stars,
            builder: (_, int stars, _) => AppStarRating(
              value: stars,
              size: AppStarRatingSize.lg,
              onChanged: (int value) => _stars.value = value,
            ),
          ),
        ),
        TextField(
          controller: _noteController,
          textCapitalization: TextCapitalization.sentences,
          minLines: 1,
          maxLines: 3,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _submit(),
          decoration: const InputDecoration(
            labelText: 'Add a note (optional)',
            hintText: 'Great with extra lemon…',
          ),
        ),
        ValueListenableBuilder<int>(
          valueListenable: _stars,
          builder: (_, int stars, _) => FilledButton.icon(
            onPressed: stars > 0 ? _submit : null,
            icon: const Icon(Icons.check_rounded),
            label: const Text('Done'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(AppLayout.tapTarget),
            ),
          ),
        ),
      ],
    );
  }
```
Add the `app_bottom_sheet.dart` import. Remove now-unused `app_font_family.dart` import. Keep `app_layout`, `app_spacing`, `app_typography`, `app_colors`, `go_router`, `app_star_rating`.

- [ ] **Step 6: Analyze**

Run: `flutter analyze`
Expected: No new issues. Resolve any "unused import" warnings the analyzer flags in the four sheets.

- [ ] **Step 7: Commit**

```bash
git add core/lib/components/bottom_sheet/app_bottom_sheet.dart \
  features/fridge_scan/lib/presentation/widgets/add_ingredient_sheet.dart \
  features/fridge_scan/lib/presentation/widgets/pick_image_source_sheet.dart \
  features/profile/lib/presentation/widgets/dietary_preference_sheet.dart \
  features/recipes/lib/presentation/widgets/save_rate_sheet.dart
git commit -m "refactor: extract AppBottomSheet scaffold into core components"
```

---

## Task 4: AppEmailField + AppPasswordField

**Files:**
- Create: `core/lib/components/text_field/app_email_field.dart`
- Create: `core/lib/components/text_field/app_password_field.dart`

- [ ] **Step 1: Create AppEmailField**

```dart
import 'package:core/utils/validators.dart';
import 'package:flutter/material.dart';

/// A pre-configured email [TextFormField]: email keyboard, email autofill, the
/// standard mail-icon decoration and [Validators.email] by default.
class AppEmailField extends StatelessWidget {
  const AppEmailField({
    required this.controller,
    super.key,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.validator,
  });

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      autofillHints: const <String>[AutofillHints.email],
      validator: validator ?? Validators.email,
      onFieldSubmitted: onFieldSubmitted,
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'you@example.com',
        prefixIcon: Icon(Icons.mail_outline),
      ),
    );
  }
}
```

- [ ] **Step 2: Create AppPasswordField**

Self-contained obscure toggle, so call-sites no longer track obscure state.
```dart
import 'package:core/utils/validators.dart';
import 'package:flutter/material.dart';

/// A password [TextFormField] that owns its show/hide state internally,
/// rendering a visibility toggle in the suffix. Defaults to [Validators.password].
///
/// Pass [autofillHints] of `[AutofillHints.password]` for sign-in or
/// `[AutofillHints.newPassword]` for registration.
class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    required this.controller,
    super.key,
    this.autofillHints = const <String>[AutofillHints.password],
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.validator,
  });

  final TextEditingController controller;
  final List<String> autofillHints;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscure = true;

  void _toggle() => setState(() => _obscure = !_obscure);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      validator: widget.validator ?? Validators.password,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          ),
          onPressed: _toggle,
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Analyze**

Run: `flutter analyze`
Expected: No issues in the two new files.

- [ ] **Step 4: Commit**

```bash
git add core/lib/components/text_field/app_email_field.dart \
  core/lib/components/text_field/app_password_field.dart
git commit -m "feat: add AppEmailField and AppPasswordField to core components"
```

---

## Task 5: Adopt the fields in auth cards + drop obscure state from cubits

**Files:**
- Modify: `features/auth/lib/presentation/pages/sign_in/widgets/sign_in_card.dart`
- Modify: `features/auth/lib/presentation/pages/sign_up/widgets/sign_up_card.dart`
- Modify: `features/auth/lib/presentation/pages/forgot_password/widgets/forgot_password_card.dart`
- Modify: `features/auth/lib/presentation/pages/sign_in/cubit/sign_in_state.dart`
- Modify: `features/auth/lib/presentation/pages/sign_in/cubit/sign_in_cubit.dart`
- Modify: `features/auth/lib/presentation/pages/sign_up/cubit/sign_up_state.dart`
- Modify: `features/auth/lib/presentation/pages/sign_up/cubit/sign_up_cubit.dart`

- [ ] **Step 1: Refactor sign_in_card.dart**

Add imports:
```dart
import 'package:core/components/text_field/app_email_field.dart';
import 'package:core/components/text_field/app_password_field.dart';
```
Replace the email `TextFormField` with:
```dart
            AppEmailField(controller: _emailController),
```
Replace the entire `BlocSelector<SignInCubit, SignInState, bool>(...)` password block with:
```dart
            AppPasswordField(
              controller: _passwordController,
              autofillHints: const <String>[AutofillHints.password],
              onFieldSubmitted: (_) => _submit(),
            ),
```
Remove now-unused imports: `app_typography.dart` and `app_colors.dart` are still used by the "Forgot password?" link styling — keep them. Remove `validators.dart` only if `Validators` is no longer referenced (it is not, after both fields move to defaults) — confirm via analyzer in Step 6. Keep `bloc.dart` (still used by the submit `BlocBuilder`).

- [ ] **Step 2: Refactor sign_up_card.dart**

Add the two field imports. Replace the email `TextFormField` with `AppEmailField(controller: _emailController)`. Replace the password `BlocSelector` block with:
```dart
            AppPasswordField(
              controller: _passwordController,
              autofillHints: const <String>[AutofillHints.newPassword],
              onFieldSubmitted: (_) => _submit(),
            ),
```
Leave the name `TextFormField` as-is (it uses `Validators.required`, so keep the `validators.dart` import). Confirm unused imports via analyzer.

- [ ] **Step 3: Refactor forgot_password_card.dart (email only)**

Add `import 'package:core/components/text_field/app_email_field.dart';`. Replace the email `TextFormField` with:
```dart
            AppEmailField(
              controller: _emailController,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
            ),
```
Keep everything else. Remove `validators.dart` import only if no longer used (analyzer-confirmed).

- [ ] **Step 4: Remove obscure from sign_in cubit/state**

In `sign_in_state.dart`, delete the line:
```dart
    @Default(true) bool obscurePassword,
```
In `sign_in_cubit.dart`, delete the method:
```dart
  void toggleObscurePassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }
```

- [ ] **Step 5: Remove obscure from sign_up cubit/state**

In `sign_up_state.dart`, delete `@Default(true) bool obscurePassword,`.
In `sign_up_cubit.dart`, delete the `toggleObscurePassword` method (identical to Step 4's).

- [ ] **Step 6: Regenerate freezed code**

Run: `melos run generate`
Expected: `sign_in_state.freezed.dart` and `sign_up_state.freezed.dart` rebuild without the `obscurePassword` field; no errors.

- [ ] **Step 7: Analyze**

Run: `flutter analyze`
Expected: No issues. In particular, no references remain to `obscurePassword` or `toggleObscurePassword`, and no unused imports linger in the three cards.

- [ ] **Step 8: Commit**

```bash
git add features/auth/lib/presentation/pages/sign_in \
  features/auth/lib/presentation/pages/sign_up \
  features/auth/lib/presentation/pages/forgot_password
git commit -m "refactor: adopt AppEmailField/AppPasswordField, drop obscure state from auth cubits"
```

---

## Final verification

- [ ] **Run analyze across the workspace**

Run: `flutter analyze`
Expected: No new warnings/errors introduced by this work.

- [ ] **Build / smoke check**

Run the app and confirm these screens look and behave the same as before:
- Sign in, sign up, forgot password (fields, password show/hide toggle, validation)
- Scan preview (loading spinner, "Permission needed" dialog → Open settings)
- Profile (Sign out confirmation → destructive button)
- The four bottom sheets: add ingredient, pick image source (close button), dietary preference, save & rate (centered title)
- Cookbook + saved recipe detail loading states

---

## Self-review notes

- **Spec coverage:** all five components (loader, dialog, bottom sheet, email field, password field) and every refactor target listed in the spec map to a task. Password obscure-state removal covered in Task 5.
- **Type consistency:** helper names used consistently — `AppBottomSheet.show<T>(context, child:)`, `AppConfirmDialog.show(context, ...) -> Future<bool>`, field constructors take `controller` + optional `validator`/`onFieldSubmitted`.
- **Codegen:** freezed regeneration (`melos run generate`) is an explicit step after editing the `@freezed` states.
