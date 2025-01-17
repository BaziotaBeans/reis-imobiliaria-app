import 'package:flutter/material.dart';
import 'package:reis_imovel_app/screens/property/components/selector_box_item.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class PropertyAnnouncementTypeSelector extends StatefulWidget {
  final Function(String) onAnnouncementType;

  const PropertyAnnouncementTypeSelector({
    super.key,
    required this.onAnnouncementType,
  });

  @override
  State<PropertyAnnouncementTypeSelector> createState() =>
      _PropertyAnnouncementTypeSelectorState();
}

class _PropertyAnnouncementTypeSelectorState
    extends State<PropertyAnnouncementTypeSelector> {
  String selectedAnnouncement = "SALE";

  void _selectAnnouncement(String profile) {
    setState(() {
      selectedAnnouncement = profile;
    });

    widget.onAnnouncementType(profile);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SelectorBoxItem(
          onSelectAnnouncement: _selectAnnouncement,
          selectedAnnouncement: selectedAnnouncement,
          type: 'SALE',
          label: 'Venda',
          svgSrc: "assets/icons/Home - Sale.svg",
        ),
        const SizedBox(width: defaultPadding),
        SelectorBoxItem(
          onSelectAnnouncement: _selectAnnouncement,
          selectedAnnouncement: selectedAnnouncement,
          type: 'RENT',
          label: 'Aluguel',
          svgSrc: "assets/icons/Home - Rent.svg",
        ),
      ],
    );
  }
}
