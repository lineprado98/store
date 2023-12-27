import 'package:flutter/material.dart';

abstract class CustomSnackBar {
  static void show(BuildContext context, {required String message, bool success = false}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            success ? 'Sucesso!' : 'Ocorreu um erro!',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: success ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.w700,
                ),
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
        ],
      ),
      duration: const Duration(seconds: 4),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
