import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/frames/data/fake_frames_data.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/frames/domain/frame_repository.dart';

/// Stands in for Firestore's `frames` collection until Milestone 3. Serves
/// the fixed seed list in `fake_frames_data.dart` — no real pagination,
/// since there's no real data volume yet to page through.
class FakeFrameRepository implements FrameRepository {
  @override
  Future<Result<List<Frame>>> fetchFrames({required bool official}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return Result.success(
      fakeFrames.where((f) => f.isOfficial == official).toList(),
    );
  }

  @override
  Future<Result<Frame>> fetchFrameById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final matches = fakeFrames.where((f) => f.id == id);
    if (matches.isEmpty) return const Result.failure(NotFoundException());
    return Result.success(matches.first);
  }

  @override
  Future<Result<void>> reportFrame(String frameId, String reason) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const Result.success(null);
  }
}
