import 'dart:async';

import 'package:angel_eats_test/constants/gaps.dart';
import 'package:angel_eats_test/features/home/views/widgets/draggable_sheet_card.dart';
import 'package:flutter/material.dart';

class DraggableSheetView extends StatefulWidget {
  const DraggableSheetView({
    super.key,
    required this.controller,
    required this.onExtentChanged,
  });

  final DraggableScrollableController controller;
  final Function(double) onExtentChanged;

  @override
  State<DraggableSheetView> createState() => _DraggableSheetViewState();
}

class _DraggableSheetViewState extends State<DraggableSheetView> {
  double _sheetPosition = 0.5;
  late DraggableScrollableController _controller;
  Timer? _scrollEndTimer;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  void _handleScrollEnd(double extent) {
    _scrollEndTimer?.cancel();
    _scrollEndTimer = Timer(const Duration(milliseconds: 100), () {
      if (extent >= 0.5) {
        _controller.animateTo(1.0,
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
        widget.onExtentChanged(1);
      } else if (extent < 0.5) {
        _controller.animateTo(0.0,
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
        widget.onExtentChanged(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const double minSize = 0.0;
    const double maxSize = 1;

    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        _sheetPosition = notification.extent;
        return true;
      },
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
          _handleScrollEnd(_sheetPosition);
          return true;
        },
        child: DraggableScrollableSheet(
          controller: _controller,
          initialChildSize: .5,
          minChildSize: minSize,
          maxChildSize: maxSize,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const Grabber(),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(5),
                      itemBuilder: (context, index) {
                        return const DraggableSheetCard();
                      },
                      separatorBuilder: (context, index) => Gaps.v10,
                      itemCount: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Grabber extends StatelessWidget {
  const Grabber({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      color: colorScheme.secondary,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          width: 32.0,
          height: 4.0,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
