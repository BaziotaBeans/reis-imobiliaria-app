import 'package:flutter/material.dart';

class SnackBarWidget {
  // Cores padrão para diferentes tipos de mensagens
  static const Color successColor = Colors.green;
  static const Color warningColor = Colors.orange;
  static const Color errorColor = Colors.red;
  static const Color confirmationColor = Colors.blue;

  // Método estático genérico para exibir um SnackBar
  static void showSnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    double elevation = 0,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: elevation,
        duration: const Duration(seconds: 7),
        content: Text(
          message,
          style: textStyle,
        ),
        backgroundColor: backgroundColor,
        behavior: behavior,
      ),
    );
  }

  // Método para mensagens de sucesso
  static void showSuccess({
    required BuildContext context,
    required String message,
  }) {
    showSnackBar(
      context: context,
      message: message,
      backgroundColor: successColor,
    );
  }

  // Método para mensagens de aviso
  static void showWarning({
    required BuildContext context,
    required String message,
  }) {
    showSnackBar(
      context: context,
      message: message,
      backgroundColor: warningColor,
    );
  }

  // Método para mensagens de erro
  static void showError({
    required BuildContext context,
    required String message,
  }) {
    showSnackBar(
      context: context,
      message: message,
      backgroundColor: errorColor,
    );
  }

  // Método para mensagens de confirmação
  static void showConfirmation({
    required BuildContext context,
    required String message,
  }) {
    showSnackBar(
      context: context,
      message: message,
      backgroundColor: confirmationColor,
    );
  }
}
