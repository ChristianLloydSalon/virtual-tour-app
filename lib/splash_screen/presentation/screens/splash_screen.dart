import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:virtual_tour_app/splash_screen/domain/model/heatlh_check_state.dart';
import 'package:virtual_tour_app/splash_screen/presentation/view_model/health_check_view_model.dart';

class SplashScreen extends HookWidget {
  static const name = 'SplashScreen';
  static const route = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(healthCheckViewModel);

    return Scaffold(
      body: Container(
        child: state.status == HeatlhCheckStatus.loading
            ? const Text('Loading')
            : const Text('Hi'),
      ),
    );
  }
}
