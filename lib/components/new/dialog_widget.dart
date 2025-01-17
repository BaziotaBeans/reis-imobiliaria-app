import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class DialogWidget {
  // Método estático para exibir um diálogo de erro
  static Future<void> showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: whiteColor,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: errorColor,
          ),
        ),
        content: CustomText(message, color: secondaryColor),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }

  static Future<void> showSuccessDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: whiteColor,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: successColor,
          ),
        ),
        content: CustomText(message, color: secondaryColor),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }
}
