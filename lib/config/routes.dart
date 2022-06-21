import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_tour_app/home_screen/presentation/screens/home_screen.dart';
import 'package:virtual_tour_app/map_screen/presentation/screens/map_screen.dart';

import '../common/screens/about_screen.dart';
import '../splash_screen/presentation/screens/splash_screen.dart';

final routes = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  routes: [
    GoRoute(
      path: '/',
      redirect: (state) => SplashScreen.route,
    ),
    GoRoute(
      name: SplashScreen.name,
      path: SplashScreen.route,
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    GoRoute(
      name: HomeScreen.name,
      path: HomeScreen.route,
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
    ),
    GoRoute(
      name: MapScreen.name,
      path: MapScreen.route,
      builder: (BuildContext context, GoRouterState state) => const MapScreen(),
    ),
    GoRoute(
      name: AboutScreen.name,
      path: AboutScreen.route,
      builder: (BuildContext context, GoRouterState state) =>
          const AboutScreen(),
    ),
  ],
);
