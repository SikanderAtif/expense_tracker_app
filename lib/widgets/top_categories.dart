// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/widgets/top_categories_item.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  final List<double> sumList;
  final List<Category> labels;

  const TopCategories({super.key, required this.sumList, required this.labels});

  List<dynamic> _calculate() {
    final List<double> topData = [0, 0, 0];
    final List<Category> details = [
      Category.food,
      Category.food,
      Category.food,
    ];

    double num1 = 0, num2 = 0, num3 = 0;
    for (int i = 0; i < sumList.length; i++) {
      if (sumList[i] > num1) {
        num1 = sumList[i];
        topData[0] = num1;
        details[0] = labels[i];
        continue;
      }
      if (sumList[i] > num2) {
        num2 = sumList[i];
        topData[1] = num2;
        details[1] = labels[i];
        continue;
      }
      if (sumList[i] > num3) {
        num3 = sumList[i];
        topData[2] = num3;
        details[2] = labels[i];
        continue;
      }
    }

    return [topData, details];
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final double total = sumList.fold(0, (sum, item) => sum + item);
    final List<dynamic> data = _calculate();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.secondary.withOpacity(0.1),
      ),
      child: Column(
        children: [
          TopCategoriesItem(data: data[0][0], total: total, label: data[1][0]),
          TopCategoriesItem(data: data[0][1], total: total, label: data[1][1]),
          TopCategoriesItem(data: data[0][2], total: total, label: data[1][2]),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
