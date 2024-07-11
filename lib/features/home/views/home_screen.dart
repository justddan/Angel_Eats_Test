import 'dart:async';

import 'package:angel_eats_test/features/home/views/widgets/draggable_sheet_view.dart';
import 'package:angel_eats_test/features/home/views/widgets/naver_map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<NaverMapController> _mapController = Completer();
  Position? _currentPosition;

  final DraggableScrollableController _dragController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _dragController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _currentPosition = position;
    });

    final NaverMapController controller = await _mapController.future;

    controller.updateCamera(NCameraUpdate.scrollAndZoomTo(
      target: NLatLng(position.latitude, position.longitude),
      zoom: 15,
    ));

    final currentMarker = NMarker(
      id: "0",
      position: NLatLng(
        position.latitude,
        position.longitude,
      ),
    );

    // currentMarker.setOnTapListener((NMarker marker) {
    //   print("마커가 터치되었습니다. id: ${marker.info.id}");
    // });

    controller.addOverlay(currentMarker);
  }

  void _goToCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _currentPosition = position;
    });

    final NaverMapController controller = await _mapController.future;
    controller.updateCamera(NCameraUpdate.scrollAndZoomTo(
      target: NLatLng(position.latitude, position.longitude),
      zoom: 15,
    ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _toggleListView() {
    if (_dragController.size == 0) {
      _dragController.animateTo(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _dragController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO
    // 1. 현재 위치 커스텀 마커
    // 2. 식당 커스텀 마커
    //  (1) 목업 만들기
    // 3. FloatingActionButton 커스텀
    // 4. 식당 커스텀 마커 클릭 이벤트
    // 5. DraggableScrollableSheet에서 조금만 내려도 시트 닫기
    // 6. 마커 줌 레벨 범위 정하기

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            _currentPosition == null
                ? const Center(child: CircularProgressIndicator())
                : NaverMapView(
                    controller: _mapController,
                    currentPosition: _currentPosition,
                    dragController: _dragController,
                  ),
            Positioned(
              bottom: 15,
              left: 15,
              child: GestureDetector(
                onTap: _goToCurrentLocation,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            DraggableSheetView(
              controller: _dragController,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleListView,
      ),
    );
  }
}
