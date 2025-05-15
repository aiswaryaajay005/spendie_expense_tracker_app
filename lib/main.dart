import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendie_money_tracker/app_utils/app_utils.dart';
import 'package:spendie_money_tracker/controller/login_screen_controller.dart';
import 'package:spendie_money_tracker/controller/register_screen_controller.dart';
import 'package:spendie_money_tracker/helper/db_helper.dart';
import 'package:spendie_money_tracker/view/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initSupabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterScreenController()),
        ChangeNotifierProvider(create: (context) => LoginScreenController()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SplashScreen());
  }
}
