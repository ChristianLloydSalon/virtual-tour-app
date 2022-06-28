import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:virtual_tour_app/details_screen/di/feature_service_locator.dart';
import 'package:virtual_tour_app/details_screen/presentation/screens/feature_images.dart';

import '../../../map_screen/presentation/components/image_network.dart';
import '../../domain/model/feature.dart';
import '../../domain/model/feature_picture.dart';

class FeatureCard extends HookWidget {
  final Feature feature;
  const FeatureCard({
    Key? key,
    required this.feature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pictures = useState<List<FeaturePicture>>([]);

    _load() async {
      pictures.value = await featuresRepository.getFeaturePictures(
        touristSpotId: feature.touristSpotId,
        featureId: feature.featureId,
      );
    }

    useEffect(() {
      Future.microtask(() => _load());
      return;
    }, const []);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeatureImagesScreen(
              touristSpotId: feature.touristSpotId,
              featureId: feature.featureId,
            ),
          ),
        );
      },
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              child: pictures.value.isEmpty
                  ? const Center(
                      child: Text('No image available'),
                    )
                  : ImageNetwork(
                      url: pictures.value.first.url,
                      width: double.infinity,
                      height: 400,
                    ),
            ),
            Container(
              color: Colors.white60,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      feature.feature,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    if (feature.details.isNotEmpty)
                      Text(
                        feature.details,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    if (feature.otherDetails.isNotEmpty)
                      Text(
                        feature.otherDetails,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    if (feature.price.isNotEmpty)
                      Text(
                        'Price: ${feature.price}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
