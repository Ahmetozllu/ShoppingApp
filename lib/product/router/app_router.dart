import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_app/feature/home/view/home_view.dart';
import 'package:shopping_app/feature/home/widget/bottom_widget.dart';
import 'package:shopping_app/feature/splash/splash_view.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: "/",
    builder: (BuildContext context, GoRouterState state) {
      return const SplashView();
    },
    routes: <RouteBase>[
      GoRoute(
        path: 'bottom',
        builder: (BuildContext context, GoRouterState state) {
          return const BottomWidget();
        },
      ),
      GoRoute(
        path: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
      ),
    ],
  ),
]);


//shellroutera bak 

