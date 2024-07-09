import 'package:angel_eats_test/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AngelEatsTestApp());
}

class AngelEatsTestApp extends StatelessWidget {
  const AngelEatsTestApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'AngelEatsTest',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      ),
    );
  }
}
