import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../theme/theme_manager.dart';

class DebugFloatingButton extends StatefulWidget {
  final Widget child;

  const DebugFloatingButton({super.key, required this.child});

  @override
  State<DebugFloatingButton> createState() => _DebugFloatingButtonState();
}

class _DebugFloatingButtonState extends State<DebugFloatingButton> {
  // Separate positions so they don't spawn on top of each other
  Offset themeBtnPosition = const Offset(20, 100);
  Offset langBtnPosition = const Offset(20, 160);

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return widget.child;
    }

    return Scaffold(
      body: Stack(
        children: [
          widget.child, // The active screen layout
          
          // --- BUTTON 1: THEME TOGGLE ---
          Positioned(
            left: themeBtnPosition.dx,
            top: themeBtnPosition.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  themeBtnPosition += details.delta;
                });
              },
              child: FloatingActionButton(
                heroTag: 'dev_theme_btn', // Unique tag required for multiple FABs
                mini: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: const Color.fromARGB(255, 187, 8, 160),
                onPressed: () {
                  appThemeMode.value = (appThemeMode.value == ThemeMode.dark)
                      ? ThemeMode.light
                      : ThemeMode.dark;
                },
                child: const Icon(Icons.contrast),
              ),
            ),
          ),

          // --- BUTTON 2: LANGUAGE TOGGLE ---
          Positioned(
            left: langBtnPosition.dx,
            top: langBtnPosition.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  langBtnPosition += details.delta;
                });
              },
              child: FloatingActionButton(
                heroTag: 'dev_lang_btn', // Unique tag required for multiple FABs
                mini: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: const Color.fromARGB(255, 187, 8, 160),
                onPressed: () {
                  // If current locale is Arabic (or system fallback resolves to Arabic), toggle to English
                  final currentLanguageCode = appLocale.value?.languageCode ?? 
                      Localizations.maybeLocaleOf(context)?.languageCode;

                  if (currentLanguageCode == 'ar') {
                    appLocale.value = const Locale('en');
                  } else {
                    appLocale.value = const Locale('ar');
                  }
                },
                child: const Icon(Icons.translate),
              ),
            ),
          ),
        ],
      ),
    );
  }
}