import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text_form_field.dart';
import 'package:reis_imovel_app/components/auth/sign-up-header.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/models/Company.dart';
import 'package:reis_imovel_app/models/user_signup.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_validators.dart';

class SignUpCompany extends StatefulWidget {
  const SignUpCompany({super.key});

  @override
  State<SignUpCompany> createState() => _SignUpCompanyState();
}

class _SignUpCompanyState extends State<SignUpCompany> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _nifController = TextEditingController();

  final TextEditingController _bankNameController = TextEditingController();

  final TextEditingController _bankAcountNumberController =
      TextEditingController();

  final TextEditingController _bankIBANController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isEnable = false;

  bool isObscure = true;

  bool _isLoading = false;

  final Map<String, String> _formData = {
    'username': '',
    'fullName': '',
    'email': '',
    'phone': '',
    'password': '',
    'nif': '',
    'bankName': '',
    'bankAccountNumber': '',
    'iban': '',
  };

  void validateSubmitButton() {
    bool isValid = true;

    isValid = AppValidators.validateField(_usernameController.text, 5) &&
        AppValidators.validateField(_fullNameController.text, 5) &&
        AppValidators.validateField(_passwordController.text, 5) &&
        _emailController.text.isNotEmpty &&
        AppValidators.validatePhoneNumber(_phoneController.text.toString()) &&
        AppValidators.validateField(_nifController.text, 5) &&
        AppValidators.validateField(_bankNameController.text, 1) &&
        AppValidators.validateField(_bankAcountNumberController.text, 5) &&
        AppValidators.validateField(_bankIBANController.text, 5);

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

    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    print(_formData);

    Auth auth = Provider.of(context, listen: false);

    final user = UserSignup(
      username: _formData['username']!,
      fullName: _formData['fullName']!,
      email: _formData['email']!,
      password: _formData['password']!,
      phone: _formData['phone']!,
      role: ["company"],
      nif: _formData['nif']!,
      address: _formData['addres']!,
      nationality: _formData['nationality']!,
      maritalStatus: _formData['maritalStatus']!,
    );

    final company = Company(
      nif: _formData["nif"]!,
      bankName: _formData["bankName"]!,
      bankAccountNumber: _formData["bankAccountNumber"]!,
      iban: _formData["iban"]!,
    );

    try {
      await auth.signupWithCompany(user, company);

      Navigator.of(context).pushNamed(AppRoutes.SIGN_IN);

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
    }

    setState(() => _isLoading = false);
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
            helperText: 'Nome do usuário deve ter no minímo 5 caracteres',
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
            hintText: 'Digite o nome do banco',
            labelText: 'BANCO',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            onSaved: (bankName) => _formData['bankName'] = bankName ?? '',
            onChanged: (value) {
              _formKey.currentState?.validate();
              validateSubmitButton();
              _formData['bankName'] = value;
            },
            controller: _bankNameController,
          ),
          AppTextFormField(
            hintText: 'Digite o número da conta bancária',
            labelText: 'Número da conta bancária',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            onSaved: (bankAccountNumber) =>
                _formData['bankAccountNumber'] = bankAccountNumber ?? '',
            onChanged: (value) {
              _formKey.currentState?.validate();
              validateSubmitButton();
              _formData['bankAccountNumber'] = value;
            },
            controller: _bankAcountNumberController,
          ),
          AppTextFormField(
            hintText: 'Digite o IBAN',
            labelText: 'IBAN',
            helperText: 'Color IBAN sem os pontos',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            onSaved: (iban) => _formData['iban'] = iban ?? '',
            onChanged: (value) {
              _formKey.currentState?.validate();
              validateSubmitButton();
              _formData['iban'] = value;
            },
            controller: _bankIBANController,
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
            height: 10,
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
          child: Text(
            'Entrar',
            style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    children: [
                      _form(),
                      const SizedBox(
                        height: 60,
                      ),
                      _footerSection()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
