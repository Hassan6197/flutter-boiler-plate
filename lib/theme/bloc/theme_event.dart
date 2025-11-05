part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ThemeChangeEvent extends ThemeEvent {
  ThemeChangeEvent({required this.themeType}) : super() {
    PrefUtils().setThemeData(themeType);
  }

  final String themeType;

  @override
  List<Object?> get props => [];
}
