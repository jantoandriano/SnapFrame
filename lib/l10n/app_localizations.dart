import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'let\'s get snappy ✦'**
  String get loginTitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'email'**
  String get loginEmailLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'password'**
  String get loginPasswordLabel;

  /// No description provided for @loginDisplayNameLabel.
  ///
  /// In en, this message translates to:
  /// **'display name'**
  String get loginDisplayNameLabel;

  /// No description provided for @loginSignInButton.
  ///
  /// In en, this message translates to:
  /// **'sign in'**
  String get loginSignInButton;

  /// No description provided for @loginSignUpButton.
  ///
  /// In en, this message translates to:
  /// **'create account'**
  String get loginSignUpButton;

  /// No description provided for @loginToggleToSignUp.
  ///
  /// In en, this message translates to:
  /// **'new here? make an account'**
  String get loginToggleToSignUp;

  /// No description provided for @loginToggleToSignIn.
  ///
  /// In en, this message translates to:
  /// **'already snappy? sign in'**
  String get loginToggleToSignIn;

  /// No description provided for @browseTitle.
  ///
  /// In en, this message translates to:
  /// **'browse'**
  String get browseTitle;

  /// No description provided for @browseTabOfficial.
  ///
  /// In en, this message translates to:
  /// **'Official'**
  String get browseTabOfficial;

  /// No description provided for @browseTabCommunity.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get browseTabCommunity;

  /// No description provided for @browseFilterNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get browseFilterNewest;

  /// No description provided for @browseFilterPopular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get browseFilterPopular;

  /// No description provided for @browseFilterFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get browseFilterFree;

  /// No description provided for @browseFilterPro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get browseFilterPro;

  /// No description provided for @browseLockedSnack.
  ///
  /// In en, this message translates to:
  /// **'go pro, unlock everything ✦'**
  String get browseLockedSnack;

  /// No description provided for @frameDetailUseThisFrame.
  ///
  /// In en, this message translates to:
  /// **'use this frame'**
  String get frameDetailUseThisFrame;

  /// No description provided for @frameDetailReport.
  ///
  /// In en, this message translates to:
  /// **'report'**
  String get frameDetailReport;

  /// No description provided for @frameDetailReportSubmit.
  ///
  /// In en, this message translates to:
  /// **'send report'**
  String get frameDetailReportSubmit;

  /// No description provided for @frameDetailReportSent.
  ///
  /// In en, this message translates to:
  /// **'reported, thanks for the heads up'**
  String get frameDetailReportSent;

  /// No description provided for @frameDetailReportHint.
  ///
  /// In en, this message translates to:
  /// **'what\'s off about this one?'**
  String get frameDetailReportHint;

  /// No description provided for @frameDetailTimer.
  ///
  /// In en, this message translates to:
  /// **'countdown timer'**
  String get frameDetailTimer;

  /// No description provided for @frameDetailTimerSeconds.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s'**
  String frameDetailTimerSeconds(int seconds);

  /// No description provided for @frameDetailSlotCount.
  ///
  /// In en, this message translates to:
  /// **'{count} slots'**
  String frameDetailSlotCount(int count);

  /// No description provided for @emptyCommunity.
  ///
  /// In en, this message translates to:
  /// **'no frames yet… be the main character and make one'**
  String get emptyCommunity;

  /// No description provided for @countdownEnd.
  ///
  /// In en, this message translates to:
  /// **'say cheese 📸'**
  String get countdownEnd;

  /// No description provided for @retakeHint.
  ///
  /// In en, this message translates to:
  /// **'tap a pic to redo it, no judgment'**
  String get retakeHint;

  /// No description provided for @resultTitle.
  ///
  /// In en, this message translates to:
  /// **'ate. 💅'**
  String get resultTitle;

  /// No description provided for @resultSave.
  ///
  /// In en, this message translates to:
  /// **'save'**
  String get resultSave;

  /// No description provided for @resultSaving.
  ///
  /// In en, this message translates to:
  /// **'saving…'**
  String get resultSaving;

  /// No description provided for @resultSaved.
  ///
  /// In en, this message translates to:
  /// **'saved!'**
  String get resultSaved;

  /// No description provided for @resultShare.
  ///
  /// In en, this message translates to:
  /// **'send to WhatsApp'**
  String get resultShare;

  /// No description provided for @resultWhatsAppNumber.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp number'**
  String get resultWhatsAppNumber;

  /// No description provided for @resultWhatsAppNumberHint.
  ///
  /// In en, this message translates to:
  /// **'with country code, e.g. 6281234567890'**
  String get resultWhatsAppNumberHint;

  /// No description provided for @resultWhatsAppNumberInvalid.
  ///
  /// In en, this message translates to:
  /// **'add the country code, no leading 0'**
  String get resultWhatsAppNumberInvalid;

  /// No description provided for @resultAgain.
  ///
  /// In en, this message translates to:
  /// **'again!'**
  String get resultAgain;

  /// No description provided for @reviewContinue.
  ///
  /// In en, this message translates to:
  /// **'all good, let\'s go ✦'**
  String get reviewContinue;

  /// No description provided for @captureGotIt.
  ///
  /// In en, this message translates to:
  /// **'got it! ✦'**
  String get captureGotIt;

  /// No description provided for @reviewSlotUpdated.
  ///
  /// In en, this message translates to:
  /// **'pic {n} updated ✦'**
  String reviewSlotUpdated(int n);

  /// No description provided for @captureSlotLabel.
  ///
  /// In en, this message translates to:
  /// **'pic {current} of {total}'**
  String captureSlotLabel(int current, int total);

  /// No description provided for @paywallTitle.
  ///
  /// In en, this message translates to:
  /// **'go pro, unlock everything ✦'**
  String get paywallTitle;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'oops, something flopped. try again?'**
  String get errorGeneric;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
