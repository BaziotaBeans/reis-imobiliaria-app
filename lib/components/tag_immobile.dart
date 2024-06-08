import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';

class TagImmobile extends StatelessWidget {
  final String type;

  const TagImmobile({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: ShapeDecoration(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AppText(
              type,
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              // height: 0.21,
            ),
          ),
        ],
      ),
    );
  }
}
