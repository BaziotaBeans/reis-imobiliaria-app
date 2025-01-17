import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/screens/auth/login_screen.dart';
import 'package:reis_imovel_app/screens/company/tabs_screen.dart';
import 'package:reis_imovel_app/screens/tabs_screen.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class AuthOrHomeScreen extends StatelessWidget {
  const AuthOrHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: true);

    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        debugPrint(
            'AuthOrHomeScreen Future state: ${snapshot.connectionState}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }
        if (snapshot.error != null) {
          debugPrint('Erro no FutureBuilder: ${snapshot.error}');
          return const Center(child: AppText('Ocorreu um erro!'));
        }
        if (auth.isAuth) {
          if (auth.roles?.contains('ROLE_COMPANY') ?? false) {
            return const TabsScreenCompany();
          }
          if (auth.roles?.contains('ROLE_USER') ?? false) {
            return const TabsScreen();
          }
        }
        return const LoginScreen();
      },
    );
  }
}
