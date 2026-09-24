import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapframe/app/router.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/core/widgets/widgets.dart';
import 'package:snapframe/features/auth/presentation/state/login_effect.dart';
import 'package:snapframe/features/auth/presentation/view_models/login_view_model.dart';
import 'package:snapframe/l10n/app_localizations.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(loginViewModelProvider);
    final notifier = ref.read(loginViewModelProvider.notifier);

    ref.listen(loginViewModelProvider, (previous, next) {
      final effect = next.effect;
      if (effect == null) return;
      switch (effect) {
        case LoginSucceededEffect():
          notifier.clearEffect();
          const BrowseRoute().go(context);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(SnapSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.loginTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: SnapSpacing.xxl),
                if (state.isSignUpMode) ...[
                  BrutalTextField(
                    label: l10n.loginDisplayNameLabel,
                    onChanged: notifier.onDisplayNameChanged,
                  ),
                  const SizedBox(height: SnapSpacing.md),
                ],
                BrutalTextField(
                  label: l10n.loginEmailLabel,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: notifier.onEmailChanged,
                ),
                const SizedBox(height: SnapSpacing.md),
                BrutalTextField(
                  label: l10n.loginPasswordLabel,
                  obscureText: true,
                  errorText: state.error?.message,
                  onChanged: notifier.onPasswordChanged,
                ),
                const SizedBox(height: SnapSpacing.xl),
                ChunkyButton(
                  label: state.isSignUpMode
                      ? l10n.loginSignUpButton
                      : l10n.loginSignInButton,
                  onPressed: state.isSubmitting
                      ? null
                      : notifier.onSubmitPressed,
                ),
                const SizedBox(height: SnapSpacing.md),
                ChunkyButton(
                  label: state.isSignUpMode
                      ? l10n.loginToggleToSignIn
                      : l10n.loginToggleToSignUp,
                  variant: SnapButtonVariant.ghost,
                  onPressed: notifier.onModeToggled,
                ),
                const SizedBox(height: SnapSpacing.xxl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
