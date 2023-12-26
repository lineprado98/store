import 'package:flutter/material.dart';

abstract class CustomSnackBar {
  static void show(BuildContext context, {required String message, bool success = false}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            success ? 'Sucesso!' : 'Ocorreu um erro!',
            textAlign: TextAlign.start,
            style: TextStyle(color: success ? Colors.green : Colors.red, fontWeight: FontWeight.w700),
          ),
          Text(
            message,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 16),
        ],
      ),
      duration: const Duration(seconds: 4),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
