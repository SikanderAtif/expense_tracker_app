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
}
