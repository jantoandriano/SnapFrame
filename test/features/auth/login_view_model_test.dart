import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/auth/data/auth_providers.dart';
import 'package:snapframe/features/auth/domain/auth_repository.dart';
import 'package:snapframe/features/auth/presentation/state/login_effect.dart';
import 'package:snapframe/features/auth/presentation/view_models/login_view_model.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository repo;
  late ProviderContainer container;

  setUp(() {
    repo = _MockAuthRepository();
    container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
  });

  test('sign-in success clears isSubmitting and signals the effect', () async {
    when(() => repo.signInWithEmail(any(), any()))
        .thenAnswer((_) async => const Result.success(null));

    container.listen(loginViewModelProvider, (_, _) {});
    final notifier = container.read(loginViewModelProvider.notifier)
      ..onEmailChanged('ren@snapframe.app')
      ..onPasswordChanged('hunter22');
    await notifier.onSubmitPressed();

    final state = container.read(loginViewModelProvider);
    expect(state.isSubmitting, isFalse);
    expect(state.effect, isA<LoginSucceededEffect>());
  });

  test('sign-in failure surfaces the error and no effect', () async {
    when(() => repo.signInWithEmail(any(), any())).thenAnswer(
      (_) async => const Result.failure(ValidationException('bad email')),
    );

    container.listen(loginViewModelProvider, (_, _) {});
    final notifier = container.read(loginViewModelProvider.notifier);
    await notifier.onSubmitPressed();

    final state = container.read(loginViewModelProvider);
    expect(state.isSubmitting, isFalse);
    expect(state.error, isA<ValidationException>());
    expect(state.effect, isNull);
  });

  test('sign-up mode calls signUpWithEmail with the display name', () async {
    when(() => repo.signUpWithEmail(any(), any(), any()))
        .thenAnswer((_) async => const Result.success(null));

    container.listen(loginViewModelProvider, (_, _) {});
    final notifier = container.read(loginViewModelProvider.notifier)
      ..onModeToggled()
      ..onEmailChanged('ren@snapframe.app')
      ..onPasswordChanged('hunter22')
      ..onDisplayNameChanged('Ren');
    await notifier.onSubmitPressed();

    verify(() => repo.signUpWithEmail('ren@snapframe.app', 'hunter22', 'Ren'))
        .called(1);
    verifyNever(() => repo.signInWithEmail(any(), any()));
  });
}
