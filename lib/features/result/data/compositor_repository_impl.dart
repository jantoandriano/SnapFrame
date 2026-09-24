import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:snapframe/core/compositing/composite_request.dart';
import 'package:snapframe/core/compositing/compositor.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/result/domain/compositor_repository.dart';

class CompositorRepositoryImpl implements CompositorRepository {
  @override
  Future<Result<Uint8List>> compose({
    required Frame frame,
    required List<XFile> photos,
  }) async {
    try {
      // Every frame right now is the bundled sample, loaded as a plain
      // asset. Once frames come from Firestore (M3), a real frame's
      // overlayPath is a Storage path, not an asset one — this is the
      // point that'll need a cached-download step added.
      final overlayBytes = (await rootBundle.load(frame.overlayPath)).buffer
          .asUint8List();
      final photoBytes = [
        for (final photo in photos) await photo.readAsBytes(),
      ];

      final jpeg = await compositeFrame(
        CompositeRequest(
          overlayBytes: overlayBytes,
          photoBytes: photoBytes,
          slots: frame.slots,
          width: frame.width,
          height: frame.height,
        ),
      );
      return Result.success(jpeg);
    } on Object catch (e) {
      return Result.failure(UnknownException(e.toString()));
    }
  }
}
