import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/user_update_form.dart';
import 'package:reis_imovel_app/enums.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _profileBox() {
    return Container(
      width: 80,
      height: 80,
      decoration: ShapeDecoration(
        color: const Color(0xFFB1B1B1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: const Center(
        child: FaIcon(FontAwesomeIcons.user, size: 32),
      ),
    );
  }

  Widget _displayProfileInfo(String name, String email) {
    return Column(
      children: [
        _profileBox(),
        const SizedBox(
          height: 16,
        ),
        AppText(
          name,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(
          height: 10,
        ),
        AppText(
          email,
          textAlign: TextAlign.center,
          color: const Color(0xFF6A7380),
          fontSize: 14,
        )
      ],
    );
  }

  FaIcon getItemBoxProfileOptionIcon(ProfileOptionsEnum type) {
    switch (type) {
      case ProfileOptionsEnum.edit:
        return const FaIcon(
          FontAwesomeIcons.pen,
          size: 16,
          color: Color(0xFFFF9B00),
        );
      case ProfileOptionsEnum.change_password:
        return const FaIcon(
          FontAwesomeIcons.lock,
          size: 16,
          color: Color(0xFF4CAF50),
        );
      case ProfileOptionsEnum.oder:
        return const FaIcon(
          FontAwesomeIcons.moneyCheck,
          size: 16,
          color: Color.fromARGB(255, 202, 46, 147),
        );
      case ProfileOptionsEnum.contract:
        return const FaIcon(
          FontAwesomeIcons.fileInvoice,
          size: 16,
          color: Color.fromARGB(255, 76, 142, 175),
        );
      case ProfileOptionsEnum.policies_and_privacy:
        return const FaIcon(
          FontAwesomeIcons.shield,
          size: 16,
          color: Color(0xFF9E9E9E),
        );
      case ProfileOptionsEnum.exit:
        return const FaIcon(
          FontAwesomeIcons.rightFromBracket,
          size: 16,
          color: Color(0xFFF44236),
        );
    }
  }

  Color getBoxIconColor(ProfileOptionsEnum type) {
    switch (type) {
      case ProfileOptionsEnum.edit:
        return const Color(0x2DFF9800);
      case ProfileOptionsEnum.change_password:
        return const Color(0x2D649A66);
      case ProfileOptionsEnum.oder:
        return const Color.fromARGB(44, 152, 100, 154);
      case ProfileOptionsEnum.contract:
        return const Color.fromARGB(44, 100, 136, 154);
      case ProfileOptionsEnum.policies_and_privacy:
        return const Color(0xFFECECEC);
      case ProfileOptionsEnum.exit:
        return const Color(0xFFECECEC);
    }
  }

  Widget _boxIcon(ProfileOptionsEnum type) {
    return Container(
      width: 32,
      height: 32,
      decoration: ShapeDecoration(
        color: getBoxIconColor(type),
        shape: const OvalBorder(),
      ),
      child: Center(
        child: getItemBoxProfileOptionIcon(type),
      ),
    );
  }

  void _showUserUpdateForm(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const Wrap(
          children: [
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: UserUpdateForm(),
            )
          ],
        );
      },
    );
  }

  void handleNavigateItemBoxProfileOption(
      BuildContext context, ProfileOptionsEnum type) {
    if (type == ProfileOptionsEnum.edit) {
      Navigator.of(context).pushNamed(AppRoutes.USER_UPDATE_FORM_SCREEN);
    } else if (type == ProfileOptionsEnum.contract) {
      Navigator.of(context).pushNamed(
        AppRoutes.CONTRACT_LIST,
      );
    } else if (type == ProfileOptionsEnum.oder) {
      Navigator.of(context).pushNamed(
        AppRoutes.ORDER_REFERENCE_LIST_SCREEN,
      );
    } else if (type == ProfileOptionsEnum.exit) {
      showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Fazer logout'),
          content: const Text('Tem certeza?'),
          actions: [
            TextButton(
              child: const Text('Não'),
              onPressed: () => Navigator.of(ctx).pop(false),
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () => Navigator.of(ctx).pop(true),
            ),
          ],
        ),
      ).then((value) {
        if (value ?? false) {
          Provider.of<Auth>(
            context,
            listen: false,
          ).logout();
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.Home,
          );
        }
      });
    }
  }

  Widget _itemBoxProfileOption(
      BuildContext context, ProfileOptionsEnum type, String title) {
    return InkWell(
      onTap: () {
        handleNavigateItemBoxProfileOption(context, type);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _boxIcon(type),
              const SizedBox(
                width: 14,
              ),
              AppText(
                title,
                textAlign: TextAlign.center,
                color: const Color(0xFF6A7380),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const FaIcon(
            FontAwesomeIcons.chevronRight,
            size: 16,
            color: Color(0xFF6A7380),
          ),
        ],
      ),
    );
  }

  Widget _separator() {
    return const Column(
      children: [
        SizedBox(
          height: 14,
        ),
        Divider(height: 1, color: Color(0xFFEFEFEF)),
        SizedBox(
          height: 14,
        ),
      ],
    );
  }

  Widget _boxtProfileOption(BuildContext context, bool isClient) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _itemBoxProfileOption(
              context, ProfileOptionsEnum.edit, 'Dados do perfil'),
          _separator(),
          _itemBoxProfileOption(
              context, ProfileOptionsEnum.change_password, 'Mudar senha'),
          if (isClient) _separator(),
          if (isClient)
            _itemBoxProfileOption(context, ProfileOptionsEnum.oder, 'Pedidos'),
          if (isClient) _separator(),
          if (isClient)
            _itemBoxProfileOption(
                context, ProfileOptionsEnum.contract, 'Contractos'),
          _separator(),
          _itemBoxProfileOption(
              context,
              ProfileOptionsEnum.policies_and_privacy,
              'Política de Privacidade'),
        ],
      ),
    );
  }

  Widget _boxExitProfileOption(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: _itemBoxProfileOption(context, ProfileOptionsEnum.exit, 'Sair'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context, listen: false);

    bool isClient = auth.roles?.contains("ROLE_USER") == true;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 24,
            ),
            child: Column(
              children: [
                const Center(
                  child: AppText(
                    'Perfil',
                    textAlign: TextAlign.center,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 40),
                _displayProfileInfo(
                    auth.fullName ?? 'Sem nome', auth.email ?? 'Sem email'),
                const SizedBox(
                  height: 40,
                ),
                _boxtProfileOption(context, isClient),
                const SizedBox(height: 60),
                _boxExitProfileOption(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
