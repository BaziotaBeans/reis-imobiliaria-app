import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? labelText;
  final String? helperText;
  final String? hintText;
  final bool? autofocus;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final int? maxLines;
  final bool? readOnly;
  final String? initialValue;

  const AppTextFormField(
      {required this.textInputAction,
      required this.keyboardType,
      required this.controller,
      super.key,
      this.onChanged,
      this.onSaved,
      this.validator,
      this.hintText,
      this.labelText,
      this.helperText,
      this.obscureText,
      this.suffixIcon,
      this.onEditingComplete,
      this.autofocus,
      this.focusNode,
      this.maxLines,
      this.readOnly,
      this.onTap,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (labelText != null && helperText == null)
            AppText(
              labelText ?? '',
              color: Colors.grey[600],
              fontSize: 14,
            ),
          if (labelText != null && helperText != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText(
                  labelText ?? '',
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidCircleQuestion,
                      size: 16,
                      color: Color(0xff3D3F33),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: AppText(
                        helperText ?? '',
                        color: Colors.grey[600],
                        fontSize: 12,
                        maxLines: 4,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ],
            ),
          TextFormField(
            initialValue: initialValue,
            controller: controller,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            focusNode: focusNode,
            onChanged: onChanged,
            onSaved: onSaved,
            onTap: onTap,
            autofocus: autofocus ?? false,
            validator: validator,
            obscureText: obscureText ?? false,
            obscuringCharacter: '*',
            readOnly: readOnly ?? false,
            onEditingComplete: onEditingComplete,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                suffixIcon: suffixIcon,
                // labelText: labelText,
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0x993C3C43),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Avenir',
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                // border: const OutlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Colors.transparent,
                //     style: BorderStyle.none,
                //   ),
                // ),
                filled: true,
                fillColor: AppColors.inputFillColor,
                focusColor: AppColors.inputFillColor,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff687553),
                    width: 2,
                  ),
                ),
                alignLabelWithHint: true,
                labelStyle: TextStyle()),
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            maxLines: maxLines,
          ),
        ],
      ),
    );
  }
}
