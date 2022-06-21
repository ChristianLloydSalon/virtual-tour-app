import 'package:flutter/material.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:virtual_tour_app/config/constants.dart';
import 'package:virtual_tour_app/config/environment.dart';
import 'package:virtual_tour_app/config/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DirectionsService.init(AppConfig.googleMapsApi);
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: kBrandName,
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      routeInformationProvider: routes.routeInformationProvider,
      routeInformationParser: routes.routeInformationParser,
      routerDelegate: routes.routerDelegate,
    );
  }
}
