import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_tour_app/home_screen/presentation/screens/home_screen.dart';
import 'package:virtual_tour_app/map_screen/presentation/screens/map_screen.dart';

class MainBottomBar extends PreferredSize {
  MainBottomBar({
    Key? key,
  }) : super(
          key: key,
          child: Container(),
          preferredSize: const Size.fromHeight(kToolbarHeight),
        );

  @override
  Widget build(BuildContext context) {
    return const _BottomBar();
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return ConvexAppBar(
      backgroundColor: const Color(0xFF202A42),
      initialActiveIndex: currentRoute == HomeScreen.name
          ? 0
          : currentRoute == MapScreen.name
              ? 1
              : 2,
      items: const [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.location_on, title: 'Explore'),
        TabItem(icon: Icons.help, title: 'About'),
      ],
      onTap: (value) {
        if (value == 0) {
          context.go(HomeScreen.route);
        } else if (value == 1) {
          context.go(MapScreen.route);
        }
      },
    );
  }
}
