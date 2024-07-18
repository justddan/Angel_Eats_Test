import 'package:angel_eats_test/constants/gaps.dart';
import 'package:flutter/material.dart';

class CartMenuListItem extends StatelessWidget {
  const CartMenuListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "감자튀김",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v2,
                  Text(
                    "가격 : 8,000원",
                    style: TextStyle(
                      color: colorScheme.secondary,
                      fontSize: 12,
                    ),
                  ),
                  Gaps.v2,
                  Text(
                    "소스 선택 : 핫바베큐 / 치즈갈릭딥핑",
                    style: TextStyle(
                      color: colorScheme.secondary,
                      fontSize: 12,
                    ),
                  ),
                  Gaps.v2,
                  const Text("8,000원")
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              )
            ],
          ),
          Gaps.v10,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorScheme.secondary.withOpacity(.2),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(5),
                child: const Text(
                  "옵션 변경",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              Gaps.h10,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorScheme.secondary.withOpacity(.2),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(5),
                child: const Row(
                  children: [
                    Icon(
                      Icons.delete_outlined,
                      size: 16,
                    ),
                    Gaps.h10,
                    Text(
                      "1",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Gaps.h10,
                    Icon(
                      Icons.add_rounded,
                      size: 16,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
