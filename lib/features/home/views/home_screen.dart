import 'dart:async';

import 'package:angel_eats_test/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<NaverMapController> _mapController = Completer();
  Position? _currentPosition;

  final double _initialSize = 0.5;
  final double _minSize = 0.0;
  final double _maxSize = 1;
  double _currentSize = 0.5;

  final DraggableScrollableController _dragController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _dragController.addListener(_handleSheetHeightChange);
  }

  @override
  void dispose() {
    _dragController.removeListener(_handleSheetHeightChange);
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

  // 지도 준비 완료
  void _onMapReady(NaverMapController controller) {
    if (_mapController.isCompleted) _mapController = Completer();

    _mapController.complete(controller);
  }

  // 지도 클릭
  void _onMapTapped(NPoint point, NLatLng latLng) {
    _dragController.animateTo(
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

  void _handleSheetHeightChange() {
    if (_currentSize > _dragController.size) {
      _dragController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }

    setState(() {
      _currentSize = _dragController.size;
    });
  }

  void _toggleListView() {
    setState(() {
      if (_currentSize == 0) {
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
    });
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
                : NaverMap(
                    options: NaverMapViewOptions(
                      initialCameraPosition: NCameraPosition(
                        target: NLatLng(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
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
            DraggableScrollableSheet(
              controller: _dragController,
              initialChildSize: _initialSize,
              minChildSize: _minSize,
              maxChildSize: _maxSize,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 7,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.amber,
                            ),
                          ),
                          Gaps.v10,
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleListView,
      ),
    );
  }
}
