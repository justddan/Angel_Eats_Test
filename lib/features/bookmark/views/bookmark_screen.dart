import 'package:angel_eats_test/features/bookmark/views/widgets/bookmark_list_item.dart';
import 'package:angel_eats_test/features/detail/views/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookmarkScreen extends StatelessWidget {
  static String routeName = "bookmark";
  static String routeURL = "/bookmark";

  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    goDetailScreen() {
      context.pushNamed(DetailScreen.routeName);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: const Text(
          "찜하기",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  "총 999개",
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: goDetailScreen,
                    child: BookmarkListItem(
                      storeName: "상호명 $index",
                      reviewPoint: "5.0",
                      reviewCount: "3",
                      recommendMenu: "추천메뉴추천메뉴추천메뉴추천메뉴추천메뉴추천메뉴추천메뉴추천메뉴추천메뉴",
                      deliveryTime: "36분~51분",
                      deliveryTip: "0~3,800원",
                      minimumPrice: "5,000원",
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: colorScheme.primary.withOpacity(.2),
                    thickness: 0.5,
                  );
                },
                itemCount: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
