import 'package:angel_eats_test/features/history/views/widgets/history_list_item.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  static String routeName = "history";
  static String routeURL = "/history";

  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  "필터",
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const HistoryListItem(
                    deliveryDate: "6. 30 (일)",
                    deliveryState: "배달완료",
                    storeName: "마포찜닭",
                    storeMenu: "찜닭+날치알주볶밥+음료 세트 1개 28,600원",
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: colorScheme.primary.withOpacity(.2),
                    thickness: 10,
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
