import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text_form_field.dart';
import 'package:reis_imovel_app/components/auth/reset-password-header.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 62),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ResetPasswordHeader(),
                const SizedBox(
                  height: 42,
                ),
                AppTextFormField(
                  hintText: 'Senha actual',
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    _formKey.currentState?.validate();
                  },
                  validator: (value) {
                    return value!.isEmpty
                        ? 'Por favor, digite a senha'
                        : AppConstants.passwordRegex.hasMatch(value)
                            ? null
                            : 'Senha Inválida';
                  },
                  controller: currentPasswordController,
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
                        minimumSize:
                            MaterialStateProperty.all(const Size(48, 48)),
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
                AppTextFormField(
                  hintText: 'Nova senha',
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    _formKey.currentState?.validate();
                  },
                  validator: (value) {
                    return value!.isEmpty
                        ? 'Por favor, digite a senha'
                        : AppConstants.passwordRegex.hasMatch(value)
                            ? null
                            : 'Senha Inválida';
                  },
                  controller: currentPasswordController,
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
                        minimumSize:
                            MaterialStateProperty.all(const Size(48, 48)),
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
                AppTextFormField(
                  hintText: 'Confirmar nova senha',
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    _formKey.currentState?.validate();
                  },
                  validator: (value) {
                    return value!.isEmpty
                        ? 'Por favor, digite a senha'
                        : AppConstants.passwordRegex.hasMatch(value)
                            ? null
                            : 'Senha Inválida';
                  },
                  controller: currentPasswordController,
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
                        minimumSize:
                            MaterialStateProperty.all(const Size(48, 48)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
