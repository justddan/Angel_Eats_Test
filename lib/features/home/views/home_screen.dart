import 'dart:async';

import 'package:angel_eats_test/constants/gaps.dart';
import 'package:angel_eats_test/features/home/views/search_screen.dart';
import 'package:flutter/material.dart';
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
  final FocusNode _focusNode = FocusNode();

  final double _initialSize = 0.3;
  final double _minSize = 0.05;
  final double _maxSize = 1;
  double _currentSize = 0.3;

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

  Future<void> _getCurrentLocation() async {
    Position position = await _determinePosition();
    // setState(() {
    //   _initialPosition = LatLng(position.latitude, position.longitude);
    //   _currentPosition = LatLng(position.latitude, position.longitude);
    // });
  }

  void _goToCurrentLocation() {
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

    if (_currentSize <= 0.3) {
      buttonBottom = screenHeight * _currentSize;
    } else {
      buttonBottom = screenHeight * 0.3;
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // _initialPosition == null
            //     ? const Center(child: CircularProgressIndicator())
            //     : GoogleMap(
            //         onMapCreated: (controller) {
            //           _mapController = controller;
            //         },
            //         initialCameraPosition: CameraPosition(
            //           target: _initialPosition!,
            //           zoom: 17,
            //         ),
            //         myLocationEnabled: true,
            //         myLocationButtonEnabled: false,
            //         zoomControlsEnabled: false,
            //       ),
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: TextField(
                focusNode: _focusNode,
                decoration: InputDecoration(
                  // labelText: '주소 찾기',
                  // labelStyle: const TextStyle(color: Colors.black),
                  suffixIcon: const Icon(Icons.search, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black12, width: 1.0),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black54, width: 2.0),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Positioned(
              bottom: buttonBottom < 50 ? 50 : buttonBottom,
              left: 20,
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
    );
  }
}
