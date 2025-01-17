import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';

class SelectorBoxItem extends StatelessWidget {
  final Function(String) onSelectAnnouncement;
  final String selectedAnnouncement;
  final String type;
  final String label;
  final String svgSrc;

  const SelectorBoxItem({
    super.key,
    required this.onSelectAnnouncement,
    required this.selectedAnnouncement,
    required this.type,
    required this.label,
    required this.svgSrc,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelectAnnouncement(type),
        child: AnimatedContainer(
          duration: Durations.short4,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selectedAnnouncement == type
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade300,
              width: selectedAnnouncement == type ? 2 : 1,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      svgSrc,
                      height: 40,
                      width: 40,
                      colorFilter: ColorFilter.mode(
                        selectedAnnouncement == type
                            ? const Color(0xFF6366F1)
                            : Colors.grey.shade400,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      label,
                      color: selectedAnnouncement == type
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade400,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              ),
              if (selectedAnnouncement == type)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
