import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/auth/data/auth_providers.dart';
import 'package:snapframe/features/auth/domain/app_user.dart';
import 'package:snapframe/features/auth/domain/auth_repository.dart';
import 'package:snapframe/features/frames/data/frame_providers.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/frames/domain/frame_repository.dart';
import 'package:snapframe/features/frames/domain/frame_status.dart';
import 'package:snapframe/features/frames/domain/frame_visibility.dart';
import 'package:snapframe/features/frames/domain/slot.dart';
import 'package:snapframe/features/frames/domain/tier.dart';
import 'package:snapframe/features/frames/presentation/state/browse_effect.dart';
import 'package:snapframe/features/frames/presentation/state/browse_filter.dart';
import 'package:snapframe/features/frames/presentation/view_models/browse_view_model.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockFrameRepository extends Mock implements FrameRepository {}

Frame _frame(
  String id, {
  required bool official,
  required Tier tier,
  int usageCount = 0,
}) {
  return Frame(
    id: id,
    title: id,
    ownerId: 'owner',
    isOfficial: official,
    visibility: FrameVisibility.public,
    tier: tier,
    overlayPath: 'assets/frames/sample_overlay.png',
    thumbnailPath: 'assets/frames/sample_overlay.png',
    width: 100,
    height: 100,
    slots: const [Slot(x: 0, y: 0, w: 1, h: 1)],
    countdownSec: 3,
    status: FrameStatus.approved,
    usageCount: usageCount,
    reportCount: 0,
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
  );
}

void main() {
  // onTabChanged fires a haptic, which needs a binding even though this
  // is a plain (non-widget) test.
  TestWidgetsFlutterBinding.ensureInitialized();

  late _MockAuthRepository authRepo;
  late _MockFrameRepository frameRepo;
  late ProviderContainer container;

  setUp(() {
    authRepo = _MockAuthRepository();
    frameRepo = _MockFrameRepository();
    when(() => authRepo.currentUser).thenAnswer((_) => const Stream.empty());
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepo),
        frameRepositoryProvider.overrideWithValue(frameRepo),
      ],
    );
    addTearDown(container.dispose);
  });

  test('loads the official tab on build', () async {
    final official = [_frame('o1', official: true, tier: Tier.free)];
    when(() => frameRepo.fetchFrames(official: true))
        .thenAnswer((_) async => Result.success(official));

    container.listen(browseViewModelProvider, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 50));

    final state = container.read(browseViewModelProvider);
    expect(state.isLoading, isFalse);
    expect(state.frames.map((f) => f.id), ['o1']);
  });

  test('switching tabs fetches the community list', () async {
    when(() => frameRepo.fetchFrames(official: true))
        .thenAnswer((_) async => const Result.success([]));
    final community = [_frame('c1', official: false, tier: Tier.free)];
    when(() => frameRepo.fetchFrames(official: false))
        .thenAnswer((_) async => Result.success(community));

    container.listen(browseViewModelProvider, (_, _) {});
    final notifier = container.read(browseViewModelProvider.notifier);
    await Future<void>.delayed(const Duration(milliseconds: 50));

    notifier.onTabChanged(1);
    await Future<void>.delayed(const Duration(milliseconds: 50));

    final state = container.read(browseViewModelProvider);
    expect(state.tabIndex, 1);
    expect(state.frames.map((f) => f.id), ['c1']);
  });

  test('Pro filter keeps only pro frames', () async {
    final frames = [
      _frame('free1', official: true, tier: Tier.free),
      _frame('pro1', official: true, tier: Tier.pro),
    ];
    when(() => frameRepo.fetchFrames(official: true))
        .thenAnswer((_) async => Result.success(frames));

    container.listen(browseViewModelProvider, (_, _) {});
    final notifier = container.read(browseViewModelProvider.notifier);
    await Future<void>.delayed(const Duration(milliseconds: 50));

    notifier.onFilterSelected(BrowseFilter.pro);

    final state = container.read(browseViewModelProvider);
    expect(state.frames.map((f) => f.id), ['pro1']);
  });

  test(
    'tapping a locked pro frame shows the paywall snack, not detail',
    () async {
      when(() => frameRepo.fetchFrames(official: true))
          .thenAnswer((_) async => const Result.success([]));

      container.listen(browseViewModelProvider, (_, _) {});
      final notifier = container.read(browseViewModelProvider.notifier);
      await Future<void>.delayed(const Duration(milliseconds: 50));

      final proFrame = _frame('pro1', official: true, tier: Tier.pro);
      notifier.onFrameTapped(proFrame);

      final state = container.read(browseViewModelProvider);
      expect(state.effect, isA<ShowLockedSnackEffect>());
    },
  );

  test('tapping a free frame opens frame detail', () async {
    when(() => frameRepo.fetchFrames(official: true))
        .thenAnswer((_) async => const Result.success([]));

    container.listen(browseViewModelProvider, (_, _) {});
    final notifier = container.read(browseViewModelProvider.notifier);
    await Future<void>.delayed(const Duration(milliseconds: 50));

    final freeFrame = _frame('free1', official: true, tier: Tier.free);
    notifier.onFrameTapped(freeFrame);

    final state = container.read(browseViewModelProvider);
    expect(state.effect, isA<OpenFrameDetailEffect>());
    expect((state.effect! as OpenFrameDetailEffect).frame.id, 'free1');
  });

  test('a pro user is never shown the locked snack', () async {
    final proUser = AppUser(
      uid: 'u',
      displayName: 'Ren',
      email: 'ren@snapframe.app',
      tier: Tier.pro,
      createdAt: DateTime.utc(2026),
    );
    when(() => authRepo.currentUser).thenAnswer((_) => Stream.value(proUser));
    when(() => frameRepo.fetchFrames(official: true))
        .thenAnswer((_) async => const Result.success([]));

    container.listen(browseViewModelProvider, (_, _) {});
    final notifier = container.read(browseViewModelProvider.notifier);
    await Future<void>.delayed(const Duration(milliseconds: 50));

    notifier.onFrameTapped(_frame('pro1', official: true, tier: Tier.pro));

    final state = container.read(browseViewModelProvider);
    expect(state.effect, isA<OpenFrameDetailEffect>());
  });
}
