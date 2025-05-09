import 'package:flutter/material.dart';
import 'package:spendie_money_tracker/view/home_screen/home_screen.dart';
import 'package:spendie_money_tracker/view/splash_screen/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}
