import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class CustomDropdownFormField extends StatelessWidget {
  final TextEditingController? controller;
  final List<String> list;
  final int? widthValueOfPadding;
  final String? hintText;
  final String? helperText;
  final String? labelText;
  final void Function(String?)? onSelected;
  final bool enabled;
  final bool? enableSearch;
  final bool? enableFilter;

  const CustomDropdownFormField({
    required this.list,
    this.widthValueOfPadding,
    this.controller,
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
                mainAxisAlignment: MainAxisAlignment.center,
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
        Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: DropdownMenu<String>(
            enableSearch: enableSearch ?? true,
            enableFilter: enableFilter ?? true,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            // helperText: helperText,
            enabled: enabled,
            width: MediaQuery.of(context).size.width,
            // width: MediaQuery.of(context).size.width - (widthValueOfPadding * 2),
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
              backgroundColor: MaterialStateProperty.all(Colors.white),
              surfaceTintColor: MaterialStateProperty.all(primaryColor),
            ),
            hintText: hintText,
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(
                color: secondaryText,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(defaultBorderRadious),
                ),
              ),
              filled: true,
              // fillColor: primaryColor,
              focusColor: primaryColor,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
