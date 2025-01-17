import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reis_imovel_app/screens/auth/components/document_uploader.dart';
import 'package:reis_imovel_app/screens/auth/components/title_form.dart';

class QuaternaryPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(PlatformFile?) onFileSelected;

  const QuaternaryPage({
    super.key,
    required this.formKey,
    required this.onFileSelected,
  });

  @override
  State<QuaternaryPage> createState() => _QuaternaryPageState();
}

class _QuaternaryPageState extends State<QuaternaryPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleForm(title: 'Dados do documento'),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text:
                          'Envie os documentos para efeito da verificação, para saber mais ',
                      children: [
                        TextSpan(
                          text: 'clique aqui.',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {print('yes')},
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 42),
            DocumentUploader(
              onFileSelected: widget.onFileSelected,
            ),
          ],
        ),
      ),
    );
  }
}
