// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:expense_tracker_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryBudgetInput extends StatelessWidget {
  final TextEditingController _controller;
  final Category category;

  const CategoryBudgetInput({
    super.key,
    required this._controller,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final locale = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(category.icon, color: category.color(context)),
              SizedBox(width: 12),
              Text(
                category.getLocalizedName(locale),
                style: TextStyle(
                  color: category.color(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                locale.currency,
                style: TextStyle(
                  color: color.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: color.primary),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
