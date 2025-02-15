import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class NewCustomDropdownFormField extends StatelessWidget {
  final List<String> list; // Lista de opções
  final String? hintText; // Texto de dica
  final String? helperText; // Texto de ajuda
  final String? labelText; // Texto de rótulo
  final String? Function(String?)? validator; // Função de validação
  final void Function(String?)? onChanged; // Função para tratar seleção
  final bool enabled; // Se o campo está habilitado
  final String? initialValue; // Valor inicial
  final TextEditingController? controller; // Controller do campo

  const NewCustomDropdownFormField({
    required this.list,
    this.hintText,
    this.helperText,
    this.labelText,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.initialValue,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Rótulo (Label) e Texto de ajuda (Helper)
        if (labelText != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                labelText!,
                color: blackColor40,
                fontSize: 14,
              ),
              const SizedBox(height: 6),
              if (helperText != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidCircleQuestion,
                      size: 16,
                      color: blackColor60,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: CustomText(
                        helperText!,
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
        // DropdownButtonFormField
        DropdownButtonFormField<String>(
          value: controller?.text.isNotEmpty == true
              ? controller?.text
              : initialValue,
          hint: hintText != null
              ? Text(
                  hintText!,
                  style: const TextStyle(
                    color: secondaryText,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                )
              : null,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(defaultBorderRadious),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor, width: 1),
              borderRadius: BorderRadius.circular(defaultBorderRadious),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(defaultBorderRadious),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(defaultBorderRadious),
            ),
          ),
          items: list
              .map(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
          onChanged: enabled
              ? (value) {
                  // Atualiza o controlador ao selecionar um valor
                  if (controller != null) {
                    controller!.text = value ?? '';
                  }
                  if (onChanged != null) {
                    onChanged!(value);
                  }
                }
              : null,
          validator: (value) {
            // Dispara o validator e atualiza o controller
            if (controller != null) {
              controller!.text = value ?? '';
            }
            return validator?.call(value);
          },
        ),
      ],
    );
  }
}
