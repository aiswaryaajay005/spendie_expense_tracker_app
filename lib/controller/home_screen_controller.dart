import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:spendie_money_tracker/helper/db_helper.dart';

class HomeScreenController with ChangeNotifier {
  List<Map<String, dynamic>> transactionDetails = [];
  int totalIncome = 0;
  int totalExpense = 0;
  int totalBalance = 0;
  Future<void> fetchTransaction() async {
    try {
      transactionDetails = (await DbHelper.fetchTransaction()) ?? [];
      notifyListeners();
      calculateTotalExpense();

      calculateTotalIncome();
      calculateTotalBalance();
      if (transactionDetails.isNotEmpty) {
        log('Transaction details fetched successfully');
        log(transactionDetails.toString());
      } else {
        log('No transaction details found');
      }
      notifyListeners();
    } catch (e) {
      log('Error fetching transaction details: $e');
    }
  }

  void calculateTotalIncome() {
    totalIncome = transactionDetails
        .where((element) => element['t_type'] == 1)
        .fold(0, (sum, element) {
          String amount = element['t_amount'].toString();
          int parsedAmount = int.tryParse(amount) ?? 0;
          log('Parsed amount: $parsedAmount');
          if (parsedAmount == 0 && amount.isNotEmpty) {
            log('Error parsing amount: $amount');
          }
          totalIncome = sum + parsedAmount;
          log(totalIncome.toString());
          return sum + parsedAmount;
        });
    notifyListeners();
  }

  void calculateTotalExpense() {
    totalExpense = transactionDetails
        .where((element) => element['t_type'] == 0)
        .fold(0, (sum, element) {
          String amount = element['t_amount'].toString();
          int parsedAmount = int.tryParse(amount) ?? 0;
          log('Parsed amount: $parsedAmount');
          if (parsedAmount == 0 && amount.isNotEmpty) {
            log('Error parsing amount: $amount');
          }
          totalExpense = sum + parsedAmount;
          log(totalExpense.toString());
          return sum + parsedAmount;
        });
    notifyListeners();
  }

  calculateTotalBalance() {
    totalBalance = totalIncome - totalExpense;
    log('Total balance: $totalBalance');
    notifyListeners();
  }

  void deleteTransaction({required int id}) async {
    try {
      DbHelper.deleteTransaction(id: id);
      log('Transaction deleted successfully');
    } catch (e) {
      log('Error deleting transaction: $e');
    }
    notifyListeners();
  }

  DateTime selectedMonth = DateTime.now();

  void setSelectedMonth(DateTime date) {
    selectedMonth = date;
    notifyListeners();
  }

  List<Map<String, dynamic>> get filteredTransactionsByMonth {
    return transactionDetails.where((tx) {
      final txDate = DateTime.parse(tx['t_date']);
      return txDate.month == selectedMonth.month &&
          txDate.year == selectedMonth.year;
    }).toList();
  }
}
