import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/product/theme/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemaState> {
  ThemeCubit()
      : super(
          ThemaState(
            isDark: false,
            themeData: AppTheme.lightTheme,
          ),
        );

  void toggleTheme() {
    final isDark = !state.isDark;
    emit(state.copyWith(
      isDark: isDark,
      themeData: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
    ));
  }
}
