import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class NaverMapView extends StatelessWidget {
  final DraggableScrollableController dragController;
  final Completer<NaverMapController> controller;
  final Position? currentPosition;

  const NaverMapView({
    super.key,
    required this.controller,
    required this.currentPosition,
    required this.dragController,
  });

  // 지도 준비 완료
  void _onMapReady(NaverMapController controller) {
    this.controller.complete(controller);
  }

  // 지도 클릭
  void _onMapTapped(NPoint point, NLatLng latLng) {
    dragController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  // 심볼 클릭
  void _onSymbolTapped(NSymbolInfo symbolInfo) {}

  // 카메라 이동 중
  void _onCameraChange(NCameraUpdateReason reason, bool animated) {}

  // 카메라 이동 끝
  void _onCameraIdle() {}

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
        logoAlign: NLogoAlign.leftTop,
        extent: const NLatLngBounds(
          southWest: NLatLng(31.43, 122.37),
          northEast: NLatLng(44.35, 132.0),
        ),
      ),
      onMapReady: _onMapReady,
      onMapTapped: _onMapTapped,
      onSymbolTapped: _onSymbolTapped,
      onCameraChange: _onCameraChange,
      onCameraIdle: _onCameraIdle,
    );
  }
}
