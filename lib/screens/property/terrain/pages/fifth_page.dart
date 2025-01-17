import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/upload_images.dart';
import 'package:reis_imovel_app/screens/property/components/subtitle_page.dart';
import 'package:reis_imovel_app/screens/property/components/title_page.dart';
import 'package:gallery_picker/gallery_picker.dart';

class FifthPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final void Function(int index) onRemoveImageFromSelectedFiles;

  final void Function() onSelectFile;

  final List<MediaFile> selectedFiles;

  const FifthPage({
    super.key,
    required this.formKey,
    required this.selectedFiles,
    required this.onRemoveImageFromSelectedFiles,
    required this.onSelectFile,
  });

  @override
  State<FifthPage> createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitlePage(title: 'Fazer upload de imagens de imóveis'),
            const SubtitlePage(
              description:
                  'Você precisa adicionar 10 fotos no máximo para o imóvel.',
            ),
            const SizedBox(height: 24),
            UploadImages(
              selectedFiles: widget.selectedFiles,
              onDelete: widget.onRemoveImageFromSelectedFiles,
              onAdd: widget.onSelectFile,
            )
          ],
        ),
      ),
    );
  }
}
