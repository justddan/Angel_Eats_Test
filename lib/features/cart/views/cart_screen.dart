import 'package:angel_eats_test/constants/gaps.dart';
import 'package:angel_eats_test/features/cart/views/widgets/card_menu_list_item.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "cart";
  static String routeURL = "/cart";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: const Text(
          "장바구니",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.075,
                        height: MediaQuery.of(context).size.width * 0.075,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Gaps.h2,
                      const Text(
                        "상호명",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 20,
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        size: 16,
                      ),
                      Gaps.h2,
                      Text(
                        "7~17분 후 픽업",
                      ),
                    ],
                  )
                ],
              ),
              Gaps.v10,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorScheme.secondary.withOpacity(.2),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListView.separated(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const CartMenuListItem();
                      },
                      separatorBuilder: (context, index) => Divider(
                        color: colorScheme.secondary.withOpacity(.2),
                        height: 1,
                      ),
                      itemCount: 2,
                    ),
                    Divider(
                      color: colorScheme.secondary.withOpacity(.2),
                      height: 1,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_rounded,
                            size: 20,
                          ),
                          Gaps.h2,
                          Text(
                            "메뉴 추가",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
