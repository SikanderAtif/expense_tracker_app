import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState ({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No Transactions made yet',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}