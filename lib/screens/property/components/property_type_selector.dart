import 'package:flutter/material.dart';
import 'package:reis_imovel_app/screens/property/components/selector_box_item.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class PropertyTypeSelector extends StatefulWidget {
  final Function(String) onPropertyType;
  final String selectedAnnouncementType;

  const PropertyTypeSelector({
    super.key,
    required this.onPropertyType,
    required this.selectedAnnouncementType,
  });

  @override
  State<PropertyTypeSelector> createState() => _PropertyTypeSelectorState();
}

class _PropertyTypeSelectorState extends State<PropertyTypeSelector> {
  String selectedPropertyType = "APARTMENT";

  void _selectPropertyType(String propertyType) {
    setState(() {
      selectedPropertyType = propertyType;
    });

    widget.onPropertyType(propertyType);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectorBoxItem(
              onSelectAnnouncement: _selectPropertyType,
              selectedAnnouncement: selectedPropertyType,
              type: 'APARTMENT',
              label: 'Apartamento',
              svgSrc: "assets/icons/Apartment.svg",
            ),
            const SizedBox(width: defaultPadding),
            SelectorBoxItem(
              onSelectAnnouncement: _selectPropertyType,
              selectedAnnouncement: selectedPropertyType,
              type: 'HOME',
              label: 'Casa',
              svgSrc: "assets/icons/Simple Home.svg",
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectorBoxItem(
              onSelectAnnouncement: _selectPropertyType,
              selectedAnnouncement: selectedPropertyType,
              type: 'VILLA',
              label: 'Vivenda',
              svgSrc: "assets/icons/Villa.svg",
            ),
            const SizedBox(width: defaultPadding),
            if (widget.selectedAnnouncementType == 'SALE')
              SelectorBoxItem(
                onSelectAnnouncement: _selectPropertyType,
                selectedAnnouncement: selectedPropertyType,
                type: 'TERRAIN',
                label: 'Terreno',
                svgSrc: "assets/icons/Land.svg",
              ),
          ],
        ),
      ],
    );
  }
}
