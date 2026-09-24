import 'dart:async';

import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/auth/domain/app_user.dart';
import 'package:snapframe/features/auth/domain/auth_repository.dart';
import 'package:snapframe/features/frames/domain/tier.dart';

final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

/// Stands in for `firebase_auth` + `users/{uid}` until a real Firebase
/// project is wired up (Milestone 3). Accepts any well-formed
/// email/password, no real account check — this is a UI/flow stub, not an
/// auth system.
class FakeAuthRepository implements AuthRepository {
  AppUser? _current;
  final StreamController<AppUser?> _changes = StreamController.broadcast();

  @override
  Stream<AppUser?> get currentUser async* {
    yield _current;
    yield* _changes.stream;
  }

  @override
  Future<Result<void>> signInWithEmail(String email, String password) async {
    final validation = _validate(email, password);
    if (validation != null) return Result.failure(validation);

    return await _signInAs(email, _displayNameFromEmail(email));
  }

  @override
  Future<Result<void>> signUpWithEmail(
    String email,
    String password,
    String displayName,
  ) async {
    final validation = _validate(email, password);
    if (validation != null) return Result.failure(validation);
    if (displayName.trim().isEmpty) {
      return const Result.failure(ValidationException('pick a display name'));
    }

    return await _signInAs(email, displayName.trim());
  }

  @override
  Future<Result<void>> signOut() async {
    _setCurrent(null);
    return const Result.success(null);
  }

  Future<Result<void>> _signInAs(String email, String displayName) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    _setCurrent(
      AppUser(
        uid: email.toLowerCase(),
        displayName: displayName,
        email: email,
        tier: Tier.free,
        createdAt: DateTime.now(),
      ),
    );
    return const Result.success(null);
  }

  void _setCurrent(AppUser? user) {
    _current = user;
    _changes.add(user);
  }

  AppException? _validate(String email, String password) {
    if (!_emailPattern.hasMatch(email)) {
      return const ValidationException("that email doesn't look right");
    }
    if (password.length < 6) {
      return const ValidationException('password needs 6+ characters');
    }
    return null;
  }

  String _displayNameFromEmail(String email) {
    final local = email.split('@').first;
    if (local.isEmpty) return local;
    return local[0].toUpperCase() + local.substring(1);
  }
}
