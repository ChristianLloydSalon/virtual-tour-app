import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:virtual_tour_app/common/components/custom_loading_indicator.dart';
import 'package:virtual_tour_app/splash_screen/presentation/view_model/health_check_view_model.dart';

class SplashScreen extends HookWidget {
  static const name = 'SplashScreen';
  static const route = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(healthCheckViewModel);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CustomLoadingIndicator(),
            SizedBox(height: 10),
            Text('Please wait...'),
          ],
        ),
      ),
    );
  }
}
