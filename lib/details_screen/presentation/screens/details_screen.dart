import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:virtual_tour_app/details_screen/domain/model/spot_state.dart';
import 'package:virtual_tour_app/details_screen/domain/model/video_state.dart';
import 'package:virtual_tour_app/details_screen/presentation/components/feature_card.dart';
import 'package:virtual_tour_app/details_screen/presentation/components/video_preview.dart';
import 'package:virtual_tour_app/details_screen/presentation/view_model/features_view_model.dart';
import 'package:virtual_tour_app/details_screen/presentation/view_model/tourist_spot_view_model.dart';
import 'package:virtual_tour_app/details_screen/presentation/view_model/videos_view_model.dart';
import 'package:virtual_tour_app/home_screen/domain/model/tourist_spot.dart';
import 'package:virtual_tour_app/map_screen/presentation/components/image_network.dart';

import '../../domain/model/feature_state.dart';

class DetailsScreen extends HookWidget {
  final int id;
  const DetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(touristSpotViewModel(id));
    final tabController = useTabController(initialLength: 4);

    return Scaffold(
      body: state.status == SpotStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                        ),
                        child: ImageNetwork(
                          url: state.item?.image ?? '',
                          width: double.infinity,
                          height: 300,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white24,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.item?.name ?? '',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(Icons.star, color: Colors.yellow),
                    ),
                  ],
                ),
                TabBar(
                  isScrollable: true,
                  labelColor: Colors.blue,
                  indicatorColor: Colors.blue.shade300,
                  unselectedLabelColor: Colors.black45,
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                  controller: tabController,
                  tabs: const [
                    Tab(
                      text: 'Overview',
                    ),
                    Tab(
                      text: 'Features',
                    ),
                    Tab(
                      text: 'Videos',
                    ),
                    Tab(
                      text: 'Contacts',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      _OverviewPage(spot: state.item!),
                      _FeaturesView(spot: state.item!),
                      _VideosListView(touristId: state.item!.id),
                      _ContactsView(spot: state.item!),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _OverviewPage extends StatelessWidget {
  final TouristSpot spot;
  const _OverviewPage({
    Key? key,
    required this.spot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              spot.description,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
            _ListView(
              listIcon: Icons.check,
              label: 'Preparations',
              list: spot.preparations,
            ),
            _ListView(
              listIcon: Icons.check,
              label: 'Expenditures',
              list: spot.expenditures,
            ),
            _ListView(
              listIcon: Icons.warning,
              label: 'Restrictions',
              list: spot.restrictions,
            ),
          ],
        ),
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  final IconData listIcon;
  final String label;
  final List<String> list;
  const _ListView({
    Key? key,
    required this.listIcon,
    required this.label,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        const Divider(
          color: Colors.blue,
          thickness: 2,
        ),
        const SizedBox(height: 5),
        if (list.isEmpty) ...[
          const Center(
            child: Text(
              'No data',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ] else ...[
          ...list
              .map(
                (e) => ListTile(
                  leading: Icon(listIcon),
                  title: Text(
                    e,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ],
    );
  }
}

class _FeaturesView extends HookWidget {
  final TouristSpot spot;
  const _FeaturesView({
    Key? key,
    required this.spot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(featuresViewModel(spot.id));

    if (state.status == FeatureStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == FeatureStatus.error || state.items.isEmpty) {
      return const Center(child: Text('No Data Available'));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...state.items
                .map((feature) => FeatureCard(feature: feature))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class _ContactsView extends StatelessWidget {
  final TouristSpot spot;
  const _ContactsView({
    Key? key,
    required this.spot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.phone,
            color: Colors.blue,
          ),
          title: Text(
            spot.contactNumber.isEmpty ? 'No data' : spot.contactNumber,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.email,
            color: Colors.blueGrey,
          ),
          title: Text(
            spot.email.isEmpty ? 'No data' : spot.email,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.location_on,
            color: Colors.red,
          ),
          title: Text(
            spot.location.isEmpty ? 'No data' : spot.location,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class _VideosListView extends HookWidget {
  final int touristId;
  const _VideosListView({
    Key? key,
    required this.touristId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(videosViewModel(touristId));
    return state.status == VideoStatus.loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : state.status == VideoStatus.error
            ? const Center(
                child: Text('Error'),
              )
            : state.status == VideoStatus.loaded
                ? (state.items.isEmpty)
                    ? const Center(
                        child: Text('No videos available'),
                      )
                    : ListView.builder(
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final video = state.items[index];
                          return VideoPreview(videoUrl: video.url);
                        },
                      )
                : const SizedBox();
  }
}
