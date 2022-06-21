import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:virtual_tour_app/common/components/main_bottom_bar.dart';
import 'package:virtual_tour_app/config/constants.dart';
import 'package:virtual_tour_app/home_screen/domain/model/tourist_spot.dart';
import 'package:virtual_tour_app/home_screen/presentation/components/tourist_spot_card.dart';
import 'package:virtual_tour_app/home_screen/presentation/view_model/tourist_spots_view_model.dart';

const border = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.white, width: 1.0),
);

class HomeScreen extends HookWidget {
  static const name = 'HomeScreen';
  static const route = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final search = useState('');

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: MainBottomBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _SearchArea(query: search),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Text(
                'Hottest places',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: _TouristSpotsListView(query: search.value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchArea extends StatelessWidget {
  final ValueNotifier<String> query;
  const _SearchArea({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          // background image
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
              ),
              child: Image.asset(
                'assets/images/background.jpeg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          // search bar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hi,',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Where do you want to go?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    query.value = value;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white24,
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    prefixIconColor: Colors.white,
                    iconColor: Colors.white,
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 80,
              color: Colors.white24,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      kBrandName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Explore the hottest tourist spots.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TouristSpotsListView extends HookWidget {
  final String query;
  const _TouristSpotsListView({
    Key? key,
    required this.query,
  }) : super(key: key);

  List<TouristSpot> _getFilteredList(List<TouristSpot> spots, String query) {
    final filtered = spots
        .where((spot) => spot.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final state = useProvider(touristSpotsViewModel);
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        for (final spot in _getFilteredList(state.items, query))
          TouristSpotCard(
            spot: spot,
            width: 200,
            height: 260,
          ),
      ],
    );
  }
}
