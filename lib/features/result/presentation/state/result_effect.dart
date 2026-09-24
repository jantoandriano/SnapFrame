sealed class ResultEffect {
  const ResultEffect();
}

class ShowResultSnackEffect extends ResultEffect {
  const ShowResultSnackEffect(this.message, {this.isError = false});
  final String message;
  final bool isError;
}

/// "again!" — the view owns navigation, so it resets back to a fresh
/// capture of the same frame.
class AgainRequestedEffect extends ResultEffect {
  const AgainRequestedEffect();
}
