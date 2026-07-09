// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'colors.dart';

abstract class AppTheme {
  static final ColorScheme _scheme = ColorScheme.dark(
    primary: AppColors.primaryDark,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.onSurfaceDark,
    secondary: AppColors.secondaryDark,
  );

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _scheme,
      scaffoldBackgroundColor: _scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: _scheme.surface,
        foregroundColor: _scheme.primary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _scheme.onSurface,
        foregroundColor: _scheme.primary,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: _scheme.secondary.withOpacity(0.1),
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return TextStyle(
            color: states.contains(WidgetState.selected)
                ? _scheme.onSurface
                : _scheme.secondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected)
                ? _scheme.onSurface
                : _scheme.secondary,
          );
        }),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? _scheme.onSurface
                : _scheme.secondary.withOpacity(0.1);
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? _scheme.primary
                : _scheme.secondary;
          }),
          side: WidgetStateProperty.resolveWith<BorderSide>((states) {
            return BorderSide(color: _scheme.surface);
          }),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((_) {
            return _scheme.onSurface;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((_) {
            return _scheme.primary;
          }),
          padding: WidgetStateProperty.resolveWith((_) {
            return EdgeInsets.symmetric(vertical: 12);
          }),
          alignment: AlignmentGeometry.center,
        ),
      ),
    );
  }
}