import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:virtual_tour_app/common/components/main_bottom_bar.dart';
import 'package:virtual_tour_app/config/constants.dart';

class AboutScreen extends HookWidget {
  static const name = 'AboutScreen';
  static const route = '/about';
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MainBottomBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 10,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  kLogoPath,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10),
                const Text(
                  kBrandName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'The capstone project “BueNearby Tourist Spots Virtual Tour App” was design to deliver information about a certain location without having to physically visit it, but everything should be done virtually. Travellers and tourist spot owners, both public and private, will benefit from the study’s result. The Buenearby Tourist Spots Virtual Tour App (BTSVTA) is a platform that allows users to use the Google map (which is pre-loaded in the app) to determine the exact direction and location of their preferred tourist attractions.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Group Leader:',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text('JV Batausa'),
                      SizedBox(height: 5),
                      Text(
                        'Members: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text('Arlene Camacho'),
                      Text('Herna Millanes'),
                      Text('Cemie Betalmos'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
