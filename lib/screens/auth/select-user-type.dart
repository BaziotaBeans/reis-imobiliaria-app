import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/auth/select-user-type-header.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';

class SelectUserTypeScreen extends StatefulWidget {
  const SelectUserTypeScreen({super.key});

  @override
  State<SelectUserTypeScreen> createState() => _SelectUserTypeState();
}

class _SelectUserTypeState extends State<SelectUserTypeScreen> {
  String userType = 'client';

  Widget _userTypeBox(String type) {
    double screenWidth = MediaQuery.of(context).size.width;

    double containerWidth =
        ((screenWidth / 2) - AppConstants.screenHorizontalPadding) -
            (AppConstants.selectUserTypeGapBetweenBox / 2);

    return GestureDetector(
      onTap: () {
        setState(() {
          userType = type;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: containerWidth,
            height: 115,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 2,
                  color: type == userType
                      ? const Color(0xff687553)
                      : const Color(0xFFE2E2E2),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                if (type == userType)
                  Positioned(
                    top: -10,
                    left: (containerWidth / 2) - 14,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const ShapeDecoration(
                        color: Color(0xff687553),
                        shape: OvalBorder(),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 20,
                  width: containerWidth,
                  child: Icon(
                    Icons.person,
                    size: 64,
                    color: type == userType
                        ? const Color(0xff687553)
                        : const Color(0xFFE2E2E2),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          AppText(
            type == 'client' ? 'Cliente' : 'Agente Imobiliária',
            textAlign: TextAlign.center,
            color: type == userType
                ? const Color(0xff687553)
                : const Color.fromARGB(255, 194, 193, 193),
            fontSize: 14,
            fontWeight: FontWeight.w700,
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
        const AppText(
          'Você já possui uma conta?',
          color: Color(0xFF74778B),
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
            'Entrar',
            color: Color(0xff687553),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _userTypeOption() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _userTypeBox('client'),
          const SizedBox(width: AppConstants.selectUserTypeGapBetweenBox),
          _userTypeBox('company')
        ],
      ),
    );
  }

  void _submit() {
    if (userType == 'client') {
      Navigator.of(context).pushNamed(
        AppRoutes.SIGN_UP_CLIENT,
        // arguments: UserTypeEnum.client,
      );
    } else {
      Navigator.of(context).pushNamed(
        AppRoutes.SIGN_UP_COMPANY,
        // arguments: UserTypeEnum.company,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 62),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SelectUserTypeHeader(),
                _userTypeOption(),
                const SizedBox(
                  height: 20,
                ),
                Button(
                  title: 'Continuar',
                  onPressed: _submit,
                  variant: ButtonVariant.primary,
                ),
              ],
            ),
            _footerSection()
          ],
        ),
      ),
    );
  }
}
