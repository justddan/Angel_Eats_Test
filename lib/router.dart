import 'package:angel_eats_test/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:angel_eats_test/features/cart/views/cart_screen.dart';
import 'package:angel_eats_test/features/detail/views/detail_screen.dart';
import 'package:angel_eats_test/features/edit/views/edit_screen.dart';
import 'package:angel_eats_test/features/history/views/history_detail_screen.dart';
import 'package:angel_eats_test/features/payment/views/payment_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: "/home",
  redirect: (context, state) {
    return null;

    // final isLoggedIn = ref.read(authRepo).isLoggedIn;
    // if (!isLoggedIn) {
    //   if (state.matchedLocation != SignUpScreen.routeURL &&
    //       state.matchedLocation != LoginScreen.routeURL &&
    //       state.matchedLocation != RightScreen.routeURL &&
    //       state.matchedLocation != TermsScreen.routeURL) {
    //     return LoginScreen.routeURL;
    //   }
    // }
    // return null;
  },
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        // ref.read(notificationsProvider(context));
        return child;
      },
      routes: [
        // GoRoute(
        //   name: HomeScreen.routeName,
        //   path: HomeScreen.routeURL,
        //   builder: (context, state) => const HomeScreen(
        //       // userInfo: state.extra as UserProfileModel,
        //   ),
        // ),
        GoRoute(
          path: "/:tab(home|bookmark|history|mypage)",
          name: MainNavigationScreen.routeName,
          builder: (context, state) {
            final tab = state.pathParameters["tab"]!;
            return MainNavigationScreen(tab: tab);
          },
          routes: [
            GoRoute(
              name: HistoryDetailScreen.routeName,
              path: HistoryDetailScreen.routeURL,
              builder: (context, state) => const HistoryDetailScreen(),
            ),
          ],
        ),
        GoRoute(
          name: DetailScreen.routeName,
          path: DetailScreen.routeURL,
          builder: (context, state) => const DetailScreen(),
        ),
        GoRoute(
          name: EditScreen.routeName,
          path: EditScreen.routeURL,
          builder: (context, state) => const EditScreen(),
        ),
        GoRoute(
          name: PaymentScreen.routeName,
          path: PaymentScreen.routeURL,
          builder: (context, state) => const PaymentScreen(),
        ),
        GoRoute(
          name: CartScreen.routeName,
          path: CartScreen.routeURL,
          builder: (context, state) => const CartScreen(),
        ),
        // 팝업 시도
        // GoRoute(
        //   name: BookmarkScreen.routeName,
        //   path: BookmarkScreen.routeURL,
        //   builder: (context, state) => const BookmarkScreen(
        //       // userInfo: state.extra as UserProfileModel,
        //       ),
        // ),
      ],
    )
  ],
);
