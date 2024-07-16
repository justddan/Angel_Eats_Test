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
  final double _sheetPosition = 0.5;

  @override
  void initState() {
    super.initState();
  }

  // 무한 반복( NotificationListener 활용 )
  // void _handleScrollNotification(ScrollNotification notification) {
  //   if (notification is ScrollEndNotification) {
  //     if (widget.controller.size < 1) {
  //       widget.controller.animateTo(
  //         0,
  //         duration: const Duration(milliseconds: 300),
  //         curve: Curves.easeIn,
  //       );
  //     } else if (widget.controller.size > 0) {
  //       widget.controller.animateTo(
  //         1,
  //         duration: const Duration(milliseconds: 300),
  //         curve: Curves.easeIn,
  //       );
  //     }

  //     setState(() {
  //       _sheetPosition = widget.controller.size;
  //     });
  //     print('Scroll ended. Current extent: ${widget.controller.size}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    const double minSize = 0.0;
    const double maxSize = 1;

    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        widget.onExtentChanged(notification.extent);
        return true;
      },
      child: DraggableScrollableSheet(
        controller: widget.controller,
        initialChildSize: _sheetPosition,
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
      color: colorScheme.onSurface,
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
