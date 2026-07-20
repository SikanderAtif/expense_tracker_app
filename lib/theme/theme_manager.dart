import 'package:flutter/material.dart';

// Existing Theme Notifier
final ValueNotifier<ThemeMode> appThemeMode = ValueNotifier<ThemeMode>(ThemeMode.system);

// New Locale Notifier (Defaults to null so it uses the system language first)
final ValueNotifier<Locale?> appLocale = ValueNotifier<Locale?>(null);