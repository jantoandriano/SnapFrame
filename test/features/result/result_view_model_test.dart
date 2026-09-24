import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/frames/data/sample_frame.dart';
import 'package:snapframe/features/result/data/result_providers.dart';
import 'package:snapframe/features/result/domain/save_share_repository.dart';
import 'package:snapframe/features/result/presentation/state/result_effect.dart';
import 'package:snapframe/features/result/presentation/view_models/result_view_model.dart';

class _MockSaveShareRepository extends Mock implements SaveShareRepository {}

void main() {
  late _MockSaveShareRepository repo;
  late ProviderContainer container;
  final jpeg = Uint8List.fromList([1, 2, 3]);

  setUpAll(() {
    registerFallbackValue(Uint8List(0));
  });

  setUp(() {
    repo = _MockSaveShareRepository();
    container = ProviderContainer(
      overrides: [saveShareRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
  });

  test('onSavePressed shows a success snack and clears isSaving', () async {
    when(() => repo.saveImage(any()))
        .thenAnswer((_) async => const Result.success(null));

    final provider = resultViewModelProvider(sampleFrame, jpeg);
    container.listen(provider, (_, _) {});

    await container.read(provider.notifier).onSavePressed();

    final state = container.read(provider);
    expect(state.isSaving, isFalse);
    expect(state.effect, isA<ShowResultSnackEffect>());
    expect((state.effect! as ShowResultSnackEffect).isError, isFalse);
  });

  test('onSavePressed shows an error snack on failure', () async {
    when(() => repo.saveImage(any())).thenAnswer(
      (_) async => const Result.failure(PermissionDeniedException('nope')),
    );

    final provider = resultViewModelProvider(sampleFrame, jpeg);
    container.listen(provider, (_, _) {});

    await container.read(provider.notifier).onSavePressed();

    final state = container.read(provider);
    expect(state.effect, isA<ShowResultSnackEffect>());
    expect((state.effect! as ShowResultSnackEffect).isError, isTrue);
    expect((state.effect! as ShowResultSnackEffect).message, 'nope');
  });

  void stubWhatsApp(Result<void> result) {
    when(
      () => repo.shareToWhatsApp(
        any(),
        phone: any(named: 'phone'),
        text: any(named: 'text'),
      ),
    ).thenAnswer((_) async => result);
  }

  test('sending to WhatsApp passes the normalized number, no snack', () async {
    stubWhatsApp(const Result.success(null));

    final provider = resultViewModelProvider(sampleFrame, jpeg);
    container.listen(provider, (_, _) {});
    final notifier = container.read(provider.notifier)
      ..onWhatsAppNumberChanged('+62 812-3456-7890');

    await notifier.onSendToWhatsAppPressed();

    final state = container.read(provider);
    expect(state.isSharing, isFalse);
    expect(state.effect, isNull);
    verify(
      () => repo.shareToWhatsApp(
        jpeg,
        phone: '6281234567890',
        text: any(named: 'text'),
      ),
    ).called(1);
  });

  test('an invalid number flags the field and sends nothing', () async {
    final provider = resultViewModelProvider(sampleFrame, jpeg);
    container.listen(provider, (_, _) {});
    final notifier = container.read(provider.notifier)
      ..onWhatsAppNumberChanged('081234567890');

    await notifier.onSendToWhatsAppPressed();

    expect(container.read(provider).whatsAppNumberInvalid, isTrue);
    verifyNever(
      () => repo.shareToWhatsApp(
        any(),
        phone: any(named: 'phone'),
        text: any(named: 'text'),
      ),
    );

    notifier.onWhatsAppNumberChanged('6281234567890');
    expect(container.read(provider).whatsAppNumberInvalid, isFalse);
  });

  test('a failed WhatsApp send shows an error snack', () async {
    stubWhatsApp(const Result.failure(NotFoundException('no WhatsApp')));

    final provider = resultViewModelProvider(sampleFrame, jpeg);
    container.listen(provider, (_, _) {});
    final notifier = container.read(provider.notifier)
      ..onWhatsAppNumberChanged('6281234567890');

    await notifier.onSendToWhatsAppPressed();

    final state = container.read(provider);
    expect(state.isSharing, isFalse);
    expect((state.effect! as ShowResultSnackEffect).isError, isTrue);
    expect((state.effect! as ShowResultSnackEffect).message, 'no WhatsApp');
  });

  test('onAgainPressed requests a fresh capture of the same frame', () {
    final provider = resultViewModelProvider(sampleFrame, jpeg);
    container.listen(provider, (_, _) {});

    container.read(provider.notifier).onAgainPressed();

    final state = container.read(provider);
    expect(state.effect, isA<AgainRequestedEffect>());
  });
}
