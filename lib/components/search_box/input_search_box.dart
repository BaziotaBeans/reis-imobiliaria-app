import 'package:flutter/material.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';

class InputSearchBox extends StatelessWidget {
  const InputSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Pesquisar',
        filled: true,
        fillColor: AppColors.inputFillColor,
        focusColor: AppColors.inputFillColor,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF1886F9),
            width: 2,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }
}
