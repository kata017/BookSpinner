import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTypography
{
  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.jost(
      fontSize: 64,
      fontWeight: FontWeight.w700,
      height: 1.0,
      letterSpacing: -2.5,
    ),

    displayMedium: GoogleFonts.jost(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      height: 1.05,
      letterSpacing: -1.5,
    ),

    headlineMedium: GoogleFonts.jost(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      height: 1.15,
    ),

    titleLarge: GoogleFonts.jost(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.2,
    ),

    titleMedium: GoogleFonts.jost(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.25,
    ),

    bodyLarge: GoogleFonts.jost(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),

    bodyMedium: GoogleFonts.jost(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),

    bodySmall: GoogleFonts.jost(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.4,
    ),

    labelLarge: GoogleFonts.jost(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),

    labelMedium: GoogleFonts.jost(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.0,
    ),
  );
}