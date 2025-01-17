import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reis_imovel_app/utils/constants.dart';

enum ButtonVariant {
  primary,
  secondary,
  tertiary,
  success,
  alert,
  danger,
  outlineAlert,
  outlineDanger,
  outline
}

class Button extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final double? fontSize;
  final bool? withAddIcon;
  final Widget? childrenWidget;
  final double? minimumSize;

  const Button({
    required this.title,
    required this.onPressed,
    required this.variant,
    super.key,
    this.fontSize,
    this.withAddIcon,
    this.childrenWidget,
    this.minimumSize,
  });

  Color getButtonColor(ButtonVariant type) {
    switch (type) {
      case ButtonVariant.primary:
        return primaryColor;
      case ButtonVariant.secondary:
        return Colors.black;
      case ButtonVariant.tertiary:
        return Colors.white;
      case ButtonVariant.success:
        return const Color(0xFF52C149);
      case ButtonVariant.alert:
        return const Color.fromARGB(255, 222, 149, 4);
      case ButtonVariant.danger:
        return const Color.fromARGB(255, 214, 48, 37);
      case ButtonVariant.outlineAlert:
        return Colors.white;
      case ButtonVariant.outlineDanger:
        return Colors.white;
      case ButtonVariant.outline:
        return Colors.white;
    }
  }

  BorderSide? getBorderSide(ButtonVariant type) {
    switch (type) {
      case ButtonVariant.primary:
        return null;
      case ButtonVariant.secondary:
        return null;
      case ButtonVariant.tertiary:
        return null;
      case ButtonVariant.success:
        return null;
      case ButtonVariant.alert:
        return null;
      case ButtonVariant.danger:
        return null;
      case ButtonVariant.outlineAlert:
        return const BorderSide(
            width: 2, color: Color.fromARGB(255, 222, 149, 4));
      case ButtonVariant.outlineDanger:
        return const BorderSide(
            width: 2, color: Color.fromARGB(255, 214, 48, 37));
      case ButtonVariant.outline:
        return BorderSide(width: 2, color: Colors.grey.shade300);
    }
  }

  TextStyle getButtonTextStyle(ButtonVariant type, double? size) {
    double fontSize = size ?? 14;

    switch (type) {
      case ButtonVariant.primary:
        return TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'Avenir',
          color: Colors.white,
        );
      case ButtonVariant.secondary:
        return TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'Avenir',
          color: Colors.white,
        );
      case ButtonVariant.tertiary:
        return TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'Avenir',
          color: primaryColor,
        );
      case ButtonVariant.success:
        return TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'Avenir',
          color: Colors.white,
        );
      case ButtonVariant.alert:
        return TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'Avenir',
          color: Colors.white,
        );
      case ButtonVariant.danger:
        return TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'Avenir',
          color: Colors.white,
        );
      case ButtonVariant.outlineAlert:
        return TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'Avenir',
          color: const Color.fromARGB(255, 222, 149, 4),
        );
      case ButtonVariant.outlineDanger:
        return TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'Avenir',
          color: const Color.fromARGB(255, 214, 48, 37),
        );
      case ButtonVariant.outline:
        return TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'Avenir',
          color: Colors.grey.shade700,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget children = withAddIcon != null && withAddIcon == true
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                const FaIcon(
                  FontAwesomeIcons.calendarPlus,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: getButtonTextStyle(variant, fontSize),
                ),
              ])
        : Text(
            title,
            style: getButtonTextStyle(variant, fontSize),
          );

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(minimumSize ?? 48),
        backgroundColor: getButtonColor(variant),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        side: getBorderSide(variant),
      ),
      child: children,
    );
  }
}
