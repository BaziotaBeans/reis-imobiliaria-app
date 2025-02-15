import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_dropdown_form_field.dart';
import 'package:reis_imovel_app/components/new/custom_form_field.dart';
import 'package:reis_imovel_app/components/new/new_custom_dropdown_form_field.dart';
import 'package:reis_imovel_app/data/conservation_data.dart';
import 'package:reis_imovel_app/screens/property/components/subtitle_page.dart';
import 'package:reis_imovel_app/screens/property/components/title_page.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/validators/new_apartment_form_validator.dart';

class FirstPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController titleController;

  final TextEditingController descriptionController;

  final TextEditingController conservationController;

  const FirstPage({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.conservationController,
  });

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String? conservationError;

  void validateConservationField() {
    if (widget.conservationController.text.isEmpty) {
      setState(() {
        conservationError = 'Por favor, selecione o estado de conservação.';
      });
    } else {
      setState(() {
        conservationError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitlePage(title: 'Informações Gerais'),
            const SubtitlePage(
              description: 'Por favor preencha os campos com muita atenção...',
            ),
            const SizedBox(height: 24),
            CustomFormField(
              controller: widget.titleController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              labelText: 'Título/Nome',
              hintText: 'Título/Nome',
              validator: titleValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.descriptionController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              labelText: 'Descrição (Opcional)',
              hintText: 'Digite aqui...',
              maxLines: 6,
              // validator: userNameValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            NewCustomDropdownFormField(
              labelText: 'Conservação',
              hintText: 'Selecionar o estado de conservação',
              controller: widget.conservationController,
              list: conservationData,
              // validator: genericValidator.call,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo é obrigatório.';
                }
                return null;
              },
              onChanged: (value) {
                debugPrint('Selected value: $value');
              },
            ),
            // CustomDropdownFormField(
            //   list: conservationData,
            //   hintText: 'Selecionar o estado de conservação',
            //   labelText: 'Conservação',
            //   controller: widget.conservationController,
            //   onSelected: (value) {
            //     // Atualizar o valor no controller sempre que uma seleção for feita
            //     widget.conservationController.text = value ?? '';
            //     validateConservationField();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
