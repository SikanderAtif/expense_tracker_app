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