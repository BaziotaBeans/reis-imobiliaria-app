import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_form_field.dart';
import 'package:reis_imovel_app/screens/auth/components/subtitle_form.dart';
import 'package:reis_imovel_app/screens/auth/components/title_form.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class FirstPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const FirstPage({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool isObscurePassword = true;
  bool isObscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleForm(title: 'Dados de Acesso'),
            const SubtitleForm(
                description:
                    'Preencha os dados para ter o controle de acesso.'),
            const SizedBox(height: 44),
            CustomFormField(
              controller: widget.usernameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              labelText: 'Nome de usuário',
              hintText: 'Digite o nome do usuário',
              helperText:
                  'Nome de usuário deve ter no minímo 5 caracteres e no máximo 20 caracteres',
              validator: userNameValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              labelText: 'E-mail',
              hintText: 'Digite o email',
              validator: emailValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.passwordController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              labelText: 'Senha',
              obscureText: isObscurePassword,
              maxLines: 1,
              hintText: 'Digite a senha',
              validator: passwordValidator.call,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscurePassword = !isObscurePassword;
                    });
                  },
                  icon: Icon(
                    isObscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.confirmPasswordController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              labelText: 'Confirmar Senha',
              hintText: 'Digite o confirmar senha',
              obscureText: isObscureConfirmPassword,
              maxLines: 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Confirmação de senha é obrigatória';
                }
                if (value != widget.passwordController.text) {
                  debugPrint('#####');
                  debugPrint(widget.passwordController.text);
                  return 'As senhas não coincidem';
                }
                return null;
              },
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                  onPressed: () {
                    setState(
                      () {
                        isObscureConfirmPassword = !isObscureConfirmPassword;
                      },
                    );
                  },
                  icon: Icon(
                    isObscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
