import 'package:flutter/material.dart';
import 'package:reis_imovel_app/screens/auth/components/user_type_selector.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class SelectUserTypeScreen extends StatefulWidget {
  const SelectUserTypeScreen({super.key});

  @override
  State<SelectUserTypeScreen> createState() => _SelectUserTypeScreenState();
}

class _SelectUserTypeScreenState extends State<SelectUserTypeScreen> {
  String _selectedUserType = 'company';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bem vindo!',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Text(
                  'Selecione o tipo de usuário que pretende criar conta.'),
              const SizedBox(height: 40),
              UserTypeSelector(
                onProfileSelected: (String selectedProfile) {
                  // Aqui você pode fazer algo com o perfil selecionado
                  print('Perfil selecionado: $selectedProfile');
                  setState(() {
                    _selectedUserType = selectedProfile;
                  });
                  // Exemplo: navegar para outra tela, salvar a seleção, etc.
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_selectedUserType == 'normal') {
                    Navigator.pushNamed(
                        context, AppRoutes.SIGNUP_NORMAL_USER_SCREEN);
                  } else {
                    Navigator.pushNamed(
                        context, AppRoutes.SIGNUP_PROPERTY_USER_SCREEN);
                  }
                },
                child: const Text("Continuar"),
              ),
              const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Você já possui uma conta?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.SIGN_IN);
                    },
                    child: const Text("Entrar"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
