import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'NBA App'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @games.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get games;

  /// No description provided for @standings.
  ///
  /// In en, this message translates to:
  /// **'Standings'**
  String get standings;

  /// No description provided for @news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// No description provided for @store.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get store;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello, welcome'**
  String get hello;

  /// No description provided for @favoriteTeam.
  ///
  /// In en, this message translates to:
  /// **'Favorite team'**
  String get favoriteTeam;

  /// No description provided for @defaultNBA.
  ///
  /// In en, this message translates to:
  /// **'NBA Default'**
  String get defaultNBA;

  /// No description provided for @measurements.
  ///
  /// In en, this message translates to:
  /// **'Measurements'**
  String get measurements;

  /// No description provided for @kgCm.
  ///
  /// In en, this message translates to:
  /// **'Kg and cm'**
  String get kgCm;

  /// No description provided for @poundsInches.
  ///
  /// In en, this message translates to:
  /// **'Pounds and inches'**
  String get poundsInches;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @euro.
  ///
  /// In en, this message translates to:
  /// **'Euro (EUR)'**
  String get euro;

  /// No description provided for @usd.
  ///
  /// In en, this message translates to:
  /// **'US Dollar (USD)'**
  String get usd;

  /// No description provided for @gbp.
  ///
  /// In en, this message translates to:
  /// **'British Pound (GBP)'**
  String get gbp;

  /// No description provided for @brl.
  ///
  /// In en, this message translates to:
  /// **'Brazilian Real (BRL)'**
  String get brl;

  /// No description provided for @teamAlerts.
  ///
  /// In en, this message translates to:
  /// **'Team alerts'**
  String get teamAlerts;

  /// No description provided for @teamAlertsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Games and news from favorite team'**
  String get teamAlertsSubtitle;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'General app alerts'**
  String get notificationsSubtitle;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @chooseTeam.
  ///
  /// In en, this message translates to:
  /// **'Choose your team'**
  String get chooseTeam;

  /// No description provided for @measurementUnit.
  ///
  /// In en, this message translates to:
  /// **'Measurement unit'**
  String get measurementUnit;

  /// No description provided for @currencyPicker.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currencyPicker;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @portuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get portuguese;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @weightInKg.
  ///
  /// In en, this message translates to:
  /// **'Weight in kg'**
  String get weightInKg;

  /// No description provided for @heightInCm.
  ///
  /// In en, this message translates to:
  /// **'Height in cm'**
  String get heightInCm;

  /// No description provided for @weightInLb.
  ///
  /// In en, this message translates to:
  /// **'Weight in lb'**
  String get weightInLb;

  /// No description provided for @heightInIn.
  ///
  /// In en, this message translates to:
  /// **'Height in in'**
  String get heightInIn;

  /// No description provided for @pricesInEuros.
  ///
  /// In en, this message translates to:
  /// **'Prices in euros'**
  String get pricesInEuros;

  /// No description provided for @pricesInDollars.
  ///
  /// In en, this message translates to:
  /// **'Prices in dollars'**
  String get pricesInDollars;

  /// No description provided for @pricesInPounds.
  ///
  /// In en, this message translates to:
  /// **'Prices in pounds'**
  String get pricesInPounds;

  /// No description provided for @pricesInReais.
  ///
  /// In en, this message translates to:
  /// **'Prices in reais'**
  String get pricesInReais;
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
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
