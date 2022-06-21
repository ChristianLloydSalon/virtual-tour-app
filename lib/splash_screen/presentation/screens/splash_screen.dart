import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:virtual_tour_app/common/components/custom_loading_indicator.dart';
import 'package:virtual_tour_app/config/constants.dart';
import 'package:virtual_tour_app/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:virtual_tour_app/splash_screen/domain/model/heatlh_check_state.dart';
import 'package:virtual_tour_app/splash_screen/presentation/view_model/health_check_view_model.dart';

class SplashScreen extends HookWidget {
  static const name = 'SplashScreen';
  static const route = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(healthCheckViewModel);

    if (state.status == HeatlhCheckStatus.error) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          showAnimatedDialog(
            context: context,
            builder: (BuildContext context) {
              return ClassicGeneralDialogWidget(
                titleText: kDefaultErrorMessage,
                contentText: state.error,
                positiveText: 'OK',
                onPositiveClick: () {
                  SystemNavigator.pop();
                },
              );
            },
            animationType: DialogTransitionType.size,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(seconds: 1),
          );
        },
      );
    }

    if (state.status == HeatlhCheckStatus.loaded) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          context.go(OnBoardingScreen.route);
        },
      );
    }

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
