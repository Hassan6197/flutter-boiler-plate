import 'package:flutter/material.dart';

/// Centralized theme configuration file.
/// 
/// This is the single source of truth for all theme settings.
/// Modify colors, fonts, and theme presets here to change the entire app appearance.
class ThemeConfig {
  // Default settings
  static const String defaultTheme = 'primary';
  static const String defaultFontFamily = 'Inter';
  static const String defaultFontSizeScale = 'medium';

  /// All available theme presets
  static final Map<String, ThemePresetConfig> themes = {
    'primary': ThemePresetConfig(
      name: 'Primary',
      description: 'Default light theme with cyan accents',
      isDark: false,
      colors: ColorPaletteConfig(
        // Material ColorScheme colors
        primary: Color(0XFFFFFFFF),
        primaryContainer: Color(0XFFD13329),
        secondary: Color(0XFF52D1C6),
        secondaryContainer: Color(0XFFBAEDE8),
        background: Color(0XFFFFFFFF),
        surface: Color(0XFFFAFAFA),
        error: Color(0XFFD13329),
        errorContainer: Color(0XFF7AEA78),
        onPrimary: Color(0XFF38403F),
        onSecondary: Color(0XFFFFFFFF),
        onBackground: Color(0XFF38403F),
        onSurface: Color(0XFF38403F),
        onError: Color(0XFFFFFFFF),
        onPrimaryContainer: Color(0XFF051312),
        onSecondaryContainer: Color(0XFF38403F),
        onErrorContainer: Color(0XFF051312),
        // Custom app colors
        cyan300: Color(0XFF52D1C6),
        cyan100: Color(0XFFBAEDE8),
        teal300: Color(0XFF33C0B3),
        teal50: Color(0XFFDCF6F4),
        blue50: Color(0XFFEAEFFF),
        gray50: Color(0XFFFAFAFA),
        gray500: Color(0XFF8E9C9B),
        gray5001: Color(0XFFF6FDFC),
        blueGray200: Color(0XFFAEB8B7),
        blueGray300: Color(0XFF9098B1),
        blueGray600: Color(0XFF626F6E),
      ),
    ),
    'dark': ThemePresetConfig(
      name: 'Dark',
      description: 'Dark mode theme with cyan accents',
      isDark: true,
      colors: ColorPaletteConfig(
        // Material ColorScheme colors
        primary: Color(0XFF1E1E1E),
        primaryContainer: Color(0XFFD13329),
        secondary: Color(0XFF52D1C6),
        secondaryContainer: Color(0XFF2A4A47),
        background: Color(0XFF121212),
        surface: Color(0XFF1E1E1E),
        error: Color(0XFFD13329),
        errorContainer: Color(0XFF7AEA78),
        onPrimary: Color(0XFFFFFFFF),
        onSecondary: Color(0XFF121212),
        onBackground: Color(0XFFFFFFFF),
        onSurface: Color(0XFFFFFFFF),
        onError: Color(0XFFFFFFFF),
        onPrimaryContainer: Color(0XFFFFFFFF),
        onSecondaryContainer: Color(0XFFFFFFFF),
        onErrorContainer: Color(0XFF051312),
        // Custom app colors
        cyan300: Color(0XFF52D1C6),
        cyan100: Color(0XFF2A4A47),
        teal300: Color(0XFF33C0B3),
        teal50: Color(0XFF1A3A37),
        blue50: Color(0XFF1A1F2E),
        gray50: Color(0XFF2A2A2A),
        gray500: Color(0XFF8E9C9B),
        gray5001: Color(0XFF1E2A29),
        blueGray200: Color(0XFF6E7A79),
        blueGray300: Color(0XFF6E7A99),
        blueGray600: Color(0XFF9EACAB),
      ),
    ),
    'blue': ThemePresetConfig(
      name: 'Blue',
      description: 'Blue accent theme',
      isDark: false,
      colors: ColorPaletteConfig(
        // Material ColorScheme colors
        primary: Color(0XFFFFFFFF),
        primaryContainer: Color(0XFF1976D2),
        secondary: Color(0XFF2196F3),
        secondaryContainer: Color(0XFFBBDEFB),
        background: Color(0XFFFFFFFF),
        surface: Color(0XFFF5F5F5),
        error: Color(0XFFD32F2F),
        errorContainer: Color(0XFFC8E6C9),
        onPrimary: Color(0XFF1976D2),
        onSecondary: Color(0XFFFFFFFF),
        onBackground: Color(0XFF212121),
        onSurface: Color(0XFF212121),
        onError: Color(0XFFFFFFFF),
        onPrimaryContainer: Color(0XFFFFFFFF),
        onSecondaryContainer: Color(0XFF1976D2),
        onErrorContainer: Color(0XFF1B5E20),
        // Custom app colors
        cyan300: Color(0XFF2196F3),
        cyan100: Color(0XFFBBDEFB),
        teal300: Color(0XFF0288D1),
        teal50: Color(0XFFE3F2FD),
        blue50: Color(0XFFE3F2FD),
        gray50: Color(0XFFFAFAFA),
        gray500: Color(0XFF9E9E9E),
        gray5001: Color(0XFFF5F5F5),
        blueGray200: Color(0XFF90CAF9),
        blueGray300: Color(0XFF64B5F6),
        blueGray600: Color(0XFF42A5F5),
      ),
    ),
    'green': ThemePresetConfig(
      name: 'Green',
      description: 'Green accent theme',
      isDark: false,
      colors: ColorPaletteConfig(
        // Material ColorScheme colors
        primary: Color(0XFFFFFFFF),
        primaryContainer: Color(0XFF388E3C),
        secondary: Color(0XFF4CAF50),
        secondaryContainer: Color(0XFFC8E6C9),
        background: Color(0XFFFFFFFF),
        surface: Color(0XFFF5F5F5),
        error: Color(0XFFD32F2F),
        errorContainer: Color(0XFFEF9A9A),
        onPrimary: Color(0XFF2E7D32),
        onSecondary: Color(0XFFFFFFFF),
        onBackground: Color(0XFF212121),
        onSurface: Color(0XFF212121),
        onError: Color(0XFFFFFFFF),
        onPrimaryContainer: Color(0XFFFFFFFF),
        onSecondaryContainer: Color(0XFF1B5E20),
        onErrorContainer: Color(0XFFB71C1C),
        // Custom app colors
        cyan300: Color(0XFF4CAF50),
        cyan100: Color(0XFFC8E6C9),
        teal300: Color(0XFF388E3C),
        teal50: Color(0XFFE8F5E9),
        blue50: Color(0XFFE8F5E9),
        gray50: Color(0XFFFAFAFA),
        gray500: Color(0XFF9E9E9E),
        gray5001: Color(0XFFF5F5F5),
        blueGray200: Color(0XFFA5D6A7),
        blueGray300: Color(0XFF81C784),
        blueGray600: Color(0XFF66BB6A),
      ),
    ),
    'purple': ThemePresetConfig(
      name: 'Purple',
      description: 'Purple accent theme',
      isDark: false,
      colors: ColorPaletteConfig(
        // Material ColorScheme colors
        primary: Color(0XFFFFFFFF),
        primaryContainer: Color(0XFF7B1FA2),
        secondary: Color(0XFF9C27B0),
        secondaryContainer: Color(0XFFE1BEE7),
        background: Color(0XFFFFFFFF),
        surface: Color(0XFFF5F5F5),
        error: Color(0XFFD32F2F),
        errorContainer: Color(0XFFEF9A9A),
        onPrimary: Color(0XFF6A1B9A),
        onSecondary: Color(0XFFFFFFFF),
        onBackground: Color(0XFF212121),
        onSurface: Color(0XFF212121),
        onError: Color(0XFFFFFFFF),
        onPrimaryContainer: Color(0XFFFFFFFF),
        onSecondaryContainer: Color(0XFF4A148C),
        onErrorContainer: Color(0XFFB71C1C),
        // Custom app colors
        cyan300: Color(0XFF9C27B0),
        cyan100: Color(0XFFE1BEE7),
        teal300: Color(0XFF7B1FA2),
        teal50: Color(0XFFF3E5F5),
        blue50: Color(0XFFF3E5F5),
        gray50: Color(0XFFFAFAFA),
        gray500: Color(0XFF9E9E9E),
        gray5001: Color(0XFFF5F5F5),
        blueGray200: Color(0XFFCE93D8),
        blueGray300: Color(0XFFBA68C8),
        blueGray600: Color(0XFFAB47BC),
      ),
    ),
  };

  /// Font families configuration
  static final Map<String, FontFamilyConfig> fontFamilies = {
    'Inter': FontFamilyConfig(
      name: 'Inter',
      family: 'Inter',
      description: 'Modern sans-serif font',
    ),
    'Poppins': FontFamilyConfig(
      name: 'Poppins',
      family: 'Poppins',
      description: 'Geometric sans-serif font',
    ),
  };

  /// Font size scales
  static final Map<String, FontSizeScale> fontSizeScales = {
    'small': FontSizeScale(
      name: 'Small',
      scaleMultiplier: 0.875,
      baseSizes: {
        'bodyMedium': 14.0,
        'bodySmall': 12.0,
        'headlineSmall': 24.0,
        'labelLarge': 12.0,
        'labelMedium': 10.0,
        'labelSmall': 8.0,
        'titleLarge': 20.0,
        'titleMedium': 16.0,
        'titleSmall': 14.0,
      },
    ),
    'medium': FontSizeScale(
      name: 'Medium',
      scaleMultiplier: 1.0,
      baseSizes: {
        'bodyMedium': 14.0,
        'bodySmall': 12.0,
        'headlineSmall': 24.0,
        'labelLarge': 12.0,
        'labelMedium': 10.0,
        'labelSmall': 8.0,
        'titleLarge': 20.0,
        'titleMedium': 16.0,
        'titleSmall': 14.0,
      },
    ),
    'large': FontSizeScale(
      name: 'Large',
      scaleMultiplier: 1.125,
      baseSizes: {
        'bodyMedium': 14.0,
        'bodySmall': 12.0,
        'headlineSmall': 24.0,
        'labelLarge': 12.0,
        'labelMedium': 10.0,
        'labelSmall': 8.0,
        'titleLarge': 20.0,
        'titleMedium': 16.0,
        'titleSmall': 14.0,
      },
    ),
    'extraLarge': FontSizeScale(
      name: 'Extra Large',
      scaleMultiplier: 1.25,
      baseSizes: {
        'bodyMedium': 14.0,
        'bodySmall': 12.0,
        'headlineSmall': 24.0,
        'labelLarge': 12.0,
        'labelMedium': 10.0,
        'labelSmall': 8.0,
        'titleLarge': 20.0,
        'titleMedium': 16.0,
        'titleSmall': 14.0,
      },
    ),
  };
}

/// Configuration for a theme preset
class ThemePresetConfig {
  final String name;
  final String description;
  final ColorPaletteConfig colors;
  final bool isDark;

  ThemePresetConfig({
    required this.name,
    required this.description,
    required this.colors,
    required this.isDark,
  });
}

/// Complete color palette configuration for a theme
class ColorPaletteConfig {
  // Material ColorScheme colors
  final Color primary;
  final Color primaryContainer;
  final Color secondary;
  final Color secondaryContainer;
  final Color background;
  final Color surface;
  final Color error;
  final Color errorContainer;
  final Color onPrimary;
  final Color onSecondary;
  final Color onBackground;
  final Color onSurface;
  final Color onError;
  final Color onPrimaryContainer;
  final Color onSecondaryContainer;
  final Color onErrorContainer;

  // Custom app colors (matching PrimaryColors class)
  final Color cyan300;
  final Color cyan100;
  final Color teal300;
  final Color teal50;
  final Color blue50;
  final Color gray50;
  final Color gray500;
  final Color gray5001;
  final Color blueGray200;
  final Color blueGray300;
  final Color blueGray600;

  ColorPaletteConfig({
    required this.primary,
    required this.primaryContainer,
    required this.secondary,
    required this.secondaryContainer,
    required this.background,
    required this.surface,
    required this.error,
    required this.errorContainer,
    required this.onPrimary,
    required this.onSecondary,
    required this.onBackground,
    required this.onSurface,
    required this.onError,
    required this.onPrimaryContainer,
    required this.onSecondaryContainer,
    required this.onErrorContainer,
    required this.cyan300,
    required this.cyan100,
    required this.teal300,
    required this.teal50,
    required this.blue50,
    required this.gray50,
    required this.gray500,
    required this.gray5001,
    required this.blueGray200,
    required this.blueGray300,
    required this.blueGray600,
  });
}

/// Font family configuration
class FontFamilyConfig {
  final String name;
  final String family;
  final String description;

  FontFamilyConfig({
    required this.name,
    required this.family,
    required this.description,
  });
}

/// Font size scale configuration
class FontSizeScale {
  final String name;
  final double scaleMultiplier;
  final Map<String, double> baseSizes;

  FontSizeScale({
    required this.name,
    required this.scaleMultiplier,
    required this.baseSizes,
  });

  /// Get scaled size for a text style
  double getScaledSize(String styleName) {
    final baseSize = baseSizes[styleName] ?? 14.0;
    return baseSize * scaleMultiplier;
  }
}

