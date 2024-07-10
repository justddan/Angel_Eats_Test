import 'package:angel_eats_test/features/bookmark/views/bookmark_screen.dart';
import 'package:angel_eats_test/features/history/views/history_screen.dart';
import 'package:angel_eats_test/features/home/views/home_screen.dart';
import 'package:angel_eats_test/features/user/views/mypage_screen.dart';
import 'package:flutter/material.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigation";

  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  DateTime ctime = DateTime.now();
  final List<String> _tabs = [
    "home",
    "bookmark",
    "history",
    "mypage",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  @override
  void initState() {
    super.initState();

    print('init .... $_selectedIndex');
    setState(() {});
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // 팝업 시도
    // switch (index) {
    //   case 1:
    //     context.pushNamed(BookmarkScreen.routeName);
    //     break;
    //   case 2:
    //     context.pushNamed(HistoryScreen.routeName);
    //     break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Offstage(
                    offstage: _selectedIndex != 0,
                    child: const HomeScreen(),
                  ),
                  Offstage(
                    offstage: _selectedIndex != 1,
                    child: const BookmarkScreen(),
                  ),
                  Offstage(
                    offstage: _selectedIndex != 2,
                    child: const HistoryScreen(),
                  ),
                  Offstage(
                    offstage: _selectedIndex != 3,
                    child: const MyPageScreen(),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.map_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded),
              label: 'Bookmark',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_rounded),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'MyPage',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: colorScheme.primary,
          unselectedItemColor: colorScheme.onSurfaceVariant,
          onTap: _onTap,
          backgroundColor: colorScheme.surface,
        ));
  }
}
