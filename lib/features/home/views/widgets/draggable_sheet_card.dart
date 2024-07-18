import 'package:angel_eats_test/constants/gaps.dart';
import 'package:flutter/material.dart';

class DraggableSheetCard extends StatelessWidget {
  const DraggableSheetCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      color: colorScheme.primary,
                      child: const Center(
                        child: Text(
                          "A",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.h1,
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            color: colorScheme.primary,
                            child: const Center(
                              child: Text(
                                "B",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gaps.v1,
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            color: colorScheme.primary,
                            child: const Center(
                              child: Text(
                                "C",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        "상호명",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.h2,
                      Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 16,
                      ),
                      Text(
                        "5.0",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Gaps.v2,
                  Row(
                    children: [
                      Text("픽업"),
                      Gaps.h2,
                      Text("7~17분"),
                      Text("•"),
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                      ),
                      Gaps.h2,
                      Text("9m"),
                      Text("•"),
                      Text("도보"),
                      Gaps.h2,
                      Text("1분"),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
