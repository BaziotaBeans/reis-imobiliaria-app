import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';

class ReferenceCodeClipBoard extends StatelessWidget {
  final String code;

  const ReferenceCodeClipBoard({required this.code, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Clipboard.setData(
          ClipboardData(text: code),
        ).then(
          (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: AppText(
                  'Copiado para sua área de transferência!',
                  color: Colors.white,
                ),
              ),
            );
          },
        );
      },
      child: DottedBorder(
          borderType: BorderType.RRect,
          strokeWidth: 2,
          borderPadding: const EdgeInsets.all(0),
          color: const Color.fromARGB(47, 0, 0, 0),
          radius: const Radius.circular(12),
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(120),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  code,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                const Icon(
                  Icons.copy,
                  size: 24,
                  color: Color(0xff687553),
                )
              ],
            ),
          )),
    );
  }
}
