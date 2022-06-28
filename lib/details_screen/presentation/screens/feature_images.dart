import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:virtual_tour_app/map_screen/presentation/components/image_network.dart';

import '../../di/feature_service_locator.dart';
import '../../domain/model/feature_picture.dart';

class FeatureImagesScreen extends HookWidget {
  final int touristSpotId;
  final int featureId;

  const FeatureImagesScreen({
    Key? key,
    required this.touristSpotId,
    required this.featureId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pictures = useState<List<FeaturePicture>>([]);

    _load() async {
      pictures.value = await featuresRepository.getFeaturePictures(
        touristSpotId: touristSpotId,
        featureId: featureId,
      );
    }

    useEffect(() {
      Future.microtask(() => _load());
      return;
    }, []);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF202A42),
          title: const Text('Images'),
        ),
        body: pictures.value.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  child: CustomScrollView(
                    slivers: [
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return ImageNetwork(url: pictures.value[index].url);
                          },
                          childCount: pictures.value.length,
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
