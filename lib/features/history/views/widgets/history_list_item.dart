import 'package:angel_eats_test/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({
    super.key,
    required this.deliveryDate,
    required this.deliveryState,
    required this.storeName,
    required this.storeMenu,
  });

  final String deliveryDate;
  final String deliveryState;
  final String storeName;
  final String storeMenu;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    onHistoryDetailTap() {
      // context.pushNamed(HistoryDetailScreen.routeName);
      context.push("/history/historyDetail");
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$deliveryDate • $deliveryState",
                style: TextStyle(
                  fontSize: 12,
                  height: 14.52 / 12,
                  color: Colors.black.withOpacity(.6),
                ),
              ),
              GestureDetector(
                onTap: onHistoryDetailTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: colorScheme.primary.withOpacity(.2),
                    ),
                  ),
                  child: const Text(
                    "주문상세",
                    style: TextStyle(
                      fontSize: 12,
                      height: 14.52 / 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gaps.v10,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Gaps.h10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          storeName,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 14.52 / 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gaps.h2,
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                        ),
                      ],
                    ),
                    Text(
                      storeMenu,
                    ),
                  ],
                ),
              )
            ],
          ),
          Gaps.v10,
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: colorScheme.primary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(
              "같은 메뉴 담기",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 14.52 / 12,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
