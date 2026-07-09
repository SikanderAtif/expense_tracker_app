import 'package:flutter/material.dart';

extension DateTimeWeekRange on DateTime {
  DateTimeRange get currentWeekRange {
    final date = DateTime(year, month, day);
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    return DateTimeRange(start: startOfWeek, end: endOfWeek);
  }

  DateTimeRange get currentMonthRange {
    final startOfMonth = DateTime(year, month, 1);
    final endOfMonth = DateTime(year, month + 1, 1).subtract(const Duration(days: 1));
    
    return DateTimeRange(start: startOfMonth, end: endOfMonth);
  }

  DateTimeRange get currentYearRange {
    final startOfYear = DateTime(year, 1, 1);
    final endOfYear = DateTime(year + 1, 12, 31);

    return DateTimeRange(start: startOfYear, end: endOfYear);
  }
}