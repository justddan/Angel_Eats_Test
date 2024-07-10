import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  static String routeName = "history";
  static String routeURL = "/history";

  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("HistoryScreen"),
      ),
    );
  }
}
