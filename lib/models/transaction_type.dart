enum TType {
  expense, income;

  String get label {
    switch(this) {
      case expense: return 'Expense';
      case income: return 'Income';
    }
  }
}