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
    Locale('en'),
  ];

  /// Text for App Title
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get appTitle;

  /// AppBar Title text for home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get homeTitle;

  /// Text for Home Tab Title in home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'HOME'**
  String get homeTabTitle;

  /// Text for Stats Tab Title in home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'STATS'**
  String get statsTabTitle;

  /// Text for Budget Tab Title in home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'BUDGET'**
  String get budgetTabTitle;

  /// Text for Profile Tab Title in home_screen.dart
  ///
  /// In en, this message translates to:
  /// **'PROFILE'**
  String get profileTabTitle;

  /// Text for the total balance Title in home_page_tab.dart
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get totalBalance;

  /// Text for the income title
  ///
  /// In en, this message translates to:
  /// **'INCOME'**
  String get income;

  /// Text for the expenses title
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{EXPENSE} other{EXPENSES}}'**
  String expenses(num count);

  /// Text for week period filter in home_page_tab.dart
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get periodWeek;

  /// Text for month period filter in home_page_tab.dart
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get periodMonth;

  /// Text for year period filter in home_page_tab.dart
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get periodYear;

  /// Text for the app bar title of Add Transaction Page
  ///
  /// In en, this message translates to:
  /// **'Add Transaction'**
  String get addTPTitle;

  /// Text for the app bar title of Add Transaction Update Variant Page
  ///
  /// In en, this message translates to:
  /// **'Update Transaction'**
  String get addTPUTitle;

  /// Text for Heading Amount Spent
  ///
  /// In en, this message translates to:
  /// **'Amount Spent'**
  String get amountSpent;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'PKR'**
  String get currency;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'SELECT CATEGORY'**
  String get selectCategory;

  /// No description provided for @saveTransaction.
  ///
  /// In en, this message translates to:
  /// **'Save Transaction'**
  String get saveTransaction;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// No description provided for @transit.
  ///
  /// In en, this message translates to:
  /// **'Transit'**
  String get transit;

  /// No description provided for @shop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shop;

  /// No description provided for @bills.
  ///
  /// In en, this message translates to:
  /// **'Bills'**
  String get bills;

  /// No description provided for @entertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get entertainment;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @edu.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get edu;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @budget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget;

  /// No description provided for @errorRetrieving.
  ///
  /// In en, this message translates to:
  /// **'Error Retrieving Data'**
  String get errorRetrieving;

  /// No description provided for @budgetHeading.
  ///
  /// In en, this message translates to:
  /// **'By Category'**
  String get budgetHeading;

  /// No description provided for @budgetButton.
  ///
  /// In en, this message translates to:
  /// **'Update Your Budget'**
  String get budgetButton;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @emptyLogin.
  ///
  /// In en, this message translates to:
  /// **'Please fill email and password fields.'**
  String get emptyLogin;

  /// No description provided for @loginLoad.
  ///
  /// In en, this message translates to:
  /// **'Logging you in...'**
  String get loginLoad;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user found for that email.'**
  String get userNotFound;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password provided for that user.'**
  String get wrongPassword;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Provided email is invalid.'**
  String get invalidEmail;

  /// No description provided for @userDisabled.
  ///
  /// In en, this message translates to:
  /// **'The user account has been disabled.'**
  String get userDisabled;

  /// No description provided for @invalidCredential.
  ///
  /// In en, this message translates to:
  /// **'The supplied credentials are incorrect.'**
  String get invalidCredential;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network Error'**
  String get networkError;

  /// No description provided for @allEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please fill all the fields.'**
  String get allEmpty;

  /// No description provided for @creatingAccount.
  ///
  /// In en, this message translates to:
  /// **'Creating your account...'**
  String get creatingAccount;

  /// No description provided for @emailUsed.
  ///
  /// In en, this message translates to:
  /// **'The provided email is already in use.'**
  String get emailUsed;

  /// No description provided for @weakPass.
  ///
  /// In en, this message translates to:
  /// **'The password provided is too weak.'**
  String get weakPass;

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading your data...'**
  String get uploading;

  /// No description provided for @downloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading cloud backup...'**
  String get downloading;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome, User\nPlease Add your Name to continue'**
  String get welcomeMessage;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @uploadMsg.
  ///
  /// In en, this message translates to:
  /// **'Upload your Data'**
  String get uploadMsg;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @downloadMsg.
  ///
  /// In en, this message translates to:
  /// **'Download your Data'**
  String get downloadMsg;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @overBudgetMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'re assigned budgets are PKR {amount} above the total monthly budget'**
  String overBudgetMessage(String amount);

  /// No description provided for @setBudget.
  ///
  /// In en, this message translates to:
  /// **'Set Budget'**
  String get setBudget;

  /// No description provided for @monthlyBudget.
  ///
  /// In en, this message translates to:
  /// **'Monthly Budget'**
  String get monthlyBudget;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @noDataYet.
  ///
  /// In en, this message translates to:
  /// **'No Data Yet'**
  String get noDataYet;

  /// No description provided for @topCategories.
  ///
  /// In en, this message translates to:
  /// **'Top Categories'**
  String get topCategories;

  /// No description provided for @allTransactions.
  ///
  /// In en, this message translates to:
  /// **'All Transactions'**
  String get allTransactions;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search transactions...'**
  String get searchHint;

  /// Filter Tab Names
  ///
  /// In en, this message translates to:
  /// **'{count, select, 1{Expense} 2{Income} 3{Food} 4{Transit} 5{Shop} 6{Bills} 7{Entertainment} 8{Health} 9{Home} 10{Education} other{All}}'**
  String filterTabs(String count);

  /// No description provided for @ofText.
  ///
  /// In en, this message translates to:
  /// **'OF'**
  String get ofText;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'REMAINING'**
  String get remaining;

  /// No description provided for @budgetExceeded.
  ///
  /// In en, this message translates to:
  /// **'Exceeded budget by'**
  String get budgetExceeded;

  /// No description provided for @setYourBudget.
  ///
  /// In en, this message translates to:
  /// **'Set Your Budget'**
  String get setYourBudget;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

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

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @emptyStateMessage.
  ///
  /// In en, this message translates to:
  /// **'No Transactions made yet'**
  String get emptyStateMessage;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @totalMonthlyBudget.
  ///
  /// In en, this message translates to:
  /// **'TOTAL MONTHLY BUDGET'**
  String get totalMonthlyBudget;

  /// No description provided for @spent.
  ///
  /// In en, this message translates to:
  /// **'SPENT'**
  String get spent;

  /// No description provided for @left.
  ///
  /// In en, this message translates to:
  /// **'LEFT'**
  String get left;

  /// No description provided for @spendingFlow.
  ///
  /// In en, this message translates to:
  /// **'Spending Flow'**
  String get spendingFlow;

  /// No description provided for @spending.
  ///
  /// In en, this message translates to:
  /// **'Spending'**
  String get spending;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get today;

  /// No description provided for @yesturday.
  ///
  /// In en, this message translates to:
  /// **'YESTERDAY'**
  String get yesturday;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
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
