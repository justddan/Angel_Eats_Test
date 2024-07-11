import 'package:angel_eats_test/constants/gaps.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  static String routeName = "detail";
  static String routeURL = "/detail";

  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _scrollPosition = _scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    bool isAppBarCollapsed = _scrollPosition >= 144;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics().applyTo(const NoScrollPhysics()),
        slivers: [
          SliverAppBar(
            centerTitle: false,
            title: Text(
              '상호명',
              style: TextStyle(
                color: isAppBarCollapsed ? Colors.black : Colors.transparent,
              ),
            ),
            backgroundColor:
                isAppBarCollapsed ? Colors.white : Colors.transparent,
            expandedHeight: 200.0,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // Change color based on scroll position
                double top = constraints.biggest.height;
                bool isCollapsed = top <= kToolbarHeight + 20;
                return FlexibleSpaceBar(
                  title: Text(
                    'Scrollable Page',
                    style: TextStyle(
                        color: isCollapsed ? Colors.black : Colors.transparent),
                  ),
                  background: Container(
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        '썸네일 이미지',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      const Text(
                        "상호명",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v10,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 24,
                          ),
                          Gaps.h5,
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 24,
                          ),
                          Gaps.h5,
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 24,
                          ),
                          Gaps.h5,
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 24,
                          ),
                          Gaps.h5,
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 24,
                          ),
                          Gaps.h5,
                          Text(
                            "5.0",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Gaps.v10,
                      IntrinsicHeight(
                        child: DefaultTextStyle(
                          style: TextStyle(
                            color: colorScheme.primary.withOpacity(.5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("최근리뷰 871"),
                              VerticalDivider(
                                color: colorScheme.primary.withOpacity(.2),
                              ),
                              const Text("최근사장님댓글 112"),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const Row(
                    children: [],
                  )
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "메뉴"),
                  Tab(text: "정보 • 원산지"),
                  Tab(text: "리뷰"),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  color: Colors.red,
                  child: const Center(child: Text('메뉴 페이지')),
                ),
                Container(
                  color: Colors.green,
                  child: const Center(child: Text('정보 원산지 페이지')),
                ),
                Container(
                  color: Colors.blue,
                  child: const Center(child: Text('리뷰 페이지')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class NoScrollPhysics extends ScrollPhysics {
  const NoScrollPhysics({super.parent});

  @override
  NoScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return NoScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels) {
      // Prevent scrolling up
      return value - position.pixels;
    }
    return 0.0;
  }
}
