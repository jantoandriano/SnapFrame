import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/frames/domain/frame.dart';

abstract interface class FrameRepository {
  Future<Result<List<Frame>>> fetchFrames({required bool official});

  Future<Result<Frame>> fetchFrameById(String id);

  Future<Result<void>> reportFrame(String frameId, String reason);
}
