import 'package:angel_eats_test/common/widgets/main_navigation/main_navigation_screen.dart';
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
        //       ),
        // ),
        GoRoute(
          path: "/:tab(home|bookmark|history|mypage)",
          name: MainNavigationScreen.routeName,
          builder: (context, state) {
            final tab = state.pathParameters["tab"]!;
            return MainNavigationScreen(tab: tab);
          },
          routes: const [
            // GoRoute(
            //   name: SearchScreen.routeName,
            //   path: SearchScreen.routeURL,
            //   builder: (context, state) => const SearchScreen(),
            // ),
          ],
        ),
      ],
    )
  ],
);
