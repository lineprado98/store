import 'package:flutter/material.dart';

class AppDialogs {
  static void showAlertDelete(BuildContext context, {required String title, required String content, void Function()? onConfirm}) {
    _showAlertDelete(context, title, content, onConfirm);
  }
}

void _showAlertDelete(BuildContext context, String title, String content, void Function()? onConfirm) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                )),
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar')),
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.surface),
                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.error),
                    padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    )),
                onPressed: onConfirm,
                child: const Text('Confirmar')),
          ],
        );
      });
}
