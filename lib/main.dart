import 'package:expense_tracker_app/providers/expense_provider.dart';
import 'package:expense_tracker_app/screens/add_transaction_screen.dart';
import 'package:expense_tracker_app/screens/budget_page_tab.dart';
import 'package:expense_tracker_app/screens/home_page_tab.dart';
import 'package:expense_tracker_app/screens/profile_page_tab.dart';
import 'package:expense_tracker_app/screens/set_budget_screen.dart';
import 'package:expense_tracker_app/screens/stats_page_tab.dart';
import 'package:expense_tracker_app/screens/transactions_screen.dart';
import 'package:expense_tracker_app/theme/theme_manager.dart';
import 'package:expense_tracker_app/widgets/debug_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:expense_tracker_app/services/expense_helper.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'l10n/app_localizations.dart';
import 'firebase_options.dart';
import 'theme/theme.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomePage()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/stats',
              builder: (context, state) {
                return Consumer(
                  builder: (context, ref, child) {
                    final keyVersion = ref.watch(statsTabKeyProvider);

                    return StatsPage(key: ValueKey('stats_$keyVersion'));
                  },
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/budget',
              builder: (context, state) {
                return Consumer(
                  builder: (context, ref, child) {
                    final keyVersion = ref.watch(budgetTabKeyProvider);

                    return BudgetPage(key: ValueKey('budget_$keyVersion'));
                  },
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: '/add-transaction-screen',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final payload = state.extra as Map<String, dynamic>;

        return AddTransactionScreen(
          expense: payload['expense'],
          update: payload['update'],
        );
      },
    ),
    GoRoute(
      path: '/transactions-screen',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const TransactionsScreen(),
    ),
    GoRoute(
      path: '/set-budget-screen',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final payload = state.extra as Map<String, dynamic>;

        return SetBudgetScreen(
          budget: payload['budget'],
          update: payload['update'],
        );
      },
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ExpensesHelper.init();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([appThemeMode, appLocale]),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeLight,
          darkTheme: AppTheme.themeDark,
          themeMode: appThemeMode.value,
          locale: appLocale.value,
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('en'), Locale('ar')],
          builder: (context, widget) {
            return DebugFloatingButton(child: widget!);
          },
          routerConfig: _router,
        );
      },
    );
  }
}
