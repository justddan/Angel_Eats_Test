import 'package:angel_eats_test/constants/gaps.dart';
import 'package:flutter/material.dart';

class HistoryDetailScreen extends StatelessWidget {
  static String routeName = "historyDetail";
  static String routeURL = "historyDetail";

  const HistoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "주문 내역",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        surfaceTintColor: Colors.white,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: colorScheme.primary.withOpacity(.2),
              thickness: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "배달이 완료되었어요",
                    style: TextStyle(
                      fontSize: 14,
                      height: 14.52 / 12,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.secondary,
                    ),
                  ),
                  Gaps.v5,
                  const Text(
                    "마포찜닭",
                    style: TextStyle(
                      fontSize: 16,
                      height: 14.52 / 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v2,
                  const Text(
                    "찜닭+날치알주볶밥+음료 세트 1개",
                    style: TextStyle(
                      fontSize: 16,
                      height: 14.52 / 12,
                    ),
                  ),
                  Gaps.v10,
                  Text(
                    "주문일시 : 2024년 06월 30일 오후 06:12",
                    style: TextStyle(
                      fontSize: 14,
                      height: 14.52 / 12,
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                  Text(
                    "주문번호 : R1RW0000RN5B",
                    style: TextStyle(
                      fontSize: 14,
                      height: 14.52 / 12,
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                  Text(
                    "배달방식 : 알뜰배달",
                    style: TextStyle(
                      fontSize: 14,
                      height: 14.52 / 12,
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                  Gaps.v10,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.headset),
                        Gaps.h2,
                        Text(
                          "도움이 필요하신가요?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            height: 14.52 / 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: colorScheme.primary.withOpacity(.2),
              thickness: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "찜닭+날치알주볶밥+음료 세트 1개",
                    style: TextStyle(
                      fontSize: 15,
                      height: 14.52 / 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v2,
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 14,
                      height: 14.52 / 12,
                      color: Colors.black.withOpacity(.5),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("•기본 : (소)+날치알주볶밥+콜라245ml (25,500원)"),
                        Text("•뼈 / 순살 선택 : 순살 (2,000원)"),
                        Text("•맛 선택 : 보통맛(까망)"),
                        Text("•사리 추가선택 : 당면사리 추가 (2,000원)"),
                        Text("•공기밥 추가선택(중복가능) : 공기밥 1개 (1,000원)"),
                        Text("•리뷰 참여(별5개~) : (r뷰) 떡사리 서비스 (100원)"),
                      ],
                    ),
                  ),
                  Gaps.h2,
                  const Text("30,600원"),
                ],
              ),
            ),
            Divider(
              color: colorScheme.primary.withOpacity(.2),
              thickness: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.width * 0.18,
        child: Container(
          height: 80,
          color: colorScheme.primary,
          child: const Center(
            child: Text(
              "같은 메뉴 담기",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
