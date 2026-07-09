// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'نفقات';

  @override
  String get homeTitle => 'لوحة المعلومات';

  @override
  String get homeTabTitle => 'بيت';

  @override
  String get statsTabTitle => 'الإحصائيات';

  @override
  String get budgetTabTitle => 'ميزانية';

  @override
  String get profileTabTitle => 'حساب تعريفي';

  @override
  String get totalBalance => 'إجمالي الرصيد';

  @override
  String get income => 'دخل';

  @override
  String expenses(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'نفقات',
      one: 'نفقة',
    );
    return '$_temp0';
  }

  @override
  String get periodWeek => 'أسبوع';

  @override
  String get periodMonth => 'شهر';

  @override
  String get periodYear => 'سنة';

  @override
  String get addTPTitle => 'إضافة معاملة';
}
