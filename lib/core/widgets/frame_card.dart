import 'package:flutter/material.dart';
import 'package:snapframe/core/theme/theme_extensions.dart';
import 'package:snapframe/core/theme/tokens.dart';
import 'package:snapframe/core/widgets/sticker_badge.dart';

/// A frame in the browse grid: bordered thumbnail with a hard shadow.
/// Pro-tier frames ([isPro]) always carry a "PRO ✦" sticker; locked frames
/// ([isLocked], pro frames the user can't use yet) also get a dark scrim and
/// a lock icon. Tapping still fires [onTap] — the caller decides whether
/// that opens the frame or the paywall.
class FrameCard extends StatelessWidget {
  const FrameCard({
    required this.title,
    this.thumbnail,
    this.isPro = false,
    this.isLocked = false,
    this.onTap,
    super.key,
  });

  final String title;
  final Widget? thumbnail;
  final bool isPro;
  final bool isLocked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Semantics(
      button: true,
      label: isLocked
          ? '$title, pro frame, locked'
          : isPro
          ? '$title, pro frame'
          : title,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        // Clips instead of showing the debug overflow banner on the rare
        // combination of narrow cell + large system text scale — the
        // image (AspectRatio, self-sizing) and the title (maxLines: 1)
        // are sized to fit comfortably in the normal case; this is only a
        // safety net, not the primary fix.
        child: ClipRect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 3 / 4,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: tokens.surface,
                    borderRadius: BorderRadius.circular(SnapRadius.md),
                    border: Border.all(
                      color: tokens.ink,
                      width: SnapTokens.borderWidth,
                    ),
                    boxShadow: [
                      BoxShadow(color: tokens.ink, offset: SnapShadow.offset),
                    ],
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      thumbnail ??
                          ColoredBox(
                            color: tokens.lilac.withValues(alpha: 0.4),
                            child: Icon(
                              Icons.photo_camera_back_outlined,
                              color: tokens.ink,
                              size: 40,
                            ),
                          ),
                      if (isLocked)
                        ColoredBox(
                          color: tokens.ink.withValues(alpha: 0.55),
                          child: const Center(
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      if (isPro || isLocked)
                        const Positioned(
                          top: SnapSpacing.sm,
                          right: SnapSpacing.sm,
                          child: StickerBadge(label: 'PRO ✦'),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: SnapSpacing.sm),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
