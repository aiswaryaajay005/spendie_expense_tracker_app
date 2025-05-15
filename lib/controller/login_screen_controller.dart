import 'package:flutter/widgets.dart';
import 'package:spendie_money_tracker/helper/db_helper.dart';

class LoginScreenController with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void login({required BuildContext context}) {
    DbHelper.fetchUser(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );
  }
}
