import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_tour_app/home_screen/presentation/screens/home_screen.dart';

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
    return ConvexAppBar(
      items: const [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.gps_fixed, title: 'Explore'),
        TabItem(icon: Icons.help, title: 'About'),
      ],
      onTap: (value) {
        if (value == 1) {
          context.go(HomeScreen.route);
        }
      },
    );
  }
}
