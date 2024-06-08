import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reis_imovel_app/components/app_text_form_field.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';

class AddNewImages extends StatefulWidget {
  final TextEditingController controller;
  final List<String> images;
  final void Function(int index) onDelete;
  final void Function(String url) onAdd;

  const AddNewImages(
      {required this.controller,
      required this.images,
      required this.onDelete,
      required this.onAdd,
      super.key});

  @override
  State<AddNewImages> createState() => _AddNewImagesState();
}

class _AddNewImagesState extends State<AddNewImages> {
  bool isEnable = false;

  void validateSubmitButton() {
    bool isValid = true;

    isValid = AppUtils.isValidImageUrl(widget.controller.text) &&
        widget.controller.text.isNotEmpty;

    setState(() {
      isEnable = isValid;
    });
  }

  void _submit() {
    widget.onAdd(widget.controller.text);
    print(widget.images);
    widget.controller.clear();
    validateSubmitButton();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTextFormField(
                textInputAction: TextInputAction.none,
                keyboardType: TextInputType.url,
                controller: widget.controller,
                hintText: 'Informe a url da imagem',
                onChanged: (value) {
                  validateSubmitButton();
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 90,
              height: 55,
              child: Button(
                title: 'Adicionar',
                onPressed: isEnable ? _submit : null,
                variant: ButtonVariant.success,
                fontSize: 13,
              ),
            ),
          ],
        ),
        Container(
          width: width,
          height: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: widget.images.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Positioned(
                    child: Image.network(
                      widget.images[index],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(40),
                      radius: 10,
                      onTap: () {
                        widget.onDelete(index);
                        print(index);
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: const FaIcon(
                          FontAwesomeIcons.xmark,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 5);
            },
          ),
        ),
      ],
    );
  }
}
