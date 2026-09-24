import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/features/frames/data/fake_frame_repository.dart';
import 'package:snapframe/features/frames/domain/frame_repository.dart';

part 'frame_providers.g.dart';

@riverpod
FrameRepository frameRepository(Ref ref) => FakeFrameRepository();
