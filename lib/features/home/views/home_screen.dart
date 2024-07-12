import 'dart:async';

import 'package:angel_eats_test/features/home/views/widgets/draggable_sheet_view.dart';
import 'package:angel_eats_test/features/home/views/widgets/naver_map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class MarkerModel {
  final String id;
  final double lat;
  final double lng;
  final String category;

  MarkerModel({
    required this.id,
    required this.lat,
    required this.lng,
    required this.category,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<NaverMapController> _mapController = Completer();
  Position? currentPosition;

  // Set<NAddableOverlay> overlays = {};

  final DraggableScrollableController _dragController =
      DraggableScrollableController();

  List<MarkerModel> mockMarkerData = [
    MarkerModel(
      id: "marker-1",
      category: "cafe",
      lat: 37.56,
      lng: 126.962847,
    ),
    MarkerModel(
      id: "marker-2",
      category: "cafe",
      lat: 37.56,
      lng: 126.96284784,
    ),
  ];

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
      currentPosition = position;
    });

    final NaverMapController controller = await _mapController.future;

    controller.updateCamera(NCameraUpdate.scrollAndZoomTo(
      target: NLatLng(position.latitude, position.longitude),
      zoom: 15,
    ));

    if (!mounted) return;

    final iconImage = await NOverlayImage.fromWidget(
      widget: const Icon(Icons.location_on),
      size: const Size(24, 24),
      context: context,
    );

    final currentMarker = NMarker(
      id: "0",
      position: NLatLng(
        position.latitude,
        position.longitude,
      ),
      icon: iconImage,
    );

    // currentMarker.setOnTapListener((NMarker marker) {
    //   print("마커가 터치되었습니다. id: ${marker.info.id}");
    // });

    controller.addOverlay(currentMarker);

    NLatLngBounds mapBounds = await controller.getContentBounds();

    createMarkers(mapBounds);
  }

  void _goToCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      currentPosition = position;
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

  // 지도 준비 완료
  void onMapReady(NaverMapController controller) {
    _mapController.complete(controller);
  }

  // 지도 클릭
  void onMapTapped(NPoint point, NLatLng latLng) {
    _dragController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  // 심볼 클릭
  void onSymbolTapped(NSymbolInfo symbolInfo) {}

  // 카메라 이동 중
  void onCameraChange(NCameraUpdateReason reason, bool animated) {}

  // 카메라 이동 끝
  void onCameraIdle() async {
    final NaverMapController controller = await _mapController.future;

    // 지도 범위
    // southWest : 남서 위경도
    // northEast : 북동 위경도
    NLatLngBounds mapBounds = await controller.getContentBounds();
    // print(mapBounds);

    createMarkers(mapBounds);
  }

  void createMarkers(NLatLngBounds mapBounds) async {
    final NaverMapController controller = await _mapController.future;

    // 생성할 마커 좌표 및 정보 API 호출

    // 범위 안의 마커들을 생성
    List<Future<NMarker>> modifiedList = mockMarkerData.map((mapInfo) async {
      final marker = NMarker(
        id: mapInfo.id,
        position: NLatLng(
          mapInfo.lat,
          mapInfo.lng,
        ),
        icon: await _getOverlayImage(mapInfo.category),
      );

      // 마커 클릭 이벤트 설정
      marker.setOnTapListener((NMarker marker) {
        print("마커가 클릭되었다!");
      });

      return marker;
    }).toList();

    List<NMarker> results = await Future.wait(modifiedList);

    Set<NMarker> overlays = results.toSet();

    controller.addOverlayAll(overlays);
  }

  Future<NOverlayImage> _getOverlayImage(String category) async {
    // 카테고리 종류 API 호출 후 categories에 넣기
    final List<String> categories = [
      "cafe",
      "fastfood",
      "dining",
      "drink",
    ];

    int categoryNum = categories.indexOf(category);

    // 해당하는 asset 사진 넣기
    final List<Widget> icons = [
      const Icon(
        Icons.emoji_food_beverage_rounded,
        color: Colors.red,
      ),
      const Icon(
        Icons.fastfood,
        color: Colors.red,
      ),
      const Icon(
        Icons.local_dining,
        color: Colors.red,
      ),
      const Icon(
        Icons.local_drink,
        color: Colors.red,
      ),
    ];

    final iconImage = await NOverlayImage.fromWidget(
      widget: icons[categoryNum],
      size: const Size(24, 24),
      context: context,
    );

    return iconImage;
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
            currentPosition == null
                ? const Center(child: CircularProgressIndicator())
                : NaverMapView(
                    currentPosition: currentPosition,
                    onMapReady: onMapReady,
                    onMapTapped: onMapTapped,
                    onSymbolTapped: onSymbolTapped,
                    onCameraChange: onCameraChange,
                    onCameraIdle: onCameraIdle,
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
