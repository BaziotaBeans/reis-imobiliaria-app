import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:reis_imovel_app/components/app_text.dart';

class UploadImages extends StatefulWidget {
  final List<MediaFile> selectedFiles;
  final void Function(int index) onDelete;
  final void Function() onAdd;

  const UploadImages({
    required this.selectedFiles,
    required this.onDelete,
    required this.onAdd,
    super.key,
  });

  @override
  State<UploadImages> createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _selectImageFromGalleryBox(),
        const SizedBox(height: 14),
        _buildImageListUI(),
      ],
    );
  }

  Widget _imageItem(MediaFile file, int index) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  offset: const Offset(0, 1),
                  blurRadius: 3,
                  spreadRadius: 2,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: PhotoProvider(
                media: file,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: 5,
          top: 5,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            radius: 10,
            onTap: () {
              widget.onDelete(index);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red[600],
              ),
              width: 20,
              height: 20,
              alignment: Alignment.center,
              child: const FaIcon(
                FontAwesomeIcons.xmark,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildImageListUI() {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: 60,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: widget.selectedFiles.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          MediaFile _file = widget.selectedFiles[index];

          return _imageItem(_file, index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 5);
        },
      ),
    );
  }

  Widget _selectImageFromGalleryBox() {
    return GestureDetector(
      onTap: widget.onAdd,
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeWidth: 2,
        borderPadding: const EdgeInsets.all(0),
        radius: const Radius.circular(12),
        dashPattern: const [10, 4],
        strokeCap: StrokeCap.round,
        color: Colors.blue.shade400,
        child: Container(
          width: double.infinity,
          height: 120,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50.withOpacity(.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              const Icon(
                Iconsax.folder_open,
                color: Colors.blue,
                size: 40,
              ),
              const SizedBox(height: 15),
              AppText(
                'Selecione as imagens',
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
