import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:virtual_tour_app/config/constants.dart';
import 'package:virtual_tour_app/home_screen/presentation/screens/home_screen.dart';

class ReminderScreen extends HookWidget {
  static const name = 'ReminderScreen';
  static const route = '/reminder';
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final isGpsOn = useState(false);

    if (isGpsOn.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(HomeScreen.route);
      });
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 60,
                color: Colors.blue,
              ),
              const SizedBox(height: 10),
              const Text(
                'APP REMINDER',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: kFontFamilySecondary,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '➊ Make sure to have a stable internet connection for better experience.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: kFontFamilySecondary,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '➋ Kindly turn on the GPS on your phone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: kFontFamilySecondary,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    isLoading.value = true;
                    final location = Location();
                    final isOn = await location.serviceEnabled();

                    if (!isOn) {
                      final isTurnedOn = await location.requestService();
                      if (isTurnedOn) {
                        isGpsOn.value = true;
                      } else {
                        isLoading.value = false;
                      }
                    } else {
                      isGpsOn.value = true;
                    }
                  },
                  child: isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Turn on GPS'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
