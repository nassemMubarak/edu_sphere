import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @welcomeBackMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBackMessage;

  /// No description provided for @onBoarding1Text1.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu.1'**
  String get onBoarding1Text1;

  /// No description provided for @onBoarding1Text2.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu.1'**
  String get onBoarding1Text2;

  /// No description provided for @onBoarding2Text1.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu.2'**
  String get onBoarding2Text1;

  /// No description provided for @onBoarding2Text2.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu.2'**
  String get onBoarding2Text2;

  /// No description provided for @onBoarding3Text1.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu.3'**
  String get onBoarding3Text1;

  /// No description provided for @onBoarding3Text2.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu.3'**
  String get onBoarding3Text2;

  /// No description provided for @loginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Login to continue'**
  String get loginToContinue;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?  '**
  String get noAccount;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @camp.
  ///
  /// In en, this message translates to:
  /// **'Camp'**
  String get camp;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// No description provided for @teacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get teacher;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account to continue'**
  String get createAccount;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @lastEducationalStage.
  ///
  /// In en, this message translates to:
  /// **'Last educational stage completed'**
  String get lastEducationalStage;

  /// No description provided for @campName.
  ///
  /// In en, this message translates to:
  /// **'Camp Name'**
  String get campName;

  /// No description provided for @byClickingText.
  ///
  /// In en, this message translates to:
  /// **'By Clicking “Sign Up”, I Agree To  '**
  String get byClickingText;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms Of Condition & Privacy Policy '**
  String get termsAndConditions;

  /// No description provided for @forgotYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Your Password?'**
  String get forgotYourPassword;

  /// No description provided for @verificationCodeMessage.
  ///
  /// In en, this message translates to:
  /// **'We will send you a verification code.'**
  String get verificationCodeMessage;

  /// No description provided for @sendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendVerificationCode;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code'**
  String get enterVerificationCode;

  /// No description provided for @verificationCodeReceived.
  ///
  /// In en, this message translates to:
  /// **'Verification code you just received.'**
  String get verificationCodeReceived;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @didNotReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive a code?'**
  String get didNotReceiveCode;

  /// No description provided for @resendAfter.
  ///
  /// In en, this message translates to:
  /// **'Resend after'**
  String get resendAfter;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter new password to continue'**
  String get enterNewPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @universityMajor.
  ///
  /// In en, this message translates to:
  /// **'University Major'**
  String get universityMajor;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @theAge.
  ///
  /// In en, this message translates to:
  /// **'The age'**
  String get theAge;

  /// No description provided for @typeOfTeaching.
  ///
  /// In en, this message translates to:
  /// **'Type Of Teaching'**
  String get typeOfTeaching;

  /// No description provided for @especiallyTeacher.
  ///
  /// In en, this message translates to:
  /// **'Especially Teacher'**
  String get especiallyTeacher;

  /// No description provided for @campTeacher.
  ///
  /// In en, this message translates to:
  /// **'Camp Teacher'**
  String get campTeacher;

  /// No description provided for @welcomeToApplication.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our application'**
  String get welcomeToApplication;

  /// No description provided for @lastLogin.
  ///
  /// In en, this message translates to:
  /// **'Last login 30 minutes ago'**
  String get lastLogin;

  /// No description provided for @yourProfile.
  ///
  /// In en, this message translates to:
  /// **'Your Profile'**
  String get yourProfile;

  /// No description provided for @estimates.
  ///
  /// In en, this message translates to:
  /// **'Estimates'**
  String get estimates;

  /// No description provided for @communication.
  ///
  /// In en, this message translates to:
  /// **'Communication'**
  String get communication;

  /// No description provided for @courseSubscription.
  ///
  /// In en, this message translates to:
  /// **'Course Subscription'**
  String get courseSubscription;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @aboutProgram.
  ///
  /// In en, this message translates to:
  /// **'About Program'**
  String get aboutProgram;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @yourQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Your Quizzes & Assessment'**
  String get yourQuizzes;

  /// No description provided for @noQuizzesAdded.
  ///
  /// In en, this message translates to:
  /// **'You have not added any quizzes yet.'**
  String get noQuizzesAdded;

  /// No description provided for @yourCourses.
  ///
  /// In en, this message translates to:
  /// **'Your Courses'**
  String get yourCourses;

  /// No description provided for @noCoursesAdded.
  ///
  /// In en, this message translates to:
  /// **'You have not added any courses yet.'**
  String get noCoursesAdded;

  /// No description provided for @coursesInformation.
  ///
  /// In en, this message translates to:
  /// **'Courses Information'**
  String get coursesInformation;

  /// No description provided for @coursesName.
  ///
  /// In en, this message translates to:
  /// **'Courses Name'**
  String get coursesName;

  /// No description provided for @courseType.
  ///
  /// In en, this message translates to:
  /// **'Course Type'**
  String get courseType;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @addCourses.
  ///
  /// In en, this message translates to:
  /// **'Add Courses'**
  String get addCourses;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @paymentNoticePaid.
  ///
  /// In en, this message translates to:
  /// **'You will pay for the application if the course is paid'**
  String get paymentNoticePaid;

  /// No description provided for @paymentNoticeFree.
  ///
  /// In en, this message translates to:
  /// **'You will pay for the application if the course is Free'**
  String get paymentNoticeFree;

  /// No description provided for @editCoursesInformation.
  ///
  /// In en, this message translates to:
  /// **'Edit Courses Information'**
  String get editCoursesInformation;

  /// No description provided for @deleteCourses.
  ///
  /// In en, this message translates to:
  /// **'Delete Courses'**
  String get deleteCourses;

  /// No description provided for @deleteConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete the Courses {title} ?'**
  String deleteConfirmation(Object title);

  /// No description provided for @deleteCoursesButton.
  ///
  /// In en, this message translates to:
  /// **'Delete Courses'**
  String get deleteCoursesButton;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @graduationResearch.
  ///
  /// In en, this message translates to:
  /// **'Graduation Research'**
  String get graduationResearch;

  /// No description provided for @atLeastOneLowerCase.
  ///
  /// In en, this message translates to:
  /// **'At least 1 lowercase letter'**
  String get atLeastOneLowerCase;

  /// No description provided for @atLeastOneUpperCase.
  ///
  /// In en, this message translates to:
  /// **'At least 1 uppercase letter'**
  String get atLeastOneUpperCase;

  /// No description provided for @atLeastOneSpecialCharacter.
  ///
  /// In en, this message translates to:
  /// **'At least 1 special character'**
  String get atLeastOneSpecialCharacter;

  /// No description provided for @atLeastOneNumber.
  ///
  /// In en, this message translates to:
  /// **'At least 1 number'**
  String get atLeastOneNumber;

  /// No description provided for @atLeastEightCharacters.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters long'**
  String get atLeastEightCharacters;

  /// No description provided for @deleteCourse.
  ///
  /// In en, this message translates to:
  /// **'Delete Course'**
  String get deleteCourse;

  /// No description provided for @deleteCourseConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete the course'**
  String get deleteCourseConfirmation;

  /// No description provided for @deleteCourseButton.
  ///
  /// In en, this message translates to:
  /// **'Delete Course'**
  String get deleteCourseButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @courseName.
  ///
  /// In en, this message translates to:
  /// **'Course Name'**
  String get courseName;

  /// No description provided for @editCourseInfo.
  ///
  /// In en, this message translates to:
  /// **'Edit Courses Information'**
  String get editCourseInfo;

  /// No description provided for @warningMessage.
  ///
  /// In en, this message translates to:
  /// **'You will pay for the application if the course is paid.'**
  String get warningMessage;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @coursePrice.
  ///
  /// In en, this message translates to:
  /// **'Course price '**
  String get coursePrice;

  /// No description provided for @coursePriceDollar.
  ///
  /// In en, this message translates to:
  /// **'Course price:  USD '**
  String get coursePriceDollar;

  /// No description provided for @enterCourseName.
  ///
  /// In en, this message translates to:
  /// **'Please enter course name'**
  String get enterCourseName;

  /// No description provided for @enterCoursePrice.
  ///
  /// In en, this message translates to:
  /// **'Please enter course price'**
  String get enterCoursePrice;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
