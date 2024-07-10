import 'dart:async';

import 'package:angel_eats_test/constants/gaps.dart';
import 'package:angel_eats_test/features/home/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "search";
  static String routeURL = "search";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // GoogleMapController? _mapController;
  // LatLng? _initialPosition;
  // LatLng? _currentPosition;

  Completer<NaverMapController> _mapController = Completer();

  final FocusNode _focusNode = FocusNode();

  final double _initialSize = 0.5;
  final double _minSize = 0.0;
  final double _maxSize = 1;
  double _currentSize = 0.5;

  final DraggableScrollableController _dragController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    // _getLocationPermission();
    _getCurrentLocation();
    _dragController.addListener(_handleSheetHeightChange);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        context.pushNamed(SearchScreen.routeName);
      }
    });
  }

  @override
  void dispose() {
    // _mapController?.dispose();
    _dragController.removeListener(_handleSheetHeightChange);
    _dragController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onMapReady(NaverMapController controller) {
    if (_mapController.isCompleted) _mapController = Completer();

    _mapController.complete(controller);
  }

  Future<void> _getCurrentLocation() async {
    Position position = await _determinePosition();
    // setState(() {
    //   _initialPosition = LatLng(position.latitude, position.longitude);
    //   _currentPosition = LatLng(position.latitude, position.longitude);
    // });
  }

  void _goToCurrentLocation() async {
    final controller = await _mapController.future;
    // if (_currentPosition != null) {
    //   _mapController?.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: _currentPosition!, zoom: 17),
    //     ),
    //   );
    // } else {
    //   _getCurrentLocation().then((_) {
    //     if (_currentPosition != null) {
    //       _mapController?.animateCamera(
    //         CameraUpdate.newCameraPosition(
    //           CameraPosition(target: _currentPosition!, zoom: 17),
    //         ),
    //       );
    //     }
    //   });
    // }
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
    setState(() {
      _currentSize = _dragController.size;
    });
  }

  void _toggleListView() {
    setState(() {
      if (_currentSize == 0) {
        _dragController.animateTo(1,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      } else {
        _dragController.animateTo(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO
    // 1. 현재 위치 찾기 [V]
    // 2. 현재 위치로 이동 [V]
    // 3. 커스텀 마커 []
    // 4. 검색창 [V]
    // 5. 검색창 밑에 칩 스크롤 뷰 []
    // 6. 위로 올라오는 모달창 [V]
    //   6-1. 마커가 클릭이 안되어 있을 시, 가게 리스트 페이지 []
    //   6-2. 마커가 클릭이 되어 있을 시, 가게 정보 페이지 []
    // 7. 일정 스크롤 되었을떄 현재 위치로 이동하는 버튼 사라지기 [V]

    double screenHeight = MediaQuery.of(context).size.height;
    double buttonBottom;

    if (_currentSize <= 0.5) {
      buttonBottom = screenHeight * _currentSize;
    } else {
      buttonBottom = screenHeight * 0.5;
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            NaverMap(
              options: const NaverMapViewOptions(
                indoorEnable: false,
                logoAlign: NLogoAlign.leftTop,
                extent: NLatLngBounds(
                  southWest: NLatLng(31.43, 122.37),
                  northEast: NLatLng(44.35, 132.0),
                ),
              ),
              // 지도 준비 완료
              onMapReady: _onMapReady,
              // 지도 클릭
              onMapTapped: (point, latLng) {
                _dragController.animateTo(0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
              // 심볼 클릭
              onSymbolTapped: (symbolInfo) {},
              // 카메라 이동 중
              onCameraChange: (reason, animated) {},
              // 카메라 이동 끝
              onCameraIdle: () {},
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
