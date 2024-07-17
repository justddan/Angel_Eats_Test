import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class NaverMapView extends StatelessWidget {
  final Position? currentPosition;
  final Function(NaverMapController controller) onMapReady;
  final Function(NPoint point, NLatLng latLng) onMapTapped;
  final Function(NSymbolInfo symbolInfo) onSymbolTapped;
  final Function(NCameraUpdateReason reason, bool animated) onCameraChange;
  final Function() onCameraIdle;

  const NaverMapView({
    super.key,
    required this.currentPosition,
    required this.onMapReady,
    required this.onMapTapped,
    required this.onSymbolTapped,
    required this.onCameraChange,
    required this.onCameraIdle,
  });

  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: NLatLng(
            currentPosition!.latitude,
            currentPosition!.longitude,
          ),
          zoom: 15,
        ),
        indoorEnable: false,
        logoClickEnable: false,
        rotationGesturesEnable: false,
        logoAlign: NLogoAlign.leftTop,
        extent: const NLatLngBounds(
          southWest: NLatLng(31.43, 122.37),
          northEast: NLatLng(44.35, 132.0),
        ),
      ),
      onMapReady: onMapReady,
      onMapTapped: onMapTapped,
      onSymbolTapped: onSymbolTapped,
      onCameraChange: onCameraChange,
      onCameraIdle: onCameraIdle,
    );
  }
}
