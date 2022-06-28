import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:virtual_tour_app/common/screens/reminder_screen.dart';
import 'package:virtual_tour_app/config/constants.dart';

import '../../domain/model/onboarding_page_model.dart';
import '../components/onboarding_page_image.dart';
import '../components/onboarding_page_text.dart';

final _kTitleTextStyle = TextStyle(
  fontSize: 24,
  fontFamily: kFontFamilySecondary,
  fontWeight: FontWeight.w600,
  color: Colors.blue.shade300,
);

const _kDescriptionTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  fontFamily: kFontFamilySecondary,
);

class OnBoardingScreen extends HookWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  static const name = 'OnboardingScreen';
  static const route = '/onboarding';

  final _pageList = [
    OnBoardingPageModel(
      title: 'Welcome to $kBrandName',
      description: 'Explore the hottest tourist spots now.',
      image: kLogoPath,
    ),
    OnBoardingPageModel(
      title: 'Search',
      description: 'Want to know more about the place? Search for it.',
      image: 'assets/images/onboarding/onboarding_search.png',
    ),
    OnBoardingPageModel(
      title: 'Navigate',
      description:
          'Choose your destination and be able to view current location in real time on the map.',
      image: 'assets/images/onboarding/onboarding_navigate.png',
    ),
    OnBoardingPageModel(
      title: 'Explore',
      description:
          'Visit the different tourist spots in Buenavista and have a fun and enjoyable trip.',
      image: 'assets/images/onboarding/onboarding_explore.png',
    ),
  ];

  final _pageDecoration = const PageDecoration(
    imagePadding: EdgeInsets.only(top: 20),
    titleTextStyle: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: Color(0xFF3E3E3E),
    ),
    bodyTextStyle: TextStyle(
      fontSize: 16.0,
      color: Color(0xFF3E3E3E),
    ),
  );

  @override
  Widget build(BuildContext context) {
    _goToReminderScreen() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(ReminderScreen.route);
      });
    }

    return Scaffold(
      body: IntroductionScreen(
        pages: _pageList
            .map(
              (page) => PageViewModel(
                titleWidget: OnBoardingPageText(
                  text: page.title,
                  textStyle: _kTitleTextStyle,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                ),
                bodyWidget: OnBoardingPageText(
                  text: page.description,
                  textStyle: _kDescriptionTextStyle,
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                ),
                image: OnBoardingPageImage(image: page.image),
                decoration: _pageDecoration,
              ),
            )
            .toList(),
        showSkipButton: true,
        showNextButton: true,
        skip: const Text('Skip'),
        next: const Text('Next'),
        done: const Text('Done'),
        onDone: _goToReminderScreen,
        onSkip: _goToReminderScreen,
      ),
    );
  }
}
