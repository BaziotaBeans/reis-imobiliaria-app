import 'package:flutter/material.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class DotIndicator extends StatelessWidget {
  final bool isActive;

  final Color? inActiveColor, activeColor;

  const DotIndicator({
    super.key,
    this.isActive = false,
    this.inActiveColor,
    this.activeColor = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: defaultDuration,
      width: 20,
      height: 5,
      decoration: BoxDecoration(
        color: isActive
            ? activeColor
            : inActiveColor ?? primaryColor.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
    );
  }
}
