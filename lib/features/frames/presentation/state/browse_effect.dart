import 'package:snapframe/features/frames/domain/frame.dart';

sealed class BrowseEffect {
  const BrowseEffect();
}

class OpenFrameDetailEffect extends BrowseEffect {
  const OpenFrameDetailEffect(this.frame);
  final Frame frame;
}

class ShowLockedSnackEffect extends BrowseEffect {
  const ShowLockedSnackEffect();
}
