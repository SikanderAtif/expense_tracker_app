import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState ({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Center(
      child: Text(
        locale.emptyStateMessage,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}