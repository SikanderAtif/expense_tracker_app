// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Expenses';

  @override
  String get homeTitle => 'Dashboard';

  @override
  String get homeTabTitle => 'HOME';

  @override
  String get statsTabTitle => 'STATS';

  @override
  String get budgetTabTitle => 'BUDGET';

  @override
  String get profileTabTitle => 'PROFILE';

  @override
  String get totalBalance => 'Total Balance';

  @override
  String get income => 'INCOME';

  @override
  String expenses(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'EXPENSES',
      one: 'EXPENSE',
    );
    return '$_temp0';
  }

  @override
  String get periodWeek => 'Week';

  @override
  String get periodMonth => 'Month';

  @override
  String get periodYear => 'Year';

  @override
  String get addTPTitle => 'Add Transaction';

  @override
  String get addTPUTitle => 'Update Transaction';

  @override
  String get amountSpent => 'Amount Spent';

  @override
  String get currency => 'PKR';

  @override
  String get selectCategory => 'SELECT CATEGORY';

  @override
  String get saveTransaction => 'Save Transaction';

  @override
  String get food => 'Food';

  @override
  String get transit => 'Transit';

  @override
  String get shop => 'Shop';

  @override
  String get bills => 'Bills';

  @override
  String get entertainment => 'Entertainment';

  @override
  String get health => 'Health';

  @override
  String get home => 'Home';

  @override
  String get edu => 'Education';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String get budget => 'Budget';

  @override
  String get errorRetrieving => 'Error Retrieving Data';

  @override
  String get budgetHeading => 'By Category';

  @override
  String get budgetButton => 'Update Your Budget';

  @override
  String get profile => 'Profile';

  @override
  String get emptyLogin => 'Please fill email and password fields.';

  @override
  String get loginLoad => 'Logging you in...';

  @override
  String get userNotFound => 'No user found for that email.';

  @override
  String get wrongPassword => 'Wrong password provided for that user.';

  @override
  String get invalidEmail => 'Provided email is invalid.';

  @override
  String get userDisabled => 'The user account has been disabled.';

  @override
  String get invalidCredential => 'The supplied credentials are incorrect.';

  @override
  String get networkError => 'Network Error';

  @override
  String get allEmpty => 'Please fill all the fields.';

  @override
  String get creatingAccount => 'Creating your account...';

  @override
  String get emailUsed => 'The provided email is already in use.';

  @override
  String get weakPass => 'The password provided is too weak.';

  @override
  String get uploadingError => 'Upload Failed';

  @override
  String get uploading => 'Uploading your data...';

  @override
  String get downloadingError => 'Download Failed';

  @override
  String get downloading => 'Downloading cloud backup...';

  @override
  String get signOut => 'Sign Out';

  @override
  String get welcomeMessage =>
      'Welcome, User\nPlease Add your Name to continue';

  @override
  String get continueBtn => 'Continue';

  @override
  String get user => 'User';

  @override
  String get welcome => 'Welcome';

  @override
  String get uploadMsg => 'Upload your Data';

  @override
  String get upload => 'Upload';

  @override
  String get downloadMsg => 'Download your Data';

  @override
  String get download => 'Download';

  @override
  String overBudgetMessage(String amount) {
    return 'You\'re assigned budgets are PKR $amount above the total monthly budget';
  }

  @override
  String get setBudget => 'Set Budget';

  @override
  String get monthlyBudget => 'Monthly Budget';

  @override
  String get statistics => 'Statistics';

  @override
  String get noDataYet => 'No Data Yet';

  @override
  String get topCategories => 'Top Categories';

  @override
  String get allTransactions => 'All Transactions';

  @override
  String get searchHint => 'Search transactions...';

  @override
  String filterTabs(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '1': 'Expense',
      '2': 'Income',
      '3': 'Food',
      '4': 'Transit',
      '5': 'Shop',
      '6': 'Bills',
      '7': 'Entertainment',
      '8': 'Health',
      '9': 'Home',
      '10': 'Education',
      'other': 'All',
    });
    return '$_temp0';
  }

  @override
  String get ofText => 'OF';

  @override
  String get remaining => 'REMAINING';

  @override
  String get budgetExceeded => 'Exceeded budget by';

  @override
  String get setYourBudget => 'Set Your Budget';

  @override
  String get name => 'Name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get signUp => 'Sign Up';

  @override
  String get emptyStateMessage => 'No Transactions made yet';

  @override
  String get transactions => 'Transactions';

  @override
  String get viewAll => 'View All';

  @override
  String get totalMonthlyBudget => 'TOTAL MONTHLY BUDGET';

  @override
  String get spent => 'SPENT';

  @override
  String get left => 'LEFT';

  @override
  String get spendingFlow => 'Spending Flow';

  @override
  String get spending => 'Spending';

  @override
  String get today => 'TODAY';

  @override
  String get yesturday => 'YESTERDAY';

  @override
  String get googleLogin => 'Signing in with Google';

  @override
  String get errorGoogleLogin => 'Google Sign-In failed.';

  @override
  String get settings => 'Settings';

  @override
  String get screenMode => 'Screen Mode';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get or => 'OR';

  @override
  String get googleBtn => 'Sign in with Google';

  @override
  String get delete => 'Delete';

  @override
  String get warning => 'Warning!';

  @override
  String get userMismatch =>
      'Provided Credentials Do NOT Match User\'s Credentials';

  @override
  String get deleting => 'Deleting Account...';

  @override
  String get deleteMsg =>
      'You are going to DELETE your account which will delete all data in the cloud (Note: This does not affect your current local data). If you are sure about this action enter your credentials below.';
}
