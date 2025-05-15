import 'package:flutter/widgets.dart';
import 'package:spendie_money_tracker/helper/db_helper.dart';

class RegisterScreenController with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  void register() {
    DbHelper.register(
      password: passwordController.text,
      cpassword: confirmPasswordController.text,
      email: emailController.text,
      name: nameController.text,
    );
    clearFields();
    notifyListeners();
  }
}
