import 'package:flutter/material.dart';
import 'package:spendie_money_tracker/utils/global_constants.dart';
import 'package:spendie_money_tracker/view/home_screen/home_screen.dart';
import 'package:spendie_money_tracker/view/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((_) {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalConstants.primary,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/piggy.png', height: 100, width: 100),
            Text(
              "Spendie",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            Text(
              "Track Smart. Spend Wise",
              style: TextStyle(color: GlobalConstants.accent),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(color: GlobalConstants.accent),
          ],
        ),
      ),
    );
  }
}
