import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';

class AppDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateChanged;

  const AppDatePicker({
    required this.selectedDate,
    required this.onDateChanged,
    super.key,
  });

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Text(selectedDate == null
                ? 'Nenhuma data selecionada!'
                : 'Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate!)}'),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.primary),
            ),
            onPressed: () => _showDatePicker(context),
            child: const CustomText(
              'Selecionar Data',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
