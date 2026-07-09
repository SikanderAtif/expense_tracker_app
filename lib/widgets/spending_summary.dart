// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/widgets/circular_pie_indicator.dart';
import 'package:flutter/material.dart';

class SpendingSummary extends StatelessWidget {
  final String _period;
  final List<Color> _chartColors;
  final List<double> _expenseData;

  const SpendingSummary({
    super.key,
    required this._period,
    required this._chartColors,
    required this._expenseData,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('${_period}ly Spending'),
            const SizedBox(height: 16),
            SizedBox(
              width: 220,
              height: 220,
              child: CircularPieIndicator(
                data: _expenseData,
                colors: _chartColors,
                size: 220,
                strokeWidth: 24,
                textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              primary: false,
              crossAxisCount: 4,
              children: _chartColors.map((c) {
                String label = '';
                for (Category element in Category.values) {
                  if (c == element.color) {
                    label = element.label;
                    break;
                  }
                }

                return Row(
                  children: [
                    Container(
                      width: 12.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
