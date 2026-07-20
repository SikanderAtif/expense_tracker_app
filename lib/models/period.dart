import 'package:expense_tracker_app/l10n/app_localizations.dart';

enum Period {
  week, month, year;

  String get label {
    switch(this) {
      case week: return 'Week';
      case month: return 'Month';
      case year: return 'Year';
    }
  }
}

extension PeriodLabel on Period {
  String getLocalizedName(AppLocalizations locale) {
    switch (this) {
      case Period.week:
        return locale.week;
      case Period.month:
        return locale.month;
      case Period.year:
        return locale.year;
    }
  }
}