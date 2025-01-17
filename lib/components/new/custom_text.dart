import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final String? fontFamily;
  final double? letterSpacing;
  final bool? softWrap;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;
  final TextDecoration? textDecoration;
  final Color? textDecorationColor;
  final double? textDecorationThickness;
  final TextDecorationStyle? textDecorationStyle;

  const CustomText(this.text,
      {Key? key,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.textAlign,
      this.fontFamily,
      this.letterSpacing,
      this.softWrap,
      this.maxLines,
      this.overflow,
      this.height,
      this.textDecoration,
      this.textDecorationColor,
      this.textDecorationThickness,
      this.textDecorationStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily ?? 'Plus Jakarta',
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: fontSize ?? 14,
        color: color ?? Colors.black,
        letterSpacing: letterSpacing,
        height: height,
        decoration: textDecoration,
        decorationColor: textDecorationColor,
        decorationThickness: textDecorationThickness,
        decorationStyle: textDecorationStyle,
      ),
      textAlign: textAlign,
      softWrap: softWrap ?? false,
      maxLines: maxLines ?? 1,
      overflow: overflow,
    );
  }
}
