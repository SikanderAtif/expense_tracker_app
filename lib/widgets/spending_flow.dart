// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SpendingFlow extends StatelessWidget {
  final List<double> chartData;
  final List<String> labels;

  const SpendingFlow({
    super.key,
    required this.chartData,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final locale = AppLocalizations.of(context)!;
    final double maxValue = chartData.isEmpty 
        ? 1.0 
        : chartData.reduce((a, b) => a > b ? a : b);

    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            locale.spendingFlow,
            style: TextStyle(
              color: color.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(chartData.length, (index) {
                return Expanded(
                  child: ChartBar(
                    value: chartData[index],
                    label: labels[index],
                    maxValue: maxValue,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartBar extends StatelessWidget {
  final double value;
  final String label;
  final double maxValue;

  const ChartBar({
    super.key,
    required this.value,
    required this.label,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final double flexRatio = maxValue == 0 ? 0.0 : (value / maxValue);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: FractionallySizedBox(
            heightFactor: flexRatio.clamp(0.05, 1.0),
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: color.surfaceContainerHighest,
                    content: Text(
                      '$label: \$${value.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: color.secondary,
                      ),
                    ),
                  ),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                width: 25,
                decoration: BoxDecoration(
                  color: color.onSurface,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color.secondary,
          ),
        ),
      ],
    );
  }
}