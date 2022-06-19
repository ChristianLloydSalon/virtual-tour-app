import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:virtual_tour_app/common/components/custom_loading_indicator.dart';
import 'package:virtual_tour_app/common/components/main_app_bar.dart';
import 'package:virtual_tour_app/common/components/main_bottom_bar.dart';
import 'package:virtual_tour_app/home_screen/domain/model/tourist_spot_state.dart';
import 'package:virtual_tour_app/home_screen/presentation/components/tourist_spot_card.dart';
import 'package:virtual_tour_app/home_screen/presentation/view_model/tourist_spots_view_model.dart';

class HomeScreen extends HookWidget {
  static const name = 'HomeScreen';
  static const route = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(touristSpotsViewModel);

    return SafeArea(
      child: Scaffold(
        appBar: MainAppBar(),
        bottomNavigationBar: MainBottomBar(),
        body: Column(
          children: [
            Expanded(
              child: (state.status == TouristSpotStatus.loading)
                  ? const Center(child: CustomLoadingIndicator())
                  : VerticalCardPager(
                      initialPage: 1,
                      titles: state.items.map((spot) => spot.name).toList(),
                      images: state.items
                          .map((spot) => TouristSpotCard(imageUrl: spot.image))
                          .toList(),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white54,
                      ),
                      onSelectedItem: (index) {
                        print(state.items[index].name);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
