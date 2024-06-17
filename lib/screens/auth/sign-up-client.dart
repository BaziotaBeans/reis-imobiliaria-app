import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_dropdown_form_field.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/app_text_form_field.dart';
import 'package:reis_imovel_app/components/auth/sign-up-header.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/data/marital_status_data.dart';
import 'package:reis_imovel_app/data/nationality_data.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/models/Client.dart';
import 'package:reis_imovel_app/models/user_signup.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_validators.dart';

class SignUpClientScreen extends StatefulWidget {
  const SignUpClientScreen({super.key});

  @override
  State<SignUpClientScreen> createState() => _SignUpClientScreenState();
}

class _SignUpClientScreenState extends State<SignUpClientScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _nifController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _nationalityController = TextEditingController();

  final TextEditingController _maritalStatusController =
      TextEditingController();

  bool isEnable = false;

  final Map<String, String> _formData = {
    'username': '',
    'fullName': '',
    'email': '',
    'phone': '',
    'nif': '',
    'password': '',
  };

  bool _isLoading = false;

  bool isObscure = true;

  void validateSubmitButton() {
    bool isValid = true;

    isValid = _usernameController.text.isNotEmpty &&
        _usernameController.text.length >= 5 &&
        _fullNameController.text.isNotEmpty &&
        _fullNameController.text.length >= 5 &&
        _nifController.text.isNotEmpty &&
        _nifController.text.length == 14 &&
        _passwordController.text.isNotEmpty &&
        _passwordController.text.length >= 5 &&
        _emailController.text.isNotEmpty &&
        _addressController.text.isNotEmpty &&
        _nationalityController.text.isNotEmpty &&
        _maritalStatusController.text.isNotEmpty &&
        AppValidators.validatePhoneNumber(_phoneController.text.toString());

    setState(() {
      isEnable = isValid;
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um Erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    print("SEEE");

    print(_formData);

    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    Auth auth = Provider.of(context, listen: false);

    final user = UserSignup(
      username: _formData['username']!,
      fullName: _formData['fullName']!,
      email: _formData['email']!,
      password: _formData['password']!,
      phone: _formData['phone']!,
      role: ["user"],
      nif: _formData['nif']!,
      address: _formData['address']!,
      nationality: _formData['nationality']!,
      maritalStatus: _formData['maritalStatus']!,
    );

    final client = Client(nif: _formData["nif"]!);

    try {
      await auth.signupWithClient(user, client);

      Navigator.of(context).restorablePopAndPushNamed(AppRoutes.SIGN_IN);

      Fluttertoast.showToast(
        msg: "Conta criada com sucesso",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[700],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } on Exception catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Por favor verifique se os seus dados são válidos.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextFormField(
            hintText: 'Digite o nome do usuário',
            labelText: 'Nome do usuário',
            helperText:
                'Nome do usuário deve ter no minímo 5 caracteres e no máximo 20 caracteres',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            onSaved: (userName) => _formData['username'] = userName ?? '',
            onChanged: (value) {
              _formKey.currentState?.validate();
              validateSubmitButton();
              _usernameController.text = value;
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
              validateSubmitButton();
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
              validateSubmitButton();
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
              validateSubmitButton();
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
              validateSubmitButton();
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
            controller: _addressController,
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
            helperText:
                "A nacionalidade é um campo obrigatório, pois será usado no acto da realização do contrato.",
            list: nationalities,
            widthValueOfPadding: 24,
            enableFilter: true,
            enableSearch: true,
            onSelected: (value) {
              if (value != null) {
                _formData["nationality"] = value;
              }
            },
          ),
          AppDropdownFormField(
            controller: _maritalStatusController,
            hintText: 'Selecionar o estado civil',
            labelText: 'Estado civil',
            list: maritalStatusData,
            widthValueOfPadding: 24,
            enableFilter: true,
            enableSearch: true,
            onSelected: (value) {
              if (value != null) {
                _formData["maritalStatus"] = value;
              }
            },
          ),
          AppTextFormField(
            hintText: 'Digite a Senha',
            labelText: 'Senha',
            helperText: 'Senha deve ter no máximo 8 caracteres',
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            onSaved: (password) => _formData['password'] = password ?? '',
            onChanged: (value) {
              _formKey.currentState?.validate();
              validateSubmitButton();
              _formData['password'] = value;
            },
            validator: (_password) {
              final password = _password ?? '';
              if (password.isEmpty || password.length < 5) {
                return 'Informe uma senha válida';
              }
              return null;
            },
            controller: _passwordController,
            obscureText: isObscure,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(48, 48)),
                ),
                icon: Icon(
                  isObscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Button(
              title: 'Criar conta',
              onPressed: isEnable ? _submit : null,
              variant: ButtonVariant.primary,
            )
        ],
      ),
    );
  }

  Widget _footerSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Você já possui uma conta?',
          style: TextStyle(
              color: Color(0xFF74778B),
              fontWeight: FontWeight.w400,
              fontSize: 14),
        ),
        const SizedBox(
          width: 4,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.SIGN_IN);
          },
          child: const AppText(
            'Entrar',
            color: Color(0xff687553),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // UserTypeEnum userType = ModalRoute.of(context)?.settings.arguments as UserTypeEnum;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 62),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignUpHeader(),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: _form(),
                ),
                const SizedBox(
                  height: 60,
                ),
                _footerSection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
