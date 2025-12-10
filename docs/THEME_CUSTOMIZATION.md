# Theme Customization Guide

This guide explains how to customize themes, colors, and fonts in the Flutter BLoC Boilerplate using the centralized theme configuration system.

## Overview

All theme settings are centralized in a single configuration file: [`lib/core/constants/theme_config.dart`](../lib/core/constants/theme_config.dart). Changes to this file will automatically reflect throughout the entire app.

## Table of Contents

- [Adding a New Theme](#adding-a-new-theme)
- [Modifying Existing Themes](#modifying-existing-themes)
- [Adding New Font Families](#adding-new-font-families)
- [Customizing Font Sizes](#customizing-font-sizes)
- [Switching Themes Programmatically](#switching-themes-programmatically)
- [Color Reference](#color-reference)

---

## Adding a New Theme

To add a new theme preset, add an entry to `ThemeConfig.themes` in `theme_config.dart`:

```dart
'ocean': ThemePresetConfig(
  name: 'Ocean',
  description: 'Cool ocean blue theme',
  isDark: false,
  colors: ColorPaletteConfig(
    // Material ColorScheme colors
    primary: Color(0XFFFFFFFF),
    primaryContainer: Color(0XFF0077BE),
    secondary: Color(0XFF00A8E8),
    secondaryContainer: Color(0XFFB3E5FC),
    background: Color(0XFFFFFFFF),
    surface: Color(0XFFF5F5F5),
    error: Color(0XFFD32F2F),
    errorContainer: Color(0XFFC8E6C9),
    onPrimary: Color(0XFF0077BE),
    onSecondary: Color(0XFFFFFFFF),
    onBackground: Color(0XFF212121),
    onSurface: Color(0XFF212121),
    onError: Color(0XFFFFFFFF),
    onPrimaryContainer: Color(0XFFFFFFFF),
    onSecondaryContainer: Color(0XFF0077BE),
    onErrorContainer: Color(0XFF1B5E20),
    
    // Custom app colors
    cyan300: Color(0XFF00A8E8),
    cyan100: Color(0XFFB3E5FC),
    teal300: Color(0XFF0077BE),
    teal50: Color(0XFFE0F7FA),
    blue50: Color(0XFFE3F2FD),
    gray50: Color(0XFFFAFAFA),
    gray500: Color(0XFF9E9E9E),
    gray5001: Color(0XFFF5F5F5),
    blueGray200: Color(0XFF90CAF9),
    blueGray300: Color(0XFF64B5F6),
    blueGray600: Color(0XFF42A5F5),
  ),
),
```

### Theme Properties

- **name**: Display name for the theme
- **description**: Brief description of the theme
- **isDark**: Set to `true` for dark mode themes, `false` for light themes
- **colors**: Complete color palette (see [Color Reference](#color-reference))

---

## Modifying Existing Themes

To modify an existing theme, simply edit the corresponding entry in `ThemeConfig.themes`:

```dart
'primary': ThemePresetConfig(
  name: 'Primary',
  description: 'Updated default theme',
  isDark: false,
  colors: ColorPaletteConfig(
    // Change any color values here
    primary: Color(0XFFYOUR_COLOR),
    cyan300: Color(0XFFYOUR_COLOR),
    // ... other colors
  ),
),
```

All changes will be reflected immediately throughout the app.

---

## Adding New Font Families

To add a new font family:

1. **Add the font files** to `assets/fonts/` directory

2. **Update `pubspec.yaml`** to include the font:

```yaml
fonts:
  - family: YourFontName
    fonts:
      - asset: assets/fonts/YourFontRegular.ttf
        weight: 400
      - asset: assets/fonts/YourFontBold.ttf
        weight: 700
```

3. **Add the font to `theme_config.dart`**:

```dart
static final Map<String, FontFamilyConfig> fontFamilies = {
  'Inter': FontFamilyConfig(...),
  'Poppins': FontFamilyConfig(...),
  'YourFontName': FontFamilyConfig(
    name: 'YourFontName',
    family: 'YourFontName',
    description: 'Your font description',
  ),
};
```

4. **Update the default font** (optional):

```dart
static const String defaultFontFamily = 'YourFontName';
```

---

## Customizing Font Sizes

Font sizes are controlled by font size scales in `theme_config.dart`. To modify sizes:

### Adjusting Scale Multipliers

```dart
'medium': FontSizeScale(
  name: 'Medium',
  scaleMultiplier: 1.0,  // Change this to scale all sizes
  baseSizes: {
    'bodyMedium': 14.0,
    // ... other sizes
  },
),
```

### Adjusting Individual Base Sizes

```dart
'medium': FontSizeScale(
  name: 'Medium',
  scaleMultiplier: 1.0,
  baseSizes: {
    'bodyMedium': 16.0,  // Changed from 14.0
    'titleLarge': 22.0,  // Changed from 20.0
    // ... other sizes
  },
),
```

### Adding a New Font Size Scale

```dart
'custom': FontSizeScale(
  name: 'Custom',
  scaleMultiplier: 1.15,
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
```

---

## Switching Themes Programmatically

### Change Theme

```dart
context.read<ThemeBloc>().add(
  ChangeThemeEvent(themeType: 'ocean'),
);
```

### Change Font Family

```dart
context.read<ThemeBloc>().add(
  ChangeFontFamilyEvent(fontFamily: 'Poppins'),
);
```

### Change Font Size Scale

```dart
context.read<ThemeBloc>().add(
  ChangeFontSizeScaleEvent(fontSizeScale: 'large'),
);
```

### Change Multiple Settings at Once

```dart
context.read<ThemeBloc>().add(
  ChangeCompleteThemeEvent(
    themeType: 'dark',
    fontFamily: 'Poppins',
    fontSizeScale: 'large',
  ),
);
```

### Available Theme Keys

- `'primary'` - Default light theme
- `'dark'` - Dark mode theme
- `'blue'` - Blue accent theme
- `'green'` - Green accent theme
- `'purple'` - Purple accent theme
- Any custom theme you add

### Available Font Families

- `'Inter'` - Default font
- `'Poppins'` - Alternative font
- Any custom font you add

### Available Font Size Scales

- `'small'` - 87.5% of base size
- `'medium'` - 100% of base size (default)
- `'large'` - 112.5% of base size
- `'extraLarge'` - 125% of base size
- Any custom scale you add

---

## Color Reference

### Material ColorScheme Colors

These colors follow Material Design 3 color system:

- **primary**: Main brand color
- **primaryContainer**: Container color for primary
- **secondary**: Secondary brand color
- **secondaryContainer**: Container color for secondary
- **background**: App background color
- **surface**: Surface/card background color
- **error**: Error state color
- **errorContainer**: Container color for errors
- **onPrimary**: Text/icon color on primary
- **onSecondary**: Text/icon color on secondary
- **onBackground**: Text/icon color on background
- **onSurface**: Text/icon color on surface
- **onError**: Text/icon color on error
- **onPrimaryContainer**: Text/icon color on primary container
- **onSecondaryContainer**: Text/icon color on secondary container
- **onErrorContainer**: Text/icon color on error container

### Custom App Colors

These are app-specific colors used throughout the UI:

- **cyan300**: Primary accent color (buttons, highlights)
- **cyan100**: Light cyan (subtle accents)
- **teal300**: Secondary accent color
- **teal50**: Very light teal (dividers, subtle backgrounds)
- **blue50**: Light blue background
- **gray50**: Very light gray background
- **gray500**: Medium gray (text, icons)
- **gray5001**: Light gray background variant
- **blueGray200**: Light blue-gray
- **blueGray300**: Medium blue-gray
- **blueGray600**: Dark blue-gray

---

## Examples

### Example 1: Creating a Red Theme

```dart
'red': ThemePresetConfig(
  name: 'Red',
  description: 'Bold red theme',
  isDark: false,
  colors: ColorPaletteConfig(
    primary: Color(0XFFFFFFFF),
    primaryContainer: Color(0XFFD32F2F),
    secondary: Color(0XFFEF5350),
    secondaryContainer: Color(0XFFEF9A9A),
    background: Color(0XFFFFFFFF),
    surface: Color(0XFFF5F5F5),
    error: Color(0XFFD32F2F),
    errorContainer: Color(0XFFEF9A9A),
    onPrimary: Color(0XFFB71C1C),
    onSecondary: Color(0XFFFFFFFF),
    onBackground: Color(0XFF212121),
    onSurface: Color(0XFF212121),
    onError: Color(0XFFFFFFFF),
    onPrimaryContainer: Color(0XFFFFFFFF),
    onSecondaryContainer: Color(0XFFB71C1C),
    onErrorContainer: Color(0XFFB71C1C),
    // Custom colors
    cyan300: Color(0XFFEF5350),
    cyan100: Color(0XFFEF9A9A),
    teal300: Color(0XFFD32F2F),
    teal50: Color(0XFFEFEBE9),
    blue50: Color(0XFFEFEBE9),
    gray50: Color(0XFFFAFAFA),
    gray500: Color(0XFF9E9E9E),
    gray5001: Color(0XFFF5F5F5),
    blueGray200: Color(0XFFEF9A9A),
    blueGray300: Color(0XFFEF5350),
    blueGray600: Color(0XFFD32F2F),
  ),
),
```

### Example 2: Using Theme in a Screen

```dart
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        // Access current theme
        final themeHelper = ThemeHelper(
          themeType: state.themeType,
          fontFamily: state.fontFamily,
          fontSizeScale: state.fontSizeScale,
        );
        
        return Scaffold(
          backgroundColor: themeHelper.themeData().scaffoldBackgroundColor,
          body: Text(
            'Hello World',
            style: themeHelper.themeData().textTheme.titleLarge,
          ),
        );
      },
    );
  }
}
```

### Example 3: Theme Settings Screen

```dart
class ThemeSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Theme Settings')),
      body: Column(
        children: [
          // Theme selector
          ListTile(
            title: Text('Theme'),
            trailing: DropdownButton<String>(
              value: context.watch<ThemeBloc>().state.themeType,
              items: ThemeConfig.themes.keys.map((key) {
                return DropdownMenuItem(
                  value: key,
                  child: Text(ThemeConfig.themes[key]!.name),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<ThemeBloc>().add(
                    ChangeThemeEvent(themeType: value),
                  );
                }
              },
            ),
          ),
          
          // Font family selector
          ListTile(
            title: Text('Font Family'),
            trailing: DropdownButton<String>(
              value: context.watch<ThemeBloc>().state.fontFamily,
              items: ThemeConfig.fontFamilies.keys.map((key) {
                return DropdownMenuItem(
                  value: key,
                  child: Text(ThemeConfig.fontFamilies[key]!.name),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<ThemeBloc>().add(
                    ChangeFontFamilyEvent(fontFamily: value),
                  );
                }
              },
            ),
          ),
          
          // Font size selector
          ListTile(
            title: Text('Font Size'),
            trailing: DropdownButton<String>(
              value: context.watch<ThemeBloc>().state.fontSizeScale,
              items: ThemeConfig.fontSizeScales.keys.map((key) {
                return DropdownMenuItem(
                  value: key,
                  child: Text(ThemeConfig.fontSizeScales[key]!.name),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<ThemeBloc>().add(
                    ChangeFontSizeScaleEvent(fontSizeScale: value),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## Best Practices

1. **Use ThemeConfig as Single Source of Truth**: Always modify themes through `theme_config.dart`, not by editing multiple files.

2. **Test Color Contrast**: Ensure sufficient contrast between text and background colors, especially for accessibility.

3. **Consistent Color Usage**: Use the same color palette across all themes for consistency (e.g., always use `cyan300` for primary actions).

4. **Font Size Scales**: Use font size scales rather than hardcoding sizes to support accessibility.

5. **Theme Naming**: Use descriptive, lowercase keys for theme names (e.g., `'ocean'`, `'forest'`, not `'Ocean'` or `'OCEAN'`).

---

## Troubleshooting

### Theme Not Applying

- Ensure the theme key exists in `ThemeConfig.themes`
- Check that `ThemeBloc` is properly initialized with the theme key
- Verify `PrefUtils` is initialized before accessing theme data

### Font Not Displaying

- Verify font files are in `assets/fonts/` directory
- Check `pubspec.yaml` includes the font family
- Ensure font family name matches exactly (case-sensitive)
- Run `flutter pub get` after adding fonts

### Colors Not Updating

- Clear app data or reinstall the app (preferences may be cached)
- Verify all color properties are set in `ColorPaletteConfig`
- Check that `ThemeHelper` is using the correct theme configuration

---

## Additional Resources

- [Material Design 3 Color System](https://m3.material.io/styles/color/the-color-system/overview)
- [Flutter Theming Guide](https://docs.flutter.dev/cookbook/design/themes)
- [Accessibility Guidelines](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html)

