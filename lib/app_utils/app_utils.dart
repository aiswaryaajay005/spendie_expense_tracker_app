import 'package:flutter/material.dart';

class AppUtils {
  static final String supabaseKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR6aHl1dnNmeGRqd25kZWV5Y25pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ5NDYzMzgsImV4cCI6MjA2MDUyMjMzOH0.Qu6W9Dcmaqw2dFGF0gNVkZMaIf1alHpszUjz1b90FXo";
  static final String supabaseUrl = "https://dzhyuvsfxdjwndeeycni.supabase.co";

  static void showSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}
