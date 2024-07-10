import 'package:angel_eats_test/constants/gaps.dart';
import 'package:flutter/material.dart';

class BookmarkListItem extends StatelessWidget {
  const BookmarkListItem({
    super.key,
    required this.storeName,
    required this.reviewPoint,
    required this.reviewCount,
    required this.recommendMenu,
    required this.deliveryTime,
    required this.deliveryTip,
    required this.minimumPrice,
  });

  final String storeName;
  final String reviewPoint;
  final String reviewCount;
  final String recommendMenu;
  final String deliveryTime;
  final String deliveryTip;
  final String minimumPrice;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.onSurface,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Gaps.h10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Gaps.v2,
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: Colors.amber,
                    ),
                    Flexible(
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 12,
                            height: 14.52 / 12,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: reviewPoint,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "($reviewCount)",
                            ),
                            const WidgetSpan(child: Gaps.h2),
                            TextSpan(
                              text: recommendMenu,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.v2,
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: colorScheme.primary.withOpacity(.7),
                    ),
                    Gaps.h2,
                    Flexible(
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 12,
                            height: 14.52 / 12,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: deliveryTime,
                            ),
                            const WidgetSpan(child: Gaps.h2),
                            const TextSpan(
                              text: "•",
                            ),
                            const WidgetSpan(child: Gaps.h2),
                            const TextSpan(
                              text: "배달팁",
                            ),
                            const WidgetSpan(child: Gaps.h2),
                            TextSpan(
                              text: deliveryTip,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.v2,
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12,
                      height: 14.52 / 12,
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(
                        text: "최소주문",
                      ),
                      const WidgetSpan(child: Gaps.h2),
                      TextSpan(
                        text: minimumPrice,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
