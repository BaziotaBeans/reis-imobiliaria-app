import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/app_text_form_field.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isEnable = false;

  final Map<String, String> _authData = {
    'userName': '',
    'password': '',
  };

  bool _isLoading = false;

  bool isObscure = true;

  void validateSubmitButton() {
    bool isValid = true;

    isValid = _userNameController.text.isNotEmpty &&
        _userNameController.text.length >= 5 &&
        _passwordController.text.isNotEmpty &&
        _passwordController.text.length >= 5;

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
    Auth auth = Provider.of(context, listen: false);

    try {
      await auth.login(
        _authData['userName']!,
        _authData['password']!,
      );

      print('entrei');
    } on Exception catch (error) {
      print('ERRO');
      print(error);
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Por favor verifique se os seus dados são válidos.');

      print(error);
    }

    setState(() => _isLoading = false);
  }

  Widget _forgetPasswordWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AppText(
          'Esqueceu  a senha?',
          color: Color(0xFF74778B),
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        const SizedBox(
          width: 4,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.SIGN_IN);
          },
          child: const AppText(
            'Clique aqui!',
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xff687553),
          ),
        )
      ],
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextFormField(
            hintText: 'Digite o sue nome do usuário',
            labelText: 'Nome do usuário',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            onSaved: (userName) => _authData['userName'] = userName ?? '',
            onChanged: (value) {
              _formKey.currentState?.validate();
              validateSubmitButton();
            },
            controller: _userNameController,
            validator: (userN) {
              final uName = userN ?? '';
              if (uName.isEmpty || uName.length < 5) {
                return 'Informe um nome de usuário válido';
              }
              return null;
            },
          ),
          AppTextFormField(
            hintText: 'Digite a sua senha',
            labelText: 'Senha',
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            onSaved: (password) => _authData['password'] = password ?? '',
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
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Button(
              title: 'Entrar',
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
          'Não tem uma conta?',
          style: TextStyle(
            color: Color(0xFF74778B),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.SELECT_USER_TYPE);
          },
          child: const AppText(
            'Inscreva-se',
            color: Color(0xff687553),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        )
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 348,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/announcement.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                color: const Color(0xff687553),
                width: 80,
                height: 80,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/reis-imovel-logo.svg',
                    semanticsLabel: 'Logo',
                    height: 38,
                    width: 46,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _form(),
                            const SizedBox(
                              height: 40,
                            ),
                            // _forgetPasswordWidget()
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _footerSection()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
