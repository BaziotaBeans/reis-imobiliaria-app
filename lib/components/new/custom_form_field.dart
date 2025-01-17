import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class CustomFormField extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType keyboardType;
  final TextEditingController? controller;
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

  const CustomFormField({
    required this.textInputAction,
    required this.keyboardType,
    this.controller,
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
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (labelText != null && helperText == null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                labelText ?? '',
                color: blackColor40,
                fontSize: 14,
              ),
              const SizedBox(height: 6),
            ],
          ),
        if (labelText != null && helperText != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                labelText ?? '',
                color: blackColor40,
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
                    color: blackColor60,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: CustomText(
                      helperText ?? '',
                      color: blackColor40,
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
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: true,
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          maxLines: maxLines,
        ),
      ],
    );
  }
}
