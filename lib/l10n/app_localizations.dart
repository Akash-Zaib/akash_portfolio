import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ur.dart';

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
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ur'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Akash Zaib Malik - Portfolio'**
  String get appTitle;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get navAbout;

  /// No description provided for @navProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get navProjects;

  /// No description provided for @navExperience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get navExperience;

  /// No description provided for @navSkills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get navSkills;

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get navContact;

  /// No description provided for @heroName.
  ///
  /// In en, this message translates to:
  /// **'Akash Zaib Malik'**
  String get heroName;

  /// No description provided for @heroRole.
  ///
  /// In en, this message translates to:
  /// **'Mobile App Developer (Flutter)'**
  String get heroRole;

  /// No description provided for @heroTagFlutter.
  ///
  /// In en, this message translates to:
  /// **'Flutter'**
  String get heroTagFlutter;

  /// No description provided for @heroTagDart.
  ///
  /// In en, this message translates to:
  /// **'Dart'**
  String get heroTagDart;

  /// No description provided for @heroTagFirebase.
  ///
  /// In en, this message translates to:
  /// **'Firebase'**
  String get heroTagFirebase;

  /// No description provided for @heroTagUIUX.
  ///
  /// In en, this message translates to:
  /// **'UI/UX Design'**
  String get heroTagUIUX;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get aboutTitle;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Flutter Developer with hands-on experience building scalable, high-performance mobile applications using Flutter and Dart. Strong expertise in state management (Provider, GetX, Riverpod, MobX), Clean Architecture, and responsive UI design. Experienced in developing AI-based mobile applications with advanced features such as voice recognition, 3D animations, audio synchronization. Passionate about delivering smooth, interactive, and user-centric mobile experiences.'**
  String get aboutDescription;

  /// No description provided for @aboutEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get aboutEducation;

  /// No description provided for @aboutEducationDegree.
  ///
  /// In en, this message translates to:
  /// **'BS in Computer Science'**
  String get aboutEducationDegree;

  /// No description provided for @aboutEducationUniversity.
  ///
  /// In en, this message translates to:
  /// **'Government College University, Faisalabad'**
  String get aboutEducationUniversity;

  /// No description provided for @aboutEducationCGPA.
  ///
  /// In en, this message translates to:
  /// **'CGPA: 3.43/4'**
  String get aboutEducationCGPA;

  /// No description provided for @aboutLocation.
  ///
  /// In en, this message translates to:
  /// **'Islamabad, Pakistan'**
  String get aboutLocation;

  /// No description provided for @aboutPhone.
  ///
  /// In en, this message translates to:
  /// **'+923056838083'**
  String get aboutPhone;

  /// No description provided for @aboutEmail.
  ///
  /// In en, this message translates to:
  /// **'akashzaib61@gmail.com'**
  String get aboutEmail;

  /// No description provided for @downloadCV.
  ///
  /// In en, this message translates to:
  /// **'Download CV'**
  String get downloadCV;

  /// No description provided for @downloadingCV.
  ///
  /// In en, this message translates to:
  /// **'Downloading...'**
  String get downloadingCV;

  /// No description provided for @downloadedCV.
  ///
  /// In en, this message translates to:
  /// **'Downloaded!'**
  String get downloadedCV;

  /// No description provided for @viewResume.
  ///
  /// In en, this message translates to:
  /// **'View Resume'**
  String get viewResume;

  /// No description provided for @projectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Project Experience'**
  String get projectsTitle;

  /// No description provided for @projectOOSCTitle.
  ///
  /// In en, this message translates to:
  /// **'OOSC - AI-Based Learning App'**
  String get projectOOSCTitle;

  /// No description provided for @projectOOSCDescription.
  ///
  /// In en, this message translates to:
  /// **'Developed a fully AI-based learning mobile application for children using Flutter and Dart. Features include alphabet tracing modules for English, Urdu, and Mathematics, voice detection, 3D GLB model animations, real-time data updates, and offline support.'**
  String get projectOOSCDescription;

  /// No description provided for @projectISOARTitle.
  ///
  /// In en, this message translates to:
  /// **'ISOAR - Role-Based Flutter App'**
  String get projectISOARTitle;

  /// No description provided for @projectISOARDescription.
  ///
  /// In en, this message translates to:
  /// **'Developed a multi-role Flutter application supporting Student, Teacher, Organization, and Admin panels with role-based UI flows. Implemented responsive layouts, reusable components, and smooth screen transitions.'**
  String get projectISOARDescription;

  /// No description provided for @projectLookbookTitle.
  ///
  /// In en, this message translates to:
  /// **'LOOKBOOK - Fashion App'**
  String get projectLookbookTitle;

  /// No description provided for @projectLookbookDescription.
  ///
  /// In en, this message translates to:
  /// **'Developed a role-based Flutter mobile application with Customer, Designer, and Admin user models. Implemented barcode scanning, real-time messaging, Firebase Authentication, and push notifications.'**
  String get projectLookbookDescription;

  /// No description provided for @experienceTitle.
  ///
  /// In en, this message translates to:
  /// **'Work Experience'**
  String get experienceTitle;

  /// No description provided for @expConvoTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter Developer'**
  String get expConvoTitle;

  /// No description provided for @expConvoCompany.
  ///
  /// In en, this message translates to:
  /// **'Convo'**
  String get expConvoCompany;

  /// No description provided for @expConvoPeriod.
  ///
  /// In en, this message translates to:
  /// **'April 2025 - Present'**
  String get expConvoPeriod;

  /// No description provided for @expConvoDescription.
  ///
  /// In en, this message translates to:
  /// **'Developing AI-based learning mobile applications using Flutter and Dart.'**
  String get expConvoDescription;

  /// No description provided for @expConvoResp1.
  ///
  /// In en, this message translates to:
  /// **'Developed a fully AI-based learning mobile application for children'**
  String get expConvoResp1;

  /// No description provided for @expConvoResp2.
  ///
  /// In en, this message translates to:
  /// **'Integrated REST APIs and real-time socket connections'**
  String get expConvoResp2;

  /// No description provided for @expConvoResp3.
  ///
  /// In en, this message translates to:
  /// **'Implemented voice detection and automatic speech recognition'**
  String get expConvoResp3;

  /// No description provided for @expConvoResp4.
  ///
  /// In en, this message translates to:
  /// **'Integrated 3D GLB model animations with Three.js'**
  String get expConvoResp4;

  /// No description provided for @expConvoResp5.
  ///
  /// In en, this message translates to:
  /// **'Applied MobX state management for scalable architecture'**
  String get expConvoResp5;

  /// No description provided for @expTerabitTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter Developer'**
  String get expTerabitTitle;

  /// No description provided for @expTerabitCompany.
  ///
  /// In en, this message translates to:
  /// **'Terabit IT'**
  String get expTerabitCompany;

  /// No description provided for @expTerabitPeriod.
  ///
  /// In en, this message translates to:
  /// **'January 2024 - March 2025'**
  String get expTerabitPeriod;

  /// No description provided for @expTerabitDescription.
  ///
  /// In en, this message translates to:
  /// **'Worked on two major projects (ISOAR, LOOKBOOK), managing all stages end-to-end.'**
  String get expTerabitDescription;

  /// No description provided for @expTerabitResp1.
  ///
  /// In en, this message translates to:
  /// **'Developed multi-role Flutter applications with role-based UI flows'**
  String get expTerabitResp1;

  /// No description provided for @expTerabitResp2.
  ///
  /// In en, this message translates to:
  /// **'Implemented Firebase Authentication and Cloud Messaging'**
  String get expTerabitResp2;

  /// No description provided for @expTerabitResp3.
  ///
  /// In en, this message translates to:
  /// **'Built responsive and adaptive layouts for multiple devices'**
  String get expTerabitResp3;

  /// No description provided for @expTerabitResp4.
  ///
  /// In en, this message translates to:
  /// **'Created reusable and modular UI components'**
  String get expTerabitResp4;

  /// No description provided for @expVohTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter Developer Intern'**
  String get expVohTitle;

  /// No description provided for @expVohCompany.
  ///
  /// In en, this message translates to:
  /// **'Voh Technologies'**
  String get expVohCompany;

  /// No description provided for @expVohPeriod.
  ///
  /// In en, this message translates to:
  /// **'August 2022 - January 2023'**
  String get expVohPeriod;

  /// No description provided for @expVohDescription.
  ///
  /// In en, this message translates to:
  /// **'Gained hands-on experience with Flutter app development.'**
  String get expVohDescription;

  /// No description provided for @expVohResp1.
  ///
  /// In en, this message translates to:
  /// **'Contributed to building UI components and integrating APIs'**
  String get expVohResp1;

  /// No description provided for @expVohResp2.
  ///
  /// In en, this message translates to:
  /// **'Assisted in debugging and optimizing mobile applications'**
  String get expVohResp2;

  /// No description provided for @expVohResp3.
  ///
  /// In en, this message translates to:
  /// **'Collaborated with the development team to enhance app performance'**
  String get expVohResp3;

  /// No description provided for @expVohResp4.
  ///
  /// In en, this message translates to:
  /// **'Learned Flutter best practices and clean code principles'**
  String get expVohResp4;

  /// No description provided for @skillsTitle.
  ///
  /// In en, this message translates to:
  /// **'Technical Skills'**
  String get skillsTitle;

  /// No description provided for @skillFlutter.
  ///
  /// In en, this message translates to:
  /// **'Flutter'**
  String get skillFlutter;

  /// No description provided for @skillDart.
  ///
  /// In en, this message translates to:
  /// **'Dart'**
  String get skillDart;

  /// No description provided for @skillFirebase.
  ///
  /// In en, this message translates to:
  /// **'Firebase'**
  String get skillFirebase;

  /// No description provided for @skillStateManagement.
  ///
  /// In en, this message translates to:
  /// **'State Management'**
  String get skillStateManagement;

  /// No description provided for @skillCleanArchitecture.
  ///
  /// In en, this message translates to:
  /// **'Clean Architecture'**
  String get skillCleanArchitecture;

  /// No description provided for @skillRestApi.
  ///
  /// In en, this message translates to:
  /// **'REST APIs'**
  String get skillRestApi;

  /// No description provided for @skillUIUX.
  ///
  /// In en, this message translates to:
  /// **'UI/UX Design'**
  String get skillUIUX;

  /// No description provided for @skillResponsive.
  ///
  /// In en, this message translates to:
  /// **'Responsive Design'**
  String get skillResponsive;

  /// No description provided for @contactTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Connect'**
  String get contactTitle;

  /// No description provided for @contactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to collaborate or have a project in mind? Let\'s make something amazing together.'**
  String get contactSubtitle;

  /// No description provided for @contactName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get contactName;

  /// No description provided for @contactEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get contactEmail;

  /// No description provided for @contactMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get contactMessage;

  /// No description provided for @contactSend.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get contactSend;

  /// No description provided for @contactSuccess.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully!'**
  String get contactSuccess;

  /// No description provided for @contactError.
  ///
  /// In en, this message translates to:
  /// **'Failed to send message. Please try again.'**
  String get contactError;

  /// No description provided for @contactNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get contactNameHint;

  /// No description provided for @contactEmailHint.
  ///
  /// In en, this message translates to:
  /// **'your.email@example.com'**
  String get contactEmailHint;

  /// No description provided for @contactMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Your message...'**
  String get contactMessageHint;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageUrdu.
  ///
  /// In en, this message translates to:
  /// **'اردو'**
  String get languageUrdu;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get languageFrench;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get languageSpanish;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get languageGerman;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @scrollDown.
  ///
  /// In en, this message translates to:
  /// **'Scroll down'**
  String get scrollDown;

  /// No description provided for @present.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get present;

  /// No description provided for @viewProject.
  ///
  /// In en, this message translates to:
  /// **'View Project'**
  String get viewProject;

  /// No description provided for @techStack.
  ///
  /// In en, this message translates to:
  /// **'Tech Stack'**
  String get techStack;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'ur',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
