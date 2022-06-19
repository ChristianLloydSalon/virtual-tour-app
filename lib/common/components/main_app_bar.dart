import 'package:flutter/material.dart';
import 'package:virtual_tour_app/config/constants.dart';

class MainAppBar extends PreferredSize {
  MainAppBar({
    Key? key,
  }) : super(
          key: key,
          child: Container(),
          preferredSize: const Size.fromHeight(kToolbarHeight),
        );

  @override
  Widget build(BuildContext context) {
    return const _AppBar();
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(kBrandName),
    );
  }
}
