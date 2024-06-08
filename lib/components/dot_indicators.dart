import 'package:flutter/material.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';

class DotIndicator extends StatelessWidget {
  // const DotIndicator({super.key});
  final bool isActive;
  final Color activeColor, inActiveColor;

  const DotIndicator({
    Key? key,
    this.isActive = false,
    this.activeColor = const Color(0xFF1886F9),
    this.inActiveColor = const Color(0xFF868686),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppConstants.kDefaultDuration,
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding / 2),
      height: 5,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inActiveColor.withOpacity(0.25),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}