part of 'theme_bloc.dart';

@immutable
class ThemeState extends Equatable {
  ThemeState({
    required this.themeType,
    required this.fontFamily,
    required this.fontSizeScale,
  });

  final String themeType;
  final String fontFamily;
  final String fontSizeScale;

  @override
  List<Object?> get props => [themeType, fontFamily, fontSizeScale];
  
  ThemeState copyWith({
    String? themeType,
    String? fontFamily,
    String? fontSizeScale,
  }) {
    return ThemeState(
      themeType: themeType ?? this.themeType,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSizeScale: fontSizeScale ?? this.fontSizeScale,
    );
  }
}
