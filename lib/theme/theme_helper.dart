import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/core/constants/theme_config.dart';
import 'package:flutter_bloc_boilerplate/core/utils/pref_utils.dart';
import 'package:flutter_bloc_boilerplate/core/utils/size_utils.dart';

/// Helper class for managing themes and colors.
/// 
/// Now uses ThemeConfig as the single source of truth for all theme settings.
class ThemeHelper {
  final String _appTheme;
  final String _fontFamily;
  final String _fontSizeScale;

  ThemeHelper({
    String? themeType,
    String? fontFamily,
    String? fontSizeScale,
  })  : _appTheme = themeType ?? PrefUtils().getThemeData(),
        _fontFamily = fontFamily ?? PrefUtils().getFontFamily(),
        _fontSizeScale = fontSizeScale ?? PrefUtils().getFontSizeScale();

  /// Returns the theme preset configuration for the current theme.
  ThemePresetConfig _getThemeConfig() {
    if (!ThemeConfig.themes.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found. Make sure you have added this theme in theme_config.dart");
    }
    return ThemeConfig.themes[_appTheme]!;
  }

  /// Returns the font family configuration.
  FontFamilyConfig _getFontFamilyConfig() {
    if (!ThemeConfig.fontFamilies.containsKey(_fontFamily)) {
      throw Exception(
          "$_fontFamily is not found. Make sure you have added this font family in theme_config.dart");
    }
    return ThemeConfig.fontFamilies[_fontFamily]!;
  }

  /// Returns the font size scale configuration.
  FontSizeScale _getFontSizeScale() {
    if (!ThemeConfig.fontSizeScales.containsKey(_fontSizeScale)) {
      throw Exception(
          "$_fontSizeScale is not found. Make sure you have added this font size scale in theme_config.dart");
    }
    return ThemeConfig.fontSizeScales[_fontSizeScale]!;
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    final themeConfig = _getThemeConfig();
    return PrimaryColors.fromConfig(themeConfig.colors);
  }

  /// Returns the color scheme for the current theme.
  ColorScheme _getColorScheme() {
    final themeConfig = _getThemeConfig();
    final colors = themeConfig.colors;
    
    if (themeConfig.isDark) {
      return ColorScheme.dark(
        primary: colors.primary,
        primaryContainer: colors.primaryContainer,
        secondary: colors.secondary,
        secondaryContainer: colors.secondaryContainer,
        background: colors.background,
        surface: colors.surface,
        error: colors.error,
        errorContainer: colors.errorContainer,
        onPrimary: colors.onPrimary,
        onSecondary: colors.onSecondary,
        onBackground: colors.onBackground,
        onSurface: colors.onSurface,
        onError: colors.onError,
        onPrimaryContainer: colors.onPrimaryContainer,
        onSecondaryContainer: colors.onSecondaryContainer,
        onErrorContainer: colors.onErrorContainer,
      );
    } else {
      return ColorScheme.light(
        primary: colors.primary,
        primaryContainer: colors.primaryContainer,
        secondary: colors.secondary,
        secondaryContainer: colors.secondaryContainer,
        background: colors.background,
        surface: colors.surface,
        error: colors.error,
        errorContainer: colors.errorContainer,
        onPrimary: colors.onPrimary,
        onSecondary: colors.onSecondary,
        onBackground: colors.onBackground,
        onSurface: colors.onSurface,
        onError: colors.onError,
        onPrimaryContainer: colors.onPrimaryContainer,
        onSecondaryContainer: colors.onSecondaryContainer,
        onErrorContainer: colors.onErrorContainer,
      );
    }
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    final themeConfig = _getThemeConfig();
    final colorScheme = _getColorScheme();
    final fontFamilyConfig = _getFontFamilyConfig();
    final fontSizeScale = _getFontSizeScale();
    final primaryColors = _getThemeColors();

    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      brightness: themeConfig.isDark ? Brightness.dark : Brightness.light,
      textTheme: TextThemes.textTheme(
        colorScheme,
        fontFamily: fontFamilyConfig.family,
        fontSizeScale: fontSizeScale,
        primaryColors: primaryColors,
      ),
      scaffoldBackgroundColor: colorScheme.primary,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColors.cyan300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: colorScheme.primary,
            width: 2.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColors.cyan300,
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: primaryColors.teal50,
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(
    ColorScheme colorScheme, {
    required String fontFamily,
    required FontSizeScale fontSizeScale,
    required PrimaryColors primaryColors,
  }) {
    return TextTheme(
      bodyMedium: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: fontSizeScale.getScaledSize('bodyMedium').fSize,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: primaryColors.gray500,
        fontSize: fontSizeScale.getScaledSize('bodySmall').fSize,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: fontSizeScale.getScaledSize('headlineSmall').fSize,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: TextStyle(
        color: primaryColors.gray500,
        fontSize: fontSizeScale.getScaledSize('labelLarge').fSize,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: primaryColors.gray500,
        fontSize: fontSizeScale.getScaledSize('labelMedium').fSize,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: primaryColors.gray500,
        fontSize: fontSizeScale.getScaledSize('labelSmall').fSize,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: fontSizeScale.getScaledSize('titleLarge').fSize,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: fontSizeScale.getScaledSize('titleMedium').fSize,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: fontSizeScale.getScaledSize('titleSmall').fSize,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

/// Class containing custom colors for a theme.
/// 
/// Now dynamically generated from ColorPaletteConfig.
class PrimaryColors {
  // Blue
  final Color blue50;

  // BlueGray
  final Color blueGray200;
  final Color blueGray300;
  final Color blueGray600;

  // Cyan
  final Color cyan100;
  final Color cyan300;

  // Gray
  final Color gray50;
  final Color gray500;
  final Color gray5001;

  // Teal
  final Color teal300;
  final Color teal50;

  PrimaryColors({
    required this.blue50,
    required this.blueGray200,
    required this.blueGray300,
    required this.blueGray600,
    required this.cyan100,
    required this.cyan300,
    required this.gray50,
    required this.gray500,
    required this.gray5001,
    required this.teal300,
    required this.teal50,
  });

  /// Create PrimaryColors from ColorPaletteConfig
  factory PrimaryColors.fromConfig(ColorPaletteConfig config) {
    return PrimaryColors(
      blue50: config.blue50,
      blueGray200: config.blueGray200,
      blueGray300: config.blueGray300,
      blueGray600: config.blueGray600,
      cyan100: config.cyan100,
      cyan300: config.cyan300,
      gray50: config.gray50,
      gray500: config.gray500,
      gray5001: config.gray5001,
      teal300: config.teal300,
      teal50: config.teal50,
    );
  }
}

/// Global accessors for current theme
/// 
/// These use the default PrefUtils values for backward compatibility.
PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
