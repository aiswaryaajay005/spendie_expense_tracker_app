import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendie_money_tracker/app_utils/app_utils.dart';
import 'package:spendie_money_tracker/helper/db_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddTransactionController with ChangeNotifier {
  TextEditingController incomenamecontroller = TextEditingController();
  TextEditingController incomeamountcontroller = TextEditingController();
  TextEditingController incomecategorycontroller = TextEditingController();
  TextEditingController incomedatecontroller = TextEditingController();
  TextEditingController expensenamecontroller = TextEditingController();
  TextEditingController expenseamountcontroller = TextEditingController();
  TextEditingController expensecategorycontroller = TextEditingController();
  TextEditingController expensedatecontroller = TextEditingController();
  final User? user = DbHelper.supabase.auth.currentUser;

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      incomedatecontroller.text = formattedDate;
      expensedatecontroller.text = formattedDate;
    }
  }

  Future<void> addIncome({required BuildContext context}) async {
    await DbHelper.addTransaction(
      uid: user!.id,
      tName: incomenamecontroller.text,
      tAmount: incomeamountcontroller.text,
      tType: 1,
      tDate: incomedatecontroller.text,
    );
    clearFields();
    AppUtils.showSnackBar(
      message: "Income Added Successfully",
      context: context,
    );
    log('Income added successfully');
  }

  Future<void> addExpense({required BuildContext context}) async {
    await DbHelper.addTransaction(
      uid: user!.id,
      tName: expensenamecontroller.text,
      tAmount: expenseamountcontroller.text,
      tType: 0,
      tDate: expensedatecontroller.text,
    );
    clearFields();
    AppUtils.showSnackBar(
      message: "Expense Added Successfully",
      context: context,
    );
    log('Expense added successfully');
  }

  void clearFields() {
    incomenamecontroller.clear();
    incomeamountcontroller.clear();
    incomecategorycontroller.clear();
    incomedatecontroller.clear();
    expensenamecontroller.clear();
    expenseamountcontroller.clear();
    expensecategorycontroller.clear();
    expensedatecontroller.clear();
  }
}
