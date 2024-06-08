import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/models/Auh.dart';
import 'package:reis_imovel_app/screens/auth/sign-in.dart';
import 'package:reis_imovel_app/screens/company/tabs_screen.dart';
import 'package:reis_imovel_app/screens/onboarding_screen.dart';
import 'package:reis_imovel_app/screens/tabs_screen.dart';

class AuthOrHomeScreen extends StatelessWidget {
  const AuthOrHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);

    print(auth.isAuth && auth.roles!.contains('ROLE_COMPANY'));

    final Future<String> _calculation = Future<String>.delayed(
      const Duration(seconds: 2),
      () => 'Data Loaded',
    );

    return FutureBuilder(
      future: _calculation, //auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          if (auth.isAuth && auth.roles!.contains('ROLE_USER')) {
            return const TabsScreen();
          } else if (auth.isAuth && auth.roles!.contains('ROLE_COMPANY')) {
            return const TabsScreenCompany();
          } else {
            return const SignInScreen();
            // return const OnboardingScreen();
          }

          // return auth.isAuth ? auth.roles!.contains('ROLE_USER') ? const TabsScreen() : const SignInScreen();
        }
      },
    );
  }
}
