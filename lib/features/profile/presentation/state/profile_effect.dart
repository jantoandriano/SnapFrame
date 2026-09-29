sealed class ProfileEffect {
  const ProfileEffect();
}

class SubscribedEffect extends ProfileEffect {
  const SubscribedEffect();
}

class CancelledEffect extends ProfileEffect {
  const CancelledEffect();
}

class PlanFailedEffect extends ProfileEffect {
  const PlanFailedEffect(this.message);
  final String message;
}

/// Cancelling is the one destructive action here, so the view asks first.
class ConfirmCancelEffect extends ProfileEffect {
  const ConfirmCancelEffect();
}
