import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/screens/auth/sign-in.dart';
import 'package:reis_imovel_app/screens/company/tabs_screen.dart';
import 'package:reis_imovel_app/screens/onboarding_screen.dart';
import 'package:reis_imovel_app/screens/tabs_screen.dart';

class AuthOrHomeScreen extends StatelessWidget {
  const AuthOrHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: true);

    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          return const Center(child: AppText('Ocorreu um erro!'));
        } else {
          if (auth.isAuth) {
            if (auth.roles?.contains('ROLE_COMPANY') ?? false) {
              return const TabsScreenCompany();
            } else if (auth.roles?.contains('ROLE_USER') ?? false) {
              return const TabsScreen();
            } else {
              print('STATUS');
              return const SignInScreen();
            }
          } else {
            print('STATUS****');
            return const SignInScreen();
          }
        }
      },
    );
  }
}
