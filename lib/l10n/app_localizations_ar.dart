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

  @override
  String get addTPUTitle => 'تحديث المعاملة';

  @override
  String get amountSpent => 'المبلغ المنفق';

  @override
  String get currency => 'SAR';

  @override
  String get selectCategory => 'اختر الفئة';

  @override
  String get saveTransaction => 'حفظ المعاملة';

  @override
  String get food => 'طعام';

  @override
  String get transit => 'عبور';

  @override
  String get shop => 'محل';

  @override
  String get bills => 'الفواتير';

  @override
  String get entertainment => 'ترفيه';

  @override
  String get health => 'صحة';

  @override
  String get home => 'بيت';

  @override
  String get edu => 'تعليم';

  @override
  String get week => 'أسبوع';

  @override
  String get month => 'شهر';

  @override
  String get year => 'سنة';

  @override
  String get budget => 'ميزانية';

  @override
  String get errorRetrieving => 'خطأ في استرجاع البيانات';

  @override
  String get budgetHeading => 'حسب الفئة';

  @override
  String get budgetButton => 'حدِّث ميزانيتك';

  @override
  String get profile => 'حساب تعريفي';

  @override
  String get emptyLogin => 'يرجى تعبئة حقلي البريد الإلكتروني وكلمة المرور';

  @override
  String get loginLoad => 'جاري تسجيل دخولك...';

  @override
  String get userNotFound => 'لم يتم العثور على مستخدم لهذا البريد الإلكتروني';

  @override
  String get wrongPassword => 'تم إدخال كلمة مرور خاطئة لهذا المستخدم';

  @override
  String get invalidEmail => 'عنوان البريد الإلكتروني المقدم غير صالح';

  @override
  String get userDisabled => 'تم تعطيل حساب المستخدم';

  @override
  String get invalidCredential => 'بيانات الاعتماد المقدمة غير صحيحة';

  @override
  String get networkError => 'خطأ في الشبكة';

  @override
  String get allEmpty => 'يرجى تعبئة جميع الحقول';

  @override
  String get creatingAccount => 'جارٍ إنشاء حسابك...';

  @override
  String get emailUsed => 'عنوان البريد الإلكتروني المقدم مستخدم بالفعل';

  @override
  String get weakPass => 'كلمة المرور المقدمة ضعيفة للغاية';

  @override
  String get uploadingError => 'فشل الرفع';

  @override
  String get uploading => 'جارٍ تحميل بياناتك...';

  @override
  String get downloadingError => 'فشل التنزيل';

  @override
  String get downloading => 'جارٍ تنزيل النسخة الاحتياطية السحابية...';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get welcomeMessage =>
      'يرجى إضافة اسمك للمتابعة \n مرحباً بك يا مستخدم';

  @override
  String get continueBtn => 'يكمل';

  @override
  String get user => 'مستخدم';

  @override
  String get welcome => 'مرحباً';

  @override
  String get uploadMsg => 'ارفع بياناتك';

  @override
  String get upload => 'رفع';

  @override
  String get downloadMsg => 'تنزيل بياناتك';

  @override
  String get download => 'تحميل';

  @override
  String overBudgetMessage(String amount) {
    return 'أعلى من إجمالي الميزانية الشهرية SAR $amount الميزانيات المخصصة لك هي';
  }

  @override
  String get setBudget => 'تحديد الميزانية';

  @override
  String get monthlyBudget => 'الميزانية الشهرية';

  @override
  String get statistics => 'إحصائيات';

  @override
  String get noDataYet => 'لا توجد بيانات بعد';

  @override
  String get topCategories => 'أبرز الفئات';

  @override
  String get allTransactions => 'كل الحركات المالية';

  @override
  String get searchHint => 'البحث في المعاملات...';

  @override
  String filterTabs(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '1': 'مصروف',
      '2': 'دخل',
      '3': 'طعام',
      '4': 'عبور',
      '5': 'محل',
      '6': 'الفواتير',
      '7': 'ترفيه',
      '8': 'صحة',
      '9': 'بيت',
      '10': 'تعليم',
      'other': 'الجميع',
    });
    return '$_temp0';
  }

  @override
  String get ofText => 'من';

  @override
  String get remaining => 'متبقي';

  @override
  String get budgetExceeded => 'تجاوز الميزانية بمقدار';

  @override
  String get setYourBudget => 'حدد ميزانيتك';

  @override
  String get name => 'اسم';

  @override
  String get email => 'بريد إلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signUp => 'اشتراك';

  @override
  String get emptyStateMessage => 'لم يتم إجراء أي معاملات بعد';

  @override
  String get transactions => 'المعاملات';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get totalMonthlyBudget => 'إجمالي الميزانية الشهرية';

  @override
  String get spent => 'مُستَنفَد';

  @override
  String get left => 'يسار';

  @override
  String get spendingFlow => 'تدفق الإنفاق';

  @override
  String get spending => 'الإنفاق';

  @override
  String get today => 'اليوم';

  @override
  String get yesturday => 'أمس';

  @override
  String get googleLogin => 'Google تسجيل الدخول باستخدام';

  @override
  String get errorGoogleLogin => 'Google فشل تسجيل الدخول.';

  @override
  String get settings => 'إعدادات';

  @override
  String get screenMode => 'وضع الشاشة';

  @override
  String get light => 'ضوء';

  @override
  String get dark => 'مظلم';

  @override
  String get language => 'لغة';

  @override
  String get or => 'أو';

  @override
  String get googleBtn => 'تسجيل الدخول باستخدام  Google';

  @override
  String get delete => 'يمسح';

  @override
  String get warning => '!تحذير';

  @override
  String get userMismatch =>
      'بيانات الاعتماد المقدمة لا تتطابق مع بيانات اعتماد المستخدم';

  @override
  String get deleting => 'حذف الحساب...';

  @override
  String get deleteMsg =>
      'ستقوم بحذف حسابك، مما سيؤدي إلى حذف جميع البيانات الموجودة على السحابة (ملاحظة: لن يؤثر ذلك على بياناتك المحلية الحالية). إذا كنت متأكداً من هذا الإجراء، فأدخل بيانات اعتمادك أدناه.';
}
