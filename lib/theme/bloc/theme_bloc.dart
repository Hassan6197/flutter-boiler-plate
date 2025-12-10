import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_boilerplate/core/utils/pref_utils.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(ThemeState initialState) : super(initialState) {
    on<ChangeThemeEvent>(_changeTheme);
    on<ChangeFontFamilyEvent>(_changeFontFamily);
    on<ChangeFontSizeScaleEvent>(_changeFontSizeScale);
    on<ChangeCompleteThemeEvent>(_changeCompleteTheme);
    // Backward compatibility
    on<ThemeChangeEvent>(_changeTheme);
  }

  _changeTheme(
    ChangeThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(themeType: event.themeType));
  }

  _changeFontFamily(
    ChangeFontFamilyEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(fontFamily: event.fontFamily));
  }

  _changeFontSizeScale(
    ChangeFontSizeScaleEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(fontSizeScale: event.fontSizeScale));
  }

  _changeCompleteTheme(
    ChangeCompleteThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(
      themeType: event.themeType,
      fontFamily: event.fontFamily,
      fontSizeScale: event.fontSizeScale,
    ));
  }
}
