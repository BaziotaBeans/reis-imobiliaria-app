import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_dropdown_form_field.dart';
import 'package:reis_imovel_app/components/app_text_form_field.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/components/header.dart';
import 'package:reis_imovel_app/data/marital_status_data.dart';
import 'package:reis_imovel_app/data/nationality_data.dart';
import 'package:reis_imovel_app/models/Auh.dart';

class UserUpdateForm extends StatefulWidget {
  const UserUpdateForm({super.key});

  @override
  State<UserUpdateForm> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UserUpdateForm> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _nifController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _addresController = TextEditingController();

  final TextEditingController _nationalityController = TextEditingController();

  final TextEditingController _maritalStatusController =
      TextEditingController();

  final _userNameFocus = FocusNode();

  final _fullNameFocus = FocusNode();

  final _emailFocus = FocusNode();

  final _phoneFocus = FocusNode();

  final _nifFocus = FocusNode();

  final _addressFocus = FocusNode();

  final _nationalityFocus = FocusNode();

  final _maritalStatusFocus = FocusNode();

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Auth auth = Provider.of(context);

    _usernameController.text = auth.userName ?? "";
    _emailController.text = auth.email ?? "";
    _fullNameController.text = auth.fullName ?? "";
    _nifController.text = auth.nif ?? "";
    _phoneController.text = auth.phone ?? "";
    _addresController.text = auth.address ?? "";
    _nationalityController.text = auth.nationality ?? "";
    _maritalStatusController.text = auth.maritalStatus ?? "";
  }

  Widget _form(Auth auth) {
    print(auth.fullName);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextFormField(
              hintText: 'Digite o nome do usuário',
              labelText: 'Nome do usuário',
              helperText: 'Nome do usuário deve ter no minímo 5 caracteres',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              onSaved: (userName) => _formData['username'] = userName ?? '',
              onChanged: (value) {
                _formKey.currentState?.validate();
                // validateSubmitButton();
                // _usernameController.text = value;
                _formData['username'] = value;
              },
              controller: _usernameController,
              validator: (userN) {
                final uName = userN ?? '';
                if (uName.isEmpty || uName.length < 5) {
                  return 'Informe um nome de usuário válido';
                }
                return null;
              },
            ),
            AppTextFormField(
              hintText: 'Digite o nome completo',
              labelText: 'Nome completo',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              onSaved: (value) => _formData['fullName'] = value ?? '',
              onChanged: (value) {
                _formKey.currentState?.validate();
                // validateSubmitButton();
                _formData['fullName'] = value;
              },
              controller: _fullNameController,
              validator: (value) {
                final userValue = value ?? '';
                if (userValue.isEmpty) {
                  return 'Informe um nome válido';
                }
                return null;
              },
            ),
            AppTextFormField(
              hintText: 'Digite o E-mail',
              labelText: 'E-mail',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) => _formData['email'] = email ?? '',
              onChanged: (value) {
                _formKey.currentState?.validate();
                // validateSubmitButton();
                _formData['email'] = value;
              },
              validator: (_email) {
                final email = _email ?? '';
                if (email.trim().isEmpty || !email.contains('@')) {
                  return 'Informe um e-mail válido.';
                }
                return null;
              },
              controller: _emailController,
            ),
            IntlPhoneField(
              languageCode: 'ao',
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Número de telefone',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'AO',
              onSaved: (phone) => _formData['phone'] = phone?.number ?? '',
              onChanged: (phone) {
                _formKey.currentState?.validate();
                // validateSubmitButton();
                _formData['phone'] = phone.number;
              },
              controller: _phoneController,
              pickerDialogStyle: PickerDialogStyle(
                searchFieldInputDecoration:
                    const InputDecoration(labelText: 'Pesquisar País'),
              ),
              invalidNumberMessage: 'Informe um contacto válido',
            ),
            AppTextFormField(
              hintText: 'Digite o nif',
              labelText: 'NIF',
              helperText:
                  'O NIF (Número de Identificação Fiscal) deve possuir 14 caracteres',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              onSaved: (nif) => _formData['nif'] = nif ?? '',
              onChanged: (value) {
                _formKey.currentState?.validate();
                // validateSubmitButton();
                _formData['nif'] = value;
              },
              controller: _nifController,
              validator: (nif) {
                final userNif = nif ?? '';
                if (userNif.isEmpty || !(userNif.length == 14)) {
                  return 'Informe um NIF válido';
                }
                return null;
              },
            ),
            AppTextFormField(
              hintText: 'Digite o endereço',
              labelText: 'Endereço',
              helperText:
                  'O endereço é um campo obrigatório, pois será usado no acto da realização do contrato.',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              onSaved: (address) => _formData['address'] = address ?? '',
              onChanged: (value) {
                _formKey.currentState?.validate();
                // validateSubmitButton();
                _formData['address'] = value;
              },
              controller: _addresController,
              validator: (nif) {
                final userNif = nif ?? '';
                if (userNif.isEmpty) {
                  return 'Informe um Endereço válido';
                }
                return null;
              },
            ),
            AppDropdownFormField(
              controller: _nationalityController,
              hintText: 'Selecionar a nacionalidade',
              labelText: 'Nacionalidade',
              list: nationalities,
              widthValueOfPadding: 24,
              enableFilter: true,
              enableSearch: true,
            ),
            AppDropdownFormField(
              controller: _maritalStatusController,
              hintText: 'Selecionar o estado civil',
              labelText: 'Estado civil',
              list: maritalStatusData,
              widthValueOfPadding: 24,
              enableFilter: true,
              enableSearch: true,
            ),
            Button(
              title: "Actualizar os dados",
              onPressed: () {},
              variant: ButtonVariant.success,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Header(title: "Editar dados do Perfil"),
              _form(auth),
            ],
          ),
        ),
      ),
    );
  }
}
