import 'package:snapframe/features/frames/domain/frame.dart';

sealed class FrameDetailEffect {
  const FrameDetailEffect();
}

class UseFrameEffect extends FrameDetailEffect {
  const UseFrameEffect(this.frame);
  final Frame frame;
}

class ReportSentEffect extends FrameDetailEffect {
  const ReportSentEffect();
}
