import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/frames/data/frame_providers.dart';
import 'package:snapframe/features/frames/data/sample_frame.dart';
import 'package:snapframe/features/frames/domain/frame_repository.dart';
import 'package:snapframe/features/frames/presentation/state/frame_detail_effect.dart';
import 'package:snapframe/features/frames/presentation/view_models/frame_detail_view_model.dart';

class _MockFrameRepository extends Mock implements FrameRepository {}

void main() {
  late _MockFrameRepository repo;
  late ProviderContainer container;

  setUp(() {
    repo = _MockFrameRepository();
    container = ProviderContainer(
      overrides: [frameRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
  });

  test('onUseThisFramePressed signals the frame to capture with', () {
    final provider = frameDetailViewModelProvider(sampleFrame);
    container.listen(provider, (_, _) {});

    container.read(provider.notifier).onUseThisFramePressed();

    final state = container.read(provider);
    expect(state.effect, isA<UseFrameEffect>());
    expect((state.effect! as UseFrameEffect).frame, sampleFrame);
  });

  test(
    'a successful report clears isSubmittingReport and signals sent',
    () async {
      when(() => repo.reportFrame(any(), any()))
          .thenAnswer((_) async => const Result.success(null));

      final provider = frameDetailViewModelProvider(sampleFrame);
      container.listen(provider, (_, _) {});
      final notifier = container.read(provider.notifier);

      await notifier.onReportSubmitted('spam');

      final state = container.read(provider);
      expect(state.isSubmittingReport, isFalse);
      expect(state.effect, isA<ReportSentEffect>());
      verify(() => repo.reportFrame(sampleFrame.id, 'spam')).called(1);
    },
  );

  test('a failed report surfaces the error, no effect', () async {
    when(
      () => repo.reportFrame(any(), any()),
    ).thenAnswer((_) async => const Result.failure(UnknownException('nope')));

    final provider = frameDetailViewModelProvider(sampleFrame);
    container.listen(provider, (_, _) {});
    final notifier = container.read(provider.notifier);

    await notifier.onReportSubmitted('spam');

    final state = container.read(provider);
    expect(state.isSubmittingReport, isFalse);
    expect(state.error, isA<UnknownException>());
    expect(state.effect, isNull);
  });
}
