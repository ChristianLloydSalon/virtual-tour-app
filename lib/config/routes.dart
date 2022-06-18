import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  ],
);
