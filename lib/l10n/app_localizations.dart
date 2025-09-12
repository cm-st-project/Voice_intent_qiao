import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

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
    Locale('zh'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Voice Intent'**
  String get appTitle;

  /// The subtitle of the application
  ///
  /// In en, this message translates to:
  /// **'Social Communication Assistant'**
  String get appSubtitle;

  /// Description text on splash screen
  ///
  /// In en, this message translates to:
  /// **'Understanding emotions and social interactions'**
  String get splashDescription;

  /// Pragmatic Language feature title
  ///
  /// In en, this message translates to:
  /// **'Pragmatic\nLanguage'**
  String get pragmaticLanguage;

  /// Pragmatic Language feature description
  ///
  /// In en, this message translates to:
  /// **'Understand social language\nuse'**
  String get pragmaticLanguageDesc;

  /// Emotions in Speech feature title
  ///
  /// In en, this message translates to:
  /// **'Emotions in\nSpeech'**
  String get emotionsInSpeech;

  /// Emotions in Speech feature description
  ///
  /// In en, this message translates to:
  /// **'Analyze emotions\nin speech'**
  String get emotionsInSpeechDesc;

  /// Literal vs Figurative feature title
  ///
  /// In en, this message translates to:
  /// **'Literal v.s.\nFigurative'**
  String get literalVsFigurative;

  /// Literal vs Figurative feature description
  ///
  /// In en, this message translates to:
  /// **'Understand language meaning'**
  String get literalVsFigurativeDesc;

  /// Pragmatic Scenarios feature title
  ///
  /// In en, this message translates to:
  /// **'Pragmatic\nScenarios'**
  String get pragmaticScenarios;

  /// Pragmatic Scenarios feature description
  ///
  /// In en, this message translates to:
  /// **'Meaning Behind Words'**
  String get pragmaticScenariosDesc;

  /// Hint text for speech input field
  ///
  /// In en, this message translates to:
  /// **'Type or tap the microphone button to speak...'**
  String get speechInputHint;

  /// Message when speech recognition is not available
  ///
  /// In en, this message translates to:
  /// **'Speech recognition is not available'**
  String get speechNotAvailable;

  /// Title for activity selection section
  ///
  /// In en, this message translates to:
  /// **'Choose an Activity'**
  String get chooseActivity;

  /// Text shown when listening for speech
  ///
  /// In en, this message translates to:
  /// **'Listening...'**
  String get listening;

  /// Language switch button text
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSwitch;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Chinese language option
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get chinese;

  /// Title for emotion analysis screen
  ///
  /// In en, this message translates to:
  /// **'Emotion in Speech'**
  String get emotionInSpeech;

  /// Subtitle for voice recording section
  ///
  /// In en, this message translates to:
  /// **'Recording Your Voice'**
  String get recordingYourVoice;

  /// Instructions for voice recording
  ///
  /// In en, this message translates to:
  /// **'Speak naturally and we\'ll analyze the emotions in your voice'**
  String get speakNaturally;

  /// Title for literal vs figurative screen
  ///
  /// In en, this message translates to:
  /// **'Literal vs. Figurative'**
  String get literalVsFigurativeTitle;

  /// Subtitle for language types section
  ///
  /// In en, this message translates to:
  /// **'Understanding\nLanguage Types'**
  String get understandingLanguageTypes;

  /// Literal language type
  ///
  /// In en, this message translates to:
  /// **'Literal'**
  String get literal;

  /// Description of literal language
  ///
  /// In en, this message translates to:
  /// **'Direct meaning of words (e.g., \"It\'s raining\" means actual rain)'**
  String get literalDescription;

  /// Figurative language type
  ///
  /// In en, this message translates to:
  /// **'Figurative'**
  String get figurative;

  /// Description of figurative language
  ///
  /// In en, this message translates to:
  /// **'Symbolic or metaphorical meaning (e.g., It\'s raining cats and dogs)'**
  String get figurativeDescription;

  /// Sarcastic language type
  ///
  /// In en, this message translates to:
  /// **'Sarcastic'**
  String get sarcastic;

  /// Description of sarcastic language
  ///
  /// In en, this message translates to:
  /// **'Saying the opposite of what you mean (e.g., \"Great weather!\" during a storm)'**
  String get sarcasticDescription;

  /// Button text for analysis
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get analyze;

  /// Analysis section title
  ///
  /// In en, this message translates to:
  /// **'Type of Language'**
  String get typeOfLanguage;

  /// Analysis section title
  ///
  /// In en, this message translates to:
  /// **'What it Really Means'**
  String get whatItReallyMeans;

  /// Analysis section title
  ///
  /// In en, this message translates to:
  /// **'Why this Type?'**
  String get whyThisType;

  /// Analysis section title
  ///
  /// In en, this message translates to:
  /// **'How to Understand/\nRespond'**
  String get howToUnderstandRespond;

  /// Title for pragmatic language screen
  ///
  /// In en, this message translates to:
  /// **'Pragmatic Language'**
  String get pragmaticLanguageTitle;

  /// Subtitle for pragmatic language section
  ///
  /// In en, this message translates to:
  /// **' Understanding \n Pragmatic Language'**
  String get understandingPragmaticLanguage;

  /// Description of pragmatic language
  ///
  /// In en, this message translates to:
  /// **'Pragmatic language refers to how we use language in social situations.It includes understanding context, intent and social norms.'**
  String get pragmaticLanguageDescription;

  /// Analysis section title
  ///
  /// In en, this message translates to:
  /// **'Language Use'**
  String get languageUse;

  /// Analysis section title
  ///
  /// In en, this message translates to:
  /// **'Speaker\'s Intent'**
  String get speakerIntent;

  /// Analysis section title
  ///
  /// In en, this message translates to:
  /// **'What it Means'**
  String get whatItMeans;

  /// Analysis section title
  ///
  /// In en, this message translates to:
  /// **'Suggested Response'**
  String get suggestedResponse;

  /// Title for pragmatic scenarios screen
  ///
  /// In en, this message translates to:
  /// **'Pragmatic Scenarios'**
  String get pragmaticScenariosTitle;

  /// Scenario section title
  ///
  /// In en, this message translates to:
  /// **'Situation'**
  String get situation;

  /// Scenario section title
  ///
  /// In en, this message translates to:
  /// **'Expected Action'**
  String get expectedAction;

  /// Scenario section title
  ///
  /// In en, this message translates to:
  /// **'Why'**
  String get why;

  /// Scenario counter text
  ///
  /// In en, this message translates to:
  /// **'Scenario {current} of {total}'**
  String scenarioCounter(int current, int total);

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'VoiceIntent'**
  String get appName;

  /// Social Rules category name
  ///
  /// In en, this message translates to:
  /// **'Social Rules'**
  String get socialRules;

  /// Intentions category name
  ///
  /// In en, this message translates to:
  /// **'Intentions'**
  String get intentions;

  /// Contextual Awareness category name
  ///
  /// In en, this message translates to:
  /// **'Contextual Awareness'**
  String get contextualAwareness;

  /// Interpretation category name
  ///
  /// In en, this message translates to:
  /// **'Interpretation'**
  String get interpretation;

  /// Turn-taking subcategory
  ///
  /// In en, this message translates to:
  /// **'Turn-taking in conversation'**
  String get turnTakingInConversation;

  /// Turn-taking scenario description
  ///
  /// In en, this message translates to:
  /// **'You\'re having a conversation with a classmate who is telling a story. You want to add a comment.'**
  String get turnTakingDescription;

  /// Turn-taking expected action
  ///
  /// In en, this message translates to:
  /// **'Wait until they pause or finish, then say your comment.'**
  String get turnTakingAction;

  /// Turn-taking explanation
  ///
  /// In en, this message translates to:
  /// **'Taking turns shows respect and makes conversations enjoyable for both people.'**
  String get turnTakingWhy;
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
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
