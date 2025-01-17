import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_form_field.dart';
import 'package:reis_imovel_app/screens/property/components/subtitle_page.dart';
import 'package:reis_imovel_app/screens/property/components/title_page.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/validators/new_apartment_form_validator.dart';

class FirstPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController titleController;

  final TextEditingController descriptionController;

  const FirstPage({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
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
          ],
        ),
      ),
    );
  }
}
