import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class AppDropdownFormField extends StatelessWidget {
  final TextEditingController controller;
  final List<String> list;
  final int widthValueOfPadding;
  final String? hintText;
  final String? helperText;
  final String? labelText;
  final void Function(String?)? onSelected;
  final bool enabled;
  final bool? enableSearch;
  final bool? enableFilter;

  const AppDropdownFormField({
    required this.controller,
    required this.list,
    required this.widthValueOfPadding,
    this.hintText,
    this.helperText,
    this.labelText,
    this.onSelected,
    this.enabled = true,
    this.enableSearch = true,
    this.enableFilter = true,
    super.key,
  });

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
                  color: secondaryText,
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
                      color: secondaryColor,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: AppText(
                        helperText ?? '',
                        color: secondaryText,
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
          DropdownMenu<String>(
            enableSearch: enableSearch ?? true,
            enableFilter: enableFilter ?? true,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            // helperText: helperText,
            enabled: enabled,
            width:
                MediaQuery.of(context).size.width - (widthValueOfPadding * 2),
            controller: controller,
            onSelected: onSelected,
            requestFocusOnTap: true,
            // initialSelection: list.first,
            dropdownMenuEntries:
                list.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(
                value: value,
                label: value,
              );
            }).toList(),
            menuStyle: MenuStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            hintText: hintText,
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: const TextStyle(
                color: secondaryColor,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              filled: true,
              fillColor: AppColors.inputFillColor,
              focusColor: primaryColor,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
