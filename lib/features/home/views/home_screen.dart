import 'dart:async';

import 'package:angel_eats_test/constants/gaps.dart';
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
  final ValueNotifier<NMarker?> _selectedMarker = ValueNotifier<NMarker?>(null);
  Position? currentPosition;
  // NMarker? _selectedMarker;

  // Set<NAddableOverlay> overlays = {};

  final DraggableScrollableController _dragController =
      DraggableScrollableController();

  final ValueNotifier<double> sheetPostion = ValueNotifier<double>(0.5);

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
      lat: 37.552,
      lng: 126.962846,
    ),
    MarkerModel(
      id: "marker-3",
      category: "cafe",
      lat: 37.554,
      lng: 126.962846,
    ),
    MarkerModel(
      id: "marker-4",
      category: "cafe",
      lat: 37.556,
      lng: 126.962846,
    ),
    MarkerModel(
      id: "marker-5",
      category: "cafe",
      lat: 37.558,
      lng: 126.962846,
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
    sheetPostion.dispose();
    _selectedMarker.dispose();
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

  // 지도 준비 완료
  void onMapReady(NaverMapController controller) {
    _mapController.complete(controller);
  }

  // 지도 클릭
  void onMapTapped(NPoint point, NLatLng latLng) {
    _dragController.animateTo(
      0,
      duration: const Duration(milliseconds: 100),
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

    Set<NMarker> overlays = {};

    // 생성할 마커 좌표 및 정보 API 호출

    // 범위 안의 마커들을 생성
    List<Future<NMarker>> modifiedList = mockMarkerData.map((mapInfo) async {
      final marker = NMarker(
        id: mapInfo.id,
        position: NLatLng(
          mapInfo.lat,
          mapInfo.lng,
        ),
        icon: await _getOverlayImage(mapInfo),
      );

      // 마커 클릭 이벤트 설정
      marker.setOnTapListener((NMarker marker) async {
        _selectedMarker.value = marker;

        controller.updateCamera(NCameraUpdate.scrollAndZoomTo(
          target: NLatLng(
            marker.position.latitude,
            marker.position.longitude,
          ),
          zoom: 15,
        ));

        _dragController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });

      return marker;
    }).toList();

    List<NMarker> results = await Future.wait(modifiedList);

    overlays = results.toSet();

    controller.addOverlayAll(overlays);
  }

  void onTestTap() async {
    final NaverMapController controller = await _mapController.future;

    print(_selectedMarker);
  }

  void updateMarker(Set<NMarker> markers, NMarker updatedMarker) async {
    final NaverMapController controller = await _mapController.future;

    controller.clearOverlays();

    Set<NMarker> modifiedOverlays = markers.map((marker) {
      if (marker.info.id == updatedMarker.info.id) {
        return updatedMarker;
      }
      return marker;
    }).toSet();

    controller.addOverlayAll(modifiedOverlays);
  }

  Future<NOverlayImage> _getOverlayImage(MarkerModel marker) async {
    // 카테고리 종류 API 호출 후 categories에 넣기
    final List<String> categories = [
      "cafe",
      "fastfood",
      "dining",
      "drink",
    ];

    int categoryNum = categories.indexOf(marker.category);

    // 해당하는 asset 사진 넣기
    final List<Widget> icons = [
      const Icon(
        Icons.emoji_food_beverage_rounded,
        color: Colors.red,
        size: 30,
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

    final List<Widget> selectedIcons = [
      const Icon(
        Icons.emoji_food_beverage_rounded,
        color: Colors.blue,
        size: 30,
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
      widget: marker.id == _selectedMarker.value?.info.id
          ? selectedIcons[categoryNum]
          : icons[categoryNum],
      size: const Size(24, 24),
      context: context,
    );

    return iconImage;
  }

  void _toggleListView() {
    if (sheetPostion.value == 0) {
      _dragController.animateTo(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      sheetPostion.value = 1;
    } else {
      _dragController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      sheetPostion.value = 0;
    }
  }

  void updateButtonText(double extent) {
    sheetPostion.value = extent;
    // _dragController.animateTo(
    //   extent,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeIn,
    // );
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
              onExtentChanged: updateButtonText,
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: GestureDetector(
                onTap: _toggleListView,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ValueListenableBuilder(
                      valueListenable: sheetPostion,
                      builder: (context, extent, child) {
                        return Row(
                          children: [
                            Icon(
                              extent == 1
                                  ? Icons.map_outlined
                                  : Icons.menu_rounded,
                              color: Colors.white,
                            ),
                            Gaps.h2,
                            Text(
                              extent == 1 ? "지도보기" : "목록보기",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _toggleListView,
      //   // onPressed: onTestTap,
      // ),
    );
  }
}
