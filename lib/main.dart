import 'package:expense_tracker_app/theme/theme_manager.dart';
import 'package:expense_tracker_app/widgets/debug_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:expense_tracker_app/services/expense_helper.dart';
import 'screens/home_screen.dart';
import 'l10n/app_localizations.dart';
import 'firebase_options.dart';
import 'theme/theme.dart';

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
        return MaterialApp(
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
          home: HomeScreen(),
        );
      },
    );
  }
}
