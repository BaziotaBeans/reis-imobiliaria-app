import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reis_imovel_app/components/app_date_picker.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/app_text_form_field.dart';
import 'package:reis_imovel_app/components/button.dart';

class ScheduleVisiteForm extends StatefulWidget {
  const ScheduleVisiteForm({super.key});

  @override
  State<ScheduleVisiteForm> createState() => _ScheduleVisiteFormState();
}

class _ScheduleVisiteFormState extends State<ScheduleVisiteForm> {
  final _phoneNumberController = TextEditingController();

  final _timeController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    _timeController.text = ""; //set the initial value of text field
    super.initState();
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime != null) {
        setState(() {
          _selectedTime = pickedTime;
        });

        _timeController.text = pickedTime.format(context);

        print(pickedTime.format(context));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);

    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            top: 24,
            right: 10,
            left: 10,
            bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const AppText(
                'Agendar Visita',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xff3a3f67),
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: 'Telefone',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onChanged: (value) {},
                controller: _phoneNumberController,
              ),
              AppTextFormField(
                hintText: 'Telefone',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onChanged: (value) {},
                controller: _phoneNumberController,
              ),
              AppTextFormField(
                hintText: 'Telefone',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onChanged: (value) {},
                controller: _phoneNumberController,
              ),
              AppTextFormField(
                hintText: 'Telefone',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onChanged: (value) {},
                controller: _phoneNumberController,
              ),
              AppTextFormField(
                hintText: 'Telefone',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onChanged: (value) {},
                controller: _phoneNumberController,
              ),
              AppTextFormField(
                hintText: 'Telefone',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onChanged: (value) {},
                controller: _phoneNumberController,
              ),
              AppTextFormField(
                hintText: 'Telefone',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onChanged: (value) {},
                controller: _phoneNumberController,
              ),
              AppTextFormField(
                hintText: 'Hora',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onChanged: (value) {},
                onTap: () {
                  _showTimePicker();
                },
                controller: _timeController,
                readOnly: true,
              ),
              AppDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              const SizedBox(height: 24),
              Button(
                title: 'Agendar',
                onPressed: () {
                  msg.showSnackBar(
                    SnackBar(
                      content: Text('Agendado'),
                    ),
                  );
                  Navigator.pop(context);
                },
                variant: ButtonVariant.success,
              )
            ],
          ),
        ),
      ),
    );
  }
}
