import 'package:book_spinner/core/theme/app_colors.dart';
import 'package:book_spinner/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme
{
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.purple,
      secondary: AppColors.blue,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    ),
    textTheme: AppTypography.textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: AppColors.border,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.surface,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.border,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.purple,
          width: 1.5,
        ),
      ),
    ),
  );
}