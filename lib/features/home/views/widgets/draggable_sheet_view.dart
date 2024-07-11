import 'package:angel_eats_test/constants/gaps.dart';
import 'package:flutter/material.dart';

class DraggableSheetView extends StatefulWidget {
  const DraggableSheetView({
    super.key,
    required this.controller,
  });

  final DraggableScrollableController controller;

  @override
  State<DraggableSheetView> createState() => _DraggableSheetViewState();
}

class _DraggableSheetViewState extends State<DraggableSheetView> {
  @override
  Widget build(BuildContext context) {
    const double initialSize = 0.5;
    const double minSize = 0.0;
    const double maxSize = 1;

    return DraggableScrollableSheet(
      controller: widget.controller,
      initialChildSize: initialSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
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
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
    );
  }
}
