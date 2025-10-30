import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the e-learning application.
/// Implements Contemporary Educational Minimalism design philosophy with
/// Focused Learning Spectrum color strategy.
class AppTheme {
  AppTheme._();

  // Brand Colors - Orange-Purple Gradient System
  static const Color primaryOrange = Color(0xFFFF6B35);
  static const Color primaryPurple = Color(0xFF6B46C1);

  // Neutral Palette - Optimized for extended screen time
  static const Color neutralDark = Color(0xFF1F2937);
  static const Color neutralMedium = Color(0xFF6B7280);
  static const Color neutralLight = Color(0xFFF9FAFB);
  static const Color surfaceWhite = Color(0xFFFFFFFF);

  // Functional Colors - Following accessibility guidelines
  static const Color successGreen = Color(0xFF10B981);
  static const Color warningAmber = Color(0xFFF59E0B);
  static const Color errorRed = Color(0xFFEF4444);

  // Dark Mode Variants
  static const Color backgroundDark = Color(0xFF111827);
  static const Color surfaceDark = Color(0xFF1F2937);
  static const Color cardDark = Color(0xFF374151);

  // Text Colors with proper emphasis levels
  static const Color textHighEmphasisLight = Color(0xDE000000); // 87% opacity
  static const Color textMediumEmphasisLight = Color(0x99000000); // 60% opacity
  static const Color textDisabledLight = Color(0x61000000); // 38% opacity

  static const Color textHighEmphasisDark = Color(0xDEFFFFFF); // 87% opacity
  static const Color textMediumEmphasisDark = Color(0x99FFFFFF); // 60% opacity
  static const Color textDisabledDark = Color(0x61FFFFFF); // 38% opacity

  // Shadow and divider colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowDark = Color(0x1AFFFFFF);
  static const Color dividerLight = Color(0x1F000000);
  static const Color dividerDark = Color(0x1FFFFFFF);

  /// Light theme optimized for learning environments
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryOrange,
      onPrimary: surfaceWhite,
      primaryContainer: primaryOrange.withValues(alpha: 0.1),
      onPrimaryContainer: neutralDark,
      secondary: primaryPurple,
      onSecondary: surfaceWhite,
      secondaryContainer: primaryPurple.withValues(alpha: 0.1),
      onSecondaryContainer: neutralDark,
      tertiary: successGreen,
      onTertiary: surfaceWhite,
      tertiaryContainer: successGreen.withValues(alpha: 0.1),
      onTertiaryContainer: neutralDark,
      error: errorRed,
      onError: surfaceWhite,
      surface: surfaceWhite,
      onSurface: neutralDark,
      onSurfaceVariant: neutralMedium,
      outline: neutralMedium.withValues(alpha: 0.5),
      outlineVariant: neutralLight,
      shadow: shadowLight,
      scrim: neutralDark.withValues(alpha: 0.5),
      inverseSurface: neutralDark,
      onInverseSurface: surfaceWhite,
      inversePrimary: primaryOrange.withValues(alpha: 0.8),
    ),
    scaffoldBackgroundColor: neutralLight,
    cardColor: surfaceWhite,
    dividerColor: dividerLight,

    // AppBar Theme - Clean and minimal
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceWhite,
      foregroundColor: neutralDark,
      elevation: 1.0,
      shadowColor: shadowLight,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: neutralDark,
        letterSpacing: -0.5,
      ),
      iconTheme: const IconThemeData(
        color: neutralDark,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: neutralDark,
        size: 24,
      ),
    ),

    // Card Theme - Subtle elevation for content hierarchy
    cardTheme: CardTheme(
      color: surfaceWhite,
      elevation: 2.0,
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Bottom Navigation - Educational app navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceWhite,
      selectedItemColor: primaryOrange,
      unselectedItemColor: neutralMedium,
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Floating Action Button - Continue Learning action
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryOrange,
      foregroundColor: surfaceWhite,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: surfaceWhite,
        backgroundColor: primaryOrange,
        elevation: 2.0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryOrange,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: primaryOrange, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryOrange,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
      ),
    ),

    // Text Theme - Optimized for learning content
    textTheme: _buildLightTextTheme(),

    // Input Decoration - Clean form styling
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceWhite,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: neutralMedium.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: neutralMedium.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: primaryOrange, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: neutralMedium,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textDisabledLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorRed,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Interactive Elements
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryOrange;
        }
        return neutralMedium;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryOrange.withValues(alpha: 0.3);
        }
        return neutralMedium.withValues(alpha: 0.3);
      }),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryOrange;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(surfaceWhite),
      side: const BorderSide(color: neutralMedium, width: 2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryOrange;
        }
        return neutralMedium;
      }),
    ),

    // Progress Indicators - Course completion visualization
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryOrange,
      linearTrackColor: neutralLight,
      circularTrackColor: neutralLight,
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: primaryOrange,
      thumbColor: primaryOrange,
      overlayColor: primaryOrange.withValues(alpha: 0.2),
      inactiveTrackColor: neutralLight,
      trackHeight: 4.0,
    ),

    // Tab Bar Theme
    tabBarTheme: TabBarTheme(
      labelColor: primaryOrange,
      unselectedLabelColor: neutralMedium,
      indicatorColor: primaryOrange,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
    ),

    // Tooltip Theme
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: neutralDark.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: surfaceWhite,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // SnackBar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: neutralDark,
      contentTextStyle: GoogleFonts.inter(
        color: surfaceWhite,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: primaryOrange,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 6.0,
    ), dialogTheme: DialogThemeData(backgroundColor: surfaceWhite),
  );

  /// Dark theme optimized for low-light learning sessions
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryOrange,
      onPrimary: neutralDark,
      primaryContainer: primaryOrange.withValues(alpha: 0.2),
      onPrimaryContainer: surfaceWhite,
      secondary: primaryPurple,
      onSecondary: neutralDark,
      secondaryContainer: primaryPurple.withValues(alpha: 0.2),
      onSecondaryContainer: surfaceWhite,
      tertiary: successGreen,
      onTertiary: neutralDark,
      tertiaryContainer: successGreen.withValues(alpha: 0.2),
      onTertiaryContainer: surfaceWhite,
      error: errorRed,
      onError: surfaceWhite,
      surface: surfaceDark,
      onSurface: surfaceWhite,
      onSurfaceVariant: neutralMedium,
      outline: neutralMedium.withValues(alpha: 0.5),
      outlineVariant: cardDark,
      shadow: shadowDark,
      scrim: neutralDark.withValues(alpha: 0.7),
      inverseSurface: surfaceWhite,
      onInverseSurface: neutralDark,
      inversePrimary: primaryOrange,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: surfaceDark,
    dividerColor: dividerDark,

    // AppBar Theme - Dark mode
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: surfaceWhite,
      elevation: 1.0,
      shadowColor: shadowDark,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: surfaceWhite,
        letterSpacing: -0.5,
      ),
      iconTheme: const IconThemeData(
        color: surfaceWhite,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: surfaceWhite,
        size: 24,
      ),
    ),

    // Card Theme - Dark mode
    cardTheme: CardTheme(
      color: surfaceDark,
      elevation: 2.0,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Bottom Navigation - Dark mode
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: primaryOrange,
      unselectedItemColor: neutralMedium,
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Floating Action Button - Dark mode
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryOrange,
      foregroundColor: neutralDark,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),

    // Button Themes - Dark mode
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: neutralDark,
        backgroundColor: primaryOrange,
        elevation: 2.0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryOrange,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: primaryOrange, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryOrange,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
      ),
    ),

    // Text Theme - Dark mode
    textTheme: _buildDarkTextTheme(),

    // Input Decoration - Dark mode
    inputDecorationTheme: InputDecorationTheme(
      fillColor: cardDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: neutralMedium.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: neutralMedium.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: primaryOrange, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: neutralMedium,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textDisabledDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorRed,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Interactive Elements - Dark mode
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryOrange;
        }
        return neutralMedium;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryOrange.withValues(alpha: 0.3);
        }
        return neutralMedium.withValues(alpha: 0.3);
      }),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryOrange;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(neutralDark),
      side: const BorderSide(color: neutralMedium, width: 2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryOrange;
        }
        return neutralMedium;
      }),
    ),

    // Progress Indicators - Dark mode
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryOrange,
      linearTrackColor: cardDark,
      circularTrackColor: cardDark,
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: primaryOrange,
      thumbColor: primaryOrange,
      overlayColor: primaryOrange.withValues(alpha: 0.2),
      inactiveTrackColor: cardDark,
      trackHeight: 4.0,
    ),

    // Tab Bar Theme - Dark mode
    tabBarTheme: TabBarTheme(
      labelColor: primaryOrange,
      unselectedLabelColor: neutralMedium,
      indicatorColor: primaryOrange,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
    ),

    // Tooltip Theme - Dark mode
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: surfaceWhite.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: neutralDark,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // SnackBar Theme - Dark mode
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceWhite,
      contentTextStyle: GoogleFonts.inter(
        color: neutralDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: primaryOrange,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 6.0,
    ), dialogTheme: DialogThemeData(backgroundColor: surfaceDark),
  );

  /// Light theme text styles optimized for learning content
  static TextTheme _buildLightTextTheme() {
    return TextTheme(
      // Display styles - Course titles and major headings
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisLight,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisLight,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisLight,
        letterSpacing: 0,
        height: 1.22,
      ),

      // Headline styles - Section headers and lesson titles
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textHighEmphasisLight,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textHighEmphasisLight,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textHighEmphasisLight,
        letterSpacing: 0,
        height: 1.33,
      ),

      // Title styles - Card headers and navigation
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textHighEmphasisLight,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textHighEmphasisLight,
        letterSpacing: 0.15,
        height: 1.5,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textHighEmphasisLight,
        letterSpacing: 0.1,
        height: 1.43,
      ),

      // Body styles - Learning content and descriptions
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisLight,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisLight,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMediumEmphasisLight,
        letterSpacing: 0.4,
        height: 1.33,
      ),

      // Label styles - Buttons and form labels
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHighEmphasisLight,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textMediumEmphasisLight,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: GoogleFonts.jetBrainsMono(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: textDisabledLight,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    );
  }

  /// Dark theme text styles optimized for low-light learning
  static TextTheme _buildDarkTextTheme() {
    return TextTheme(
      // Display styles - Course titles and major headings
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisDark,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisDark,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisDark,
        letterSpacing: 0,
        height: 1.22,
      ),

      // Headline styles - Section headers and lesson titles
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textHighEmphasisDark,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textHighEmphasisDark,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textHighEmphasisDark,
        letterSpacing: 0,
        height: 1.33,
      ),

      // Title styles - Card headers and navigation
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textHighEmphasisDark,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textHighEmphasisDark,
        letterSpacing: 0.15,
        height: 1.5,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textHighEmphasisDark,
        letterSpacing: 0.1,
        height: 1.43,
      ),

      // Body styles - Learning content and descriptions
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisDark,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisDark,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMediumEmphasisDark,
        letterSpacing: 0.4,
        height: 1.33,
      ),

      // Label styles - Buttons and form labels
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHighEmphasisDark,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textMediumEmphasisDark,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: GoogleFonts.jetBrainsMono(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: textDisabledDark,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    );
  }

  /// Gradient utility for brand accent elements
  static LinearGradient get brandGradient => const LinearGradient(
        colors: [primaryOrange, primaryPurple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  /// Progress gradient for course completion visualization
  static LinearGradient get progressGradient => const LinearGradient(
        colors: [primaryOrange, primaryPurple],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
}
