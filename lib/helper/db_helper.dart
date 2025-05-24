import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spendie_money_tracker/view/home_screen/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbHelper {
  static List<Map<String, dynamic>> transactionDetails = [];
  static Future<void> initSupabase() async {
    await Supabase.initialize(
      url: 'https://dzhyuvsfxdjwndeeycni.supabase.co',
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR6aHl1dnNmeGRqd25kZWV5Y25pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ5NDYzMzgsImV4cCI6MjA2MDUyMjMzOH0.Qu6W9Dcmaqw2dFGF0gNVkZMaIf1alHpszUjz1b90FXo",
    );
  }

  static final SupabaseClient supabase = Supabase.instance.client;
  static Future<void> register({
    required password,
    required cpassword,
    required email,
    required name,
  }) async {
    try {
      final auth = await supabase.auth.signUp(password: password, email: email);
      final uid = auth.user!.id;
      log('Data added successfully');
      if (uid.isNotEmpty || uid != "") {
        addData(
          uid: uid,
          username: name,
          password: password,
          email: email,
          cpassword: cpassword,
        );
      }
    } catch (e) {
      log('Error: $e and enter same password in both fields');
    }
  }

  static Future<void> addData({
    required var uid,
    required String? username,
    required String? password,
    required String? email,
    required String? cpassword,
  }) async {
    if (password == cpassword) {
      try {
        await supabase.from('tbl_register').insert({
          'id': uid,
          'user_name': username,
          'user_email': email,

          'user_password': password,
        });
        log('Data added successfully');
      } catch (e) {
        log('Error: $e');
      }
    }
  }

  static Future<void> fetchUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
        context!,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      log('Error: $e');
    }
  }

  static Future<void> addTransaction({
    required String? tName,
    required String? tAmount,
    required String? tDate,
    required int? tType,
    required var uid,
  }) async {
    try {
      await supabase.from('tbl_transaction').insert({
        'user_id': uid,
        't_name': tName,
        't_amount': tAmount,
        't_date': tDate,
        't_type': tType,
      });
      log('Transaction added successfully');
    } catch (e) {
      log('Error: $e');
    }
  }

  static Future<PostgrestList?> fetchTransaction() async {
    try {
      final data = await supabase
          .from('tbl_transaction')
          .select()
          .eq('user_id', supabase.auth.currentUser!.id);
      if (data != null) {
        transactionDetails = List<Map<String, dynamic>>.from(data);
        log('Transaction fetched successfully');
      }
      return transactionDetails;
    } catch (e) {
      log('Error: $e');
    }
  }

  static void deleteTransaction({required int id}) async {
    try {
      await supabase.from('tbl_transaction').delete().eq('id', id);
      log('Transaction deleted successfully');
    } catch (e) {
      log('Error: $e');
    }
  }
}
