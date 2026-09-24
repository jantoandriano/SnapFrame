// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginTitle => 'let\'s get snappy ✦';

  @override
  String get loginEmailLabel => 'email';

  @override
  String get loginPasswordLabel => 'password';

  @override
  String get loginDisplayNameLabel => 'display name';

  @override
  String get loginSignInButton => 'sign in';

  @override
  String get loginSignUpButton => 'create account';

  @override
  String get loginToggleToSignUp => 'new here? make an account';

  @override
  String get loginToggleToSignIn => 'already snappy? sign in';

  @override
  String get browseTitle => 'browse';

  @override
  String get browseTabOfficial => 'Official';

  @override
  String get browseTabCommunity => 'Community';

  @override
  String get browseFilterNewest => 'Newest';

  @override
  String get browseFilterPopular => 'Popular';

  @override
  String get browseFilterFree => 'Free';

  @override
  String get browseFilterPro => 'Pro';

  @override
  String get browseLockedSnack => 'go pro, unlock everything ✦';

  @override
  String get frameDetailUseThisFrame => 'use this frame';

  @override
  String get frameDetailReport => 'report';

  @override
  String get frameDetailReportSubmit => 'send report';

  @override
  String get frameDetailReportSent => 'reported, thanks for the heads up';

  @override
  String get frameDetailReportHint => 'what\'s off about this one?';

  @override
  String get frameDetailTimer => 'countdown timer';

  @override
  String frameDetailTimerSeconds(int seconds) {
    return '${seconds}s';
  }

  @override
  String frameDetailSlotCount(int count) {
    return '$count slots';
  }

  @override
  String get emptyCommunity =>
      'no frames yet… be the main character and make one';

  @override
  String get countdownEnd => 'say cheese 📸';

  @override
  String get retakeHint => 'tap a pic to redo it, no judgment';

  @override
  String get resultTitle => 'ate. 💅';

  @override
  String get resultSave => 'save';

  @override
  String get resultShare => 'send to WhatsApp';

  @override
  String get resultWhatsAppNumber => 'WhatsApp number';

  @override
  String get resultWhatsAppNumberHint =>
      'with country code, e.g. 6281234567890';

  @override
  String get resultWhatsAppNumberInvalid =>
      'add the country code, no leading 0';

  @override
  String get resultAgain => 'again!';

  @override
  String get reviewContinue => 'all good, let\'s go ✦';

  @override
  String captureSlotLabel(int current, int total) {
    return 'pic $current of $total';
  }

  @override
  String get paywallTitle => 'go pro, unlock everything ✦';

  @override
  String get errorGeneric => 'oops, something flopped. try again?';
}
