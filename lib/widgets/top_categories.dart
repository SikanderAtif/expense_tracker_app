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
        num3 = num2;
        num2 = num1;
        num1 = sumList[i];
        details[2] = details[1];
        details[1] = details[0];
        details[0] = labels[i];
        continue;
      }
      if (sumList[i] > num2) {
        num3 = num2;
        num2 = sumList[i];
        details[2] = details[1];
        details[1] = labels[i];
        continue;
      }
      if (sumList[i] > num3) {
        num3 = sumList[i];
        details[2] = labels[i];
        continue;
      }
    }
    topData[0] = num1;
    topData[1] = num2;
    topData[2] = num3;

    for (int i = 0; i < topData.length; i++) {
      if (topData[i] == 0) {
        topData.removeAt(i);
        details.removeAt(i);
        i--;
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
          for (int i = 0; i < data[0].length; i++)
            TopCategoriesItem(
              data: data[0][i],
              total: total,
              label: data[1][i],
            ),

          SizedBox(height: 16),
        ],
      ),
    );
  }
}
