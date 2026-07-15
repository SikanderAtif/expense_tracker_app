// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/models/category.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<dynamic> spent;
  final List<dynamic> list;

  const CategoryList({super.key, required this.spent, required this.list});

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: Category.values.length,
      itemBuilder: (BuildContext context, int index) {
        final double limit = list[index][1];
        final Category category = list[index][0];
        final double spentValue = (spent.firstWhere(
          (element) => element[1].label == category.label,
          orElse: () => [0.0],
        ))[0];

        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(category.icon, color: category.color),
                    title: Text(
                      category.label,
                      style: TextStyle(
                        color: color.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'PKR ${spentValue.toStringAsFixed(2)} OF PKR ${limit.toStringAsFixed(2)}',
                      style: TextStyle(color: color.secondary, fontSize: 12),
                    ),
                    trailing: Text(
                      '${(spentValue / limit * 100).toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: spentValue > limit
                            ? category.color
                            : color.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: 0,
                      end: spentValue > limit ? 1.0 : spentValue / limit,
                    ),
                    duration: Duration(milliseconds: 400),
                    builder: (context, value, _) {
                      return LinearProgressIndicator(
                        color: category.color,
                        backgroundColor: color.secondary.withOpacity(0.2),
                        value: spentValue > limit ? 1.0 : spentValue / limit,
                        borderRadius: BorderRadius.circular(12),
                        minHeight: 12,
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  spentValue > limit
                      ? Text(
                          'Exceeded budget by PKR ${spentValue - limit}',
                          style: TextStyle(
                            color: category.color,
                            backgroundColor: category.color.withOpacity(0.2),
                          ),
                        )
                      : Text(
                          '${limit - spentValue} REMAINING',
                          style: TextStyle(color: color.secondary),
                        ),
                  SizedBox(height: 18),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
