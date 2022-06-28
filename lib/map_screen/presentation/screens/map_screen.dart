import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';
import 'package:virtual_tour_app/common/components/main_bottom_bar.dart';
import 'package:virtual_tour_app/home_screen/domain/model/tourist_spot_state.dart';
import 'package:virtual_tour_app/home_screen/presentation/view_model/tourist_spots_view_model.dart';
import 'package:virtual_tour_app/map_screen/presentation/components/image_network.dart';

import '../../../details_screen/presentation/screens/details_screen.dart';
import '../../../home_screen/domain/model/tourist_spot.dart';
import '../view_model/directions_view_model.dart';

const kDirectionsStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.w500,
  fontFamily: 'Poppins',
);

class MapScreen extends StatefulHookWidget {
  static const name = 'MapScreen';
  static const route = '/map';
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> markers = {};
  final mapController = Completer();

  static const CameraPosition buenavistaLocation = CameraPosition(
    target: LatLng(10.05755712041461, 124.14327011433134),
    zoom: 12,
  );

  Future<void> _animateToLocation(CameraPosition target) async {
    final controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(target));
  }

  //helper function
  void setMapStyle(String mapStyle, GoogleMapController mapController) {
    mapController.setMapStyle(mapStyle);
  }

  //helper function
  Future<String> getJsonFile(String path) async {
    ByteData byte = await rootBundle.load(path);
    var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
    return utf8.decode(list);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = useProvider(touristSpotsViewModel);
    final directions = useProvider(directionsViewModel);
    final directionViewModel = useProvider(directionsViewModel.notifier);
    final enableWaypoints = useState(false);
    final touristSpot = useState<TouristSpot?>(null);
    LatLng? destination;
    LatLng? current;

    if (state.status == TouristSpotStatus.loaded) {
      for (var element in state.items) {
        final location = element.location.replaceAll(' ', '').split(',');
        final latitude = double.parse(location[0]);
        final longitude = double.parse(location[1]);
        final markerId = MarkerId(element.id.toString());
        markers.add(
          Marker(
            markerId: markerId,
            position: LatLng(latitude, longitude),
            onTap: () {
              enableWaypoints.value = false;
              destination = LatLng(latitude, longitude);
              touristSpot.value = element;
            },
          ),
        );
      }
    }

    _loadCurrentLocation() async {
      final currentLocation = Location();
      await currentLocation.getLocation();
      return currentLocation.onLocationChanged.listen(
        (origin) {
          if (enableWaypoints.value && destination != null) {
            current = LatLng(origin.latitude ?? 0.0, origin.longitude ?? 0.0);
            directionViewModel.getDirections(
              origin: current!,
              destination: destination!,
            );
          }
        },
      );
    }

    useEffect(() {
      Future.microtask(() => _loadCurrentLocation());
      return;
    }, []);

    return Scaffold(
      bottomNavigationBar: MainBottomBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF202A42),
        onPressed: () {
          _animateToLocation(buenavistaLocation);
        },
        child: const Icon(Icons.my_location),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            initialCameraPosition: buenavistaLocation,
            markers: markers,
            polylines: enableWaypoints.value ? directions.polylinePoints : {},
            onMapCreated: (controller) {
              mapController.complete(controller);
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0, bottom: 90.0),
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF202A42),
                onPressed: () {
                  enableWaypoints.value = !enableWaypoints.value;
                },
                child: const Icon(Icons.directions),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0, bottom: 160.0),
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF202A42),
                onPressed: () {
                  if (touristSpot.value != null) {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      builder: (context) {
                        return SizedBox(
                          height: 300,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ImageNetwork(
                                  url: touristSpot.value!.image,
                                  height: 100,
                                  width: 100,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  touristSpot.value!.name,
                                  textAlign: TextAlign.center,
                                  style: kDirectionsStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  touristSpot.value!.location,
                                  style: kDirectionsStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF202A42),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                          id: touristSpot.value!.id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.card_travel),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Go to details',
                                        style: kDirectionsStyle.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: const Icon(Icons.details),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0, top: 15.0),
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF202A42),
                onPressed: () {
                  if (current != null) {
                    Future.microtask(
                      () => _animateToLocation(
                        CameraPosition(
                          target: current!,
                          zoom: 12,
                        ),
                      ),
                    );
                  }
                },
                child: const Icon(Icons.man),
              ),
            ),
          ),
          if (enableWaypoints.value)
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFF202A42),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Duration: ${directions.duration ?? ''}',
                          style: kDirectionsStyle,
                        ),
                        Text(
                          'Distance: ${directions.distance ?? ''}',
                          style: kDirectionsStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
