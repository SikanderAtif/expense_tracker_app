// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:expense_tracker_app/models/category.dart';
import 'package:flutter/material.dart';

class TopCategoriesItem extends StatelessWidget {
  final double data;
  final double total;
  final Category label;

  const TopCategoriesItem ({super.key, required this.data, required this.total, required this.label});

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final locale = AppLocalizations.of(context)!;
    
    return Column(
      children: [
        ListTile(
            leading: Icon(label.icon, color: label.color(context)),
            title: Text(label.getLocalizedName(locale), style: (TextStyle(color: color.primary, fontWeight: FontWeight.bold))),
            subtitle: Text('${(data / total * 100).toStringAsFixed(2)}% ${locale.ofText} ${locale.spending}', style: TextStyle(color: color.secondary, fontSize: 12)),
            trailing: Text('${locale.currency}${data.toStringAsFixed(2)}', style: TextStyle(color: color.primary)),
          ),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: data / total),
            duration: const Duration(milliseconds: 400),
            builder: (context, value, _) {
              return LinearProgressIndicator(
                value: value,
                minHeight: 6,
                borderRadius: BorderRadius.circular(4),
                backgroundColor: color.secondary.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation(label.color(context)),
              );
            },
          ),
      ],
    );
  }
}