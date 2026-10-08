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
      onPrimary: Colors.white,

      secondary: AppColors.pink,
      onSecondary: Colors.white,

      tertiary: AppColors.gold,
      onTertiary: Colors.black,

      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,

      outline: AppColors.border,
    ),

    textTheme: AppTypography.textTheme,

    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
    ),

    iconTheme: const IconThemeData(
      color: AppColors.textSecondary,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      foregroundColor: AppColors.textPrimary,
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
      filled: true,
      fillColor: AppColors.surface,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),

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

      hintStyle: AppTypography.textTheme.bodyMedium?.copyWith(
        color: AppColors.textSecondary,
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceSecondary,
      selectedColor: AppColors.purple.withValues(alpha: 0.18),
      disabledColor: AppColors.surfaceSecondary,

      side: const BorderSide(
        color: AppColors.border,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      labelStyle: AppTypography.textTheme.bodyMedium!.copyWith(
        color: AppColors.textSecondary,
      ),

      secondaryLabelStyle: AppTypography.textTheme.bodyMedium!.copyWith(
        color: AppColors.textPrimary,
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.purple,
        foregroundColor: Colors.white,

        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 16,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        textStyle: AppTypography.textTheme.labelLarge,
      ),
    ),
  );
}