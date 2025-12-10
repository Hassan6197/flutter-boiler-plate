part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeThemeEvent extends ThemeEvent {
  ChangeThemeEvent({required this.themeType}) : super() {
    PrefUtils().setThemeData(themeType);
  }

  final String themeType;

  @override
  List<Object?> get props => [themeType];
}

class ChangeFontFamilyEvent extends ThemeEvent {
  ChangeFontFamilyEvent({required this.fontFamily}) : super() {
    PrefUtils().setFontFamily(fontFamily);
  }

  final String fontFamily;

  @override
  List<Object?> get props => [fontFamily];
}

class ChangeFontSizeScaleEvent extends ThemeEvent {
  ChangeFontSizeScaleEvent({required this.fontSizeScale}) : super() {
    PrefUtils().setFontSizeScale(fontSizeScale);
  }

  final String fontSizeScale;

  @override
  List<Object?> get props => [fontSizeScale];
}

class ChangeCompleteThemeEvent extends ThemeEvent {
  ChangeCompleteThemeEvent({
    this.themeType,
    this.fontFamily,
    this.fontSizeScale,
  }) : super() {
    if (themeType != null) {
      PrefUtils().setThemeData(themeType!);
    }
    if (fontFamily != null) {
      PrefUtils().setFontFamily(fontFamily!);
    }
    if (fontSizeScale != null) {
      PrefUtils().setFontSizeScale(fontSizeScale!);
    }
  }

  final String? themeType;
  final String? fontFamily;
  final String? fontSizeScale;

  @override
  List<Object?> get props => [themeType, fontFamily, fontSizeScale];
}

// Backward compatibility alias
class ThemeChangeEvent extends ChangeThemeEvent {
  ThemeChangeEvent({required super.themeType});
}
