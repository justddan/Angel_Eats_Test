import 'package:angel_eats_test/constants/gaps.dart';
import 'package:angel_eats_test/features/edit/views/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    goEditSceen() {
      context.pushNamed(EditScreen.routeName);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "마이페이지",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings_rounded,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  Gaps.h10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: goEditSceen,
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "고마운분,",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Gaps.h2,
                              Text(
                                "닉네임",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gaps.h2,
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        Gaps.v10,
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.people_alt_rounded,
                                size: 16,
                              ),
                              Gaps.h2,
                              const Text("가족계정"),
                              SizedBox(
                                height: 12,
                                child: VerticalDivider(
                                  color: colorScheme.primary.withOpacity(.2),
                                ),
                              ),
                              const Icon(
                                Icons.location_on_outlined,
                                size: 16,
                              ),
                              Gaps.h2,
                              const Text("주소관리"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Gaps.v10,
              IntrinsicHeight(
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 32,
                          ),
                          Gaps.v5,
                          Text(
                            "주문내역",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                      child: VerticalDivider(
                        color: colorScheme.primary.withOpacity(.2),
                      ),
                    ),
                    const Expanded(
                      child: Column(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 32,
                          ),
                          Gaps.v5,
                          Text(
                            "나의 찜",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                      child: VerticalDivider(
                        color: colorScheme.primary.withOpacity(
                          .2,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Column(
                        children: [
                          Icon(
                            Icons.message,
                            size: 32,
                          ),
                          Gaps.v5,
                          Text(
                            "리뷰관리",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
