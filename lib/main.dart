import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/feature/home/cubit/item/item_cubit.dart';
import 'package:shopping_app/product/router/app_router.dart';
import 'package:shopping_app/product/theme/app_theme.dart';
import 'package:shopping_app/product/theme/cubit/theme_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411, 890),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ItemCubit(),
              ),
              BlocProvider(
                create: (context) => ThemeCubit(),
              ),
            ],
            child: BlocBuilder<ThemeCubit, ThemaState>(
              builder: (context, state) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: state.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
                  routerConfig: router,
                );
              },
            ),
          );
        });
  }
}
