import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class RestaurantLocationView extends StatelessWidget {
  final double latitude ;
  final double longitude ;



  const RestaurantLocationView({super.key, required this.latitude, required this.longitude});
  @override
  Widget build(BuildContext context) {
    MapController controller = MapController(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(
          latitude:latitude,
          longitude: longitude
      ),
    );
    return OSMFlutter(
      controller: controller,
      trackMyPosition: true,
      initZoom: 12,
      minZoomLevel: 8,
      maxZoomLevel: 19,
      stepZoom: 1.0,
      showDefaultInfoWindow: true,
      showZoomController: true,
      userLocationMarker: UserLocationMaker(
          personMarker: MarkerIcon(
            icon: Icon(Icons.location_pin,color: Colors.red,size: 48,),
          ),
        directionArrowMarker: MarkerIcon(
          icon: Icon(Icons.location_pin,color: Colors.red,size: 100,),
        ),

      ),
    );
  }
}
