import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:expense_tracker_app/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    void onTap(int index) {
      if (index == 1) {
        ref.read(statsTabKeyProvider.notifier).state++;
      } else if (index == 2) {
        ref.read(budgetTabKeyProvider.notifier).state++;
      }
      
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: onTap,
        selectedIndex: navigationShell.currentIndex,
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: locale.homeTabTitle,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bar_chart),
            icon: Icon(Icons.bar_chart_outlined),
            label: locale.statsTabTitle,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_balance_wallet),
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: locale.budgetTabTitle,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle),
            icon: Icon(Icons.account_circle_outlined),
            label: locale.profileTabTitle,
          ),
        ],
      ),
    );
  }
}
