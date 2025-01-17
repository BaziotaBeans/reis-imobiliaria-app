import 'package:flutter/material.dart';
import 'package:reis_imovel_app/utils/constants.dart';

enum ButtonVariant {
  primary,
  secondary,
  tertiary,
  outline,
  text,
  danger,
  success,
  warning
}

class ButtonStyleData {
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  const ButtonStyleData({
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  });
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final double? height;
  final double borderRadius;
  final double fontSize;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? forcedTextColor;
  final Color? forcedBackgroundColor;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height = 48,
    this.borderRadius = 8,
    this.fontSize = 16,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.forcedTextColor,
    this.forcedBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: _getButtonStyle(context),
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildButtonContent() {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLoading) ...[
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getLoadingColor(),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          if (prefixIcon != null && !isLoading) ...[
            Icon(prefixIcon, size: 20),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (suffixIcon != null && !isLoading) ...[
            const SizedBox(width: 8),
            Icon(suffixIcon, size: 20),
          ],
        ],
      ),
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final theme = Theme.of(context);

    // Cores padrão baseadas na variante
    final defaultStyles = _getDefaultStyles(theme);

    return ElevatedButton.styleFrom(
      backgroundColor: isDisabled
          ? theme.disabledColor
          : backgroundColor ?? defaultStyles.backgroundColor,
      foregroundColor: textColor ?? defaultStyles.textColor,
      disabledBackgroundColor: Colors.grey.shade400,
      disabledForegroundColor: theme.disabledColor.withOpacity(0.38),
      side: variant == ButtonVariant.outline
          ? BorderSide(
              color: borderColor ??
                  defaultStyles.borderColor ??
                  Colors.transparent,
              width: 1.5,
            )
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: variant == ButtonVariant.text ? 0 : 2,
      padding: EdgeInsets.zero,
    );
  }

  ButtonStyleData _getDefaultStyles(ThemeData theme) {
    switch (variant) {
      case ButtonVariant.primary:
        return ButtonStyleData(
          backgroundColor: theme.primaryColor,
          textColor: Colors.white,
        );
      case ButtonVariant.secondary:
        return const ButtonStyleData(
          backgroundColor: secondaryColor,
          textColor: Colors.white,
        );
      case ButtonVariant.tertiary:
        return ButtonStyleData(
          backgroundColor: Colors.white,
          textColor: forcedTextColor ?? theme.primaryColor,
        );
      case ButtonVariant.outline:
        return ButtonStyleData(
          backgroundColor: forcedBackgroundColor ?? Colors.transparent,
          textColor: theme.primaryColor,
          borderColor: theme.primaryColor,
        );
      case ButtonVariant.text:
        return ButtonStyleData(
          backgroundColor: Colors.transparent,
          textColor: theme.primaryColor,
        );
      case ButtonVariant.danger:
        return const ButtonStyleData(
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      case ButtonVariant.success:
        return const ButtonStyleData(
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      case ButtonVariant.warning:
        return const ButtonStyleData(
          backgroundColor: Colors.orange,
          textColor: Colors.white,
        );
    }
  }

  Color _getLoadingColor() {
    switch (variant) {
      case ButtonVariant.outline:
      case ButtonVariant.text:
        return textColor ?? Colors.blue;
      default:
        return Colors.white;
    }
  }
}
