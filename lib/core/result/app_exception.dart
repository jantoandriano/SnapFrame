/// Typed failures a repository can hand back inside a `Failure`. Kept
/// deliberately small — extend as new backend error shapes show up.
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;
}

final class NetworkException extends AppException {
  const NetworkException([super.message = 'no connection']);
}

final class NotFoundException extends AppException {
  const NotFoundException([super.message = 'not found']);
}

final class PermissionDeniedException extends AppException {
  const PermissionDeniedException([super.message = 'permission denied']);
}

final class ValidationException extends AppException {
  const ValidationException([super.message = 'invalid input']);
}

final class UnknownException extends AppException {
  const UnknownException([super.message = 'something went wrong']);
}
