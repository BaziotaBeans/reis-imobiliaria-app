import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:reis_imovel_app/components/app_text_form_field.dart';

class MultiStepForm extends StatefulWidget {
  const MultiStepForm({super.key});

  @override
  State<MultiStepForm> createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Step-Form'),
      ),
      body: Stepper(
        steps: getSteps(),
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
        currentStep: _currentStep,
        onStepContinue: () {
          final isLastStep = _currentStep == getSteps().length - 1;
          if (isLastStep) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Form Submitted'),
                  content: Text('Your form has been submitted successfully'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    )
                  ],
                );
              },
            );
          } else {
            setState(() {
              _currentStep++;
            });
          }
        },
      ),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        title: Text('Name'),
        content: Column(
          children: [
            AppTextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              controller: _firstnameController,
              labelText: 'First Name',
            ),
            AppTextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              controller: _lastnameController,
              labelText: 'Last Name',
            ),
            IntlPhoneField(
              languageCode: 'ao',
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                print(phone.completeNumber);
              },
              pickerDialogStyle: PickerDialogStyle(
                searchFieldInputDecoration: InputDecoration(
                  // hintText: 'Pesquisar País',
                  labelText: 'Pesquisar País'
                )
              )
            )
          ],
        ),
      ),
      Step(
        title: Text('Email field'),
        content: Column(
          children: [
            AppTextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              controller: _emailController,
              labelText: 'Email',
            ),
          ],
        ),
      ),
      Step(
        title: Text('Phone Number field'),
        content: Column(
          children: [
            AppTextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              controller: _phoneController,
              labelText: 'phone',
            ),
          ],
        ),
      ),
    ];
  }
}
