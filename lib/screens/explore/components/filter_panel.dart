import 'package:flutter/material.dart';

class FilterPanel extends StatelessWidget {
  final bool showForSale;
  final bool showForRent;
  final double maxPrice;
  final Function onFilterChanged;

  const FilterPanel({
    required this.showForSale,
    required this.showForRent,
    required this.maxPrice,
    required this.onFilterChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            CheckboxListTile(
              title: Text('Venda'),
              value: showForSale,
              onChanged: (value) => onFilterChanged(showForSale: value),
            ),
            CheckboxListTile(
              title: Text('Aluguel'),
              value: showForRent,
              onChanged: (value) => onFilterChanged(showForRent: value),
            ),
            Slider(
              value: maxPrice,
              max: 1000000,
              divisions: 20,
              label: 'R\$ ${maxPrice.toStringAsFixed(2)}',
              onChanged: (value) => onFilterChanged(maxPrice: value),
            ),
          ],
        ),
      ),
    );
  }
}
