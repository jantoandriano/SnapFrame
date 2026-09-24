import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapframe/features/frames/domain/tier.dart';

part 'app_user.freezed.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    required String displayName,
    required String email,
    required Tier tier,
    required DateTime createdAt,
    String? photoUrl,
    DateTime? proExpiresAt,
  }) = _AppUser;
}
