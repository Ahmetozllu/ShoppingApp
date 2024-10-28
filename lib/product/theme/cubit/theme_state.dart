
part of 'theme_cubit.dart';

class ThemaState extends Equatable {
  final bool isDark;
  final ThemeData themeData;

  const ThemaState({
    required this.isDark,
    required this.themeData,
  });

  
  @override
  List<Object?> get props => [isDark, themeData];

  ThemaState copyWith({
    bool? isDark,
    ThemeData? themeData,
  }) {
    return ThemaState(
      isDark: isDark ?? this.isDark,
      themeData: themeData ?? this.themeData,
    );
  }
}

