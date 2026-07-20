// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'colors.dart';

abstract class AppTheme {
  static final ColorScheme _schemeDark = ColorScheme.dark(
    primary: AppColors.primaryDark,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.onSurfaceDark,
    secondary: AppColors.secondaryDark,
  );

  static final ColorScheme _schemeLight = ColorScheme.light(
    primary: AppColors.primaryLight,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.onSurfaceLight,
    secondary: AppColors.secondaryLight,
  );

  static ThemeData get themeDark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _schemeDark,
      scaffoldBackgroundColor: _schemeDark.surface,
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0.0,
        backgroundColor: _schemeDark.surface,
        foregroundColor: _schemeDark.primary,
        titleTextStyle: TextStyle(color: _schemeDark.primary, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _schemeDark.onSurface,
        foregroundColor: _schemeDark.primary,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: _schemeDark.secondary.withOpacity(0.1),
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return TextStyle(
            color: states.contains(WidgetState.selected)
                ? _schemeDark.onSurface
                : _schemeDark.secondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected)
                ? _schemeDark.onSurface
                : _schemeDark.secondary,
          );
        }),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? _schemeDark.onSurface
                : _schemeDark.secondary.withOpacity(0.1);
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? _schemeDark.primary
                : _schemeDark.secondary;
          }),
          side: WidgetStateProperty.resolveWith<BorderSide>((states) {
            return BorderSide(color: _schemeDark.surface);
          }),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((_) {
            return _schemeDark.onSurface;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((_) {
            return _schemeDark.primary;
          }),
          padding: WidgetStateProperty.resolveWith((_) {
            return EdgeInsets.symmetric(vertical: 12);
          }),
          alignment: AlignmentGeometry.center,
        ),
      ),
    );
  }

    static ThemeData get themeLight {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _schemeLight,
      scaffoldBackgroundColor: _schemeLight.surface,
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0.0,
        backgroundColor: _schemeLight.surface,
        foregroundColor: _schemeLight.primary,
        titleTextStyle: TextStyle(color: _schemeLight.primary, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _schemeLight.onSurface,
        foregroundColor: _schemeLight.primary,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: _schemeLight.secondary.withOpacity(0.1),
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return TextStyle(
            color: states.contains(WidgetState.selected)
                ? _schemeLight.onSurface
                : _schemeLight.secondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected)
                ? _schemeLight.onSurface
                : _schemeLight.secondary,
          );
        }),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? _schemeLight.onSurface
                : _schemeLight.secondary.withOpacity(0.1);
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? _schemeLight.primary
                : _schemeLight.secondary;
          }),
          side: WidgetStateProperty.resolveWith<BorderSide>((states) {
            return BorderSide(color: _schemeLight.surface);
          }),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((_) {
            return _schemeLight.onSurface;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((_) {
            return _schemeLight.primary;
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
