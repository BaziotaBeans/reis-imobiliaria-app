import 'package:flutter/material.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class MarkerWidget extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const MarkerWidget({
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: isSelected ? activeMarkerColor : inactiveMarkerColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
