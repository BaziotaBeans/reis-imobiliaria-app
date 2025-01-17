import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/config/system_message.dart';
import 'package:reis_imovel_app/enums.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class PaymentMulticaixaExpressErrorBox extends StatelessWidget {
  final PaymentMulticaixaErrorTypeEnum errorType;

  const PaymentMulticaixaExpressErrorBox({super.key, required this.errorType});

  String _getErrorTitleMessage() {
    if (errorType == PaymentMulticaixaErrorTypeEnum.expiredTime) {
      return payment_multicaixa_expired_time_error_title_message;
    }

    return payment_multicaixa_server_error_title_message;
  }

  String _getErrorContentMessage() {
    if (errorType == PaymentMulticaixaErrorTypeEnum.expiredTime) {
      return payment_multicaixa_expired_time_error_content_message;
    }

    return payment_multicaixa_server_error_content_message;
  }

  Widget _builtHeader() {
    return Container(
      color: customRedColor,
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: CustomText(
        _getErrorTitleMessage(),
        color: whiteColor,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: expressBoxColor,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _builtHeader(),
          Container(height: 8, width: double.infinity, color: whiteColor),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CustomText(
              _getErrorContentMessage(),
              color: secondaryColor,
              fontSize: 14,
              maxLines: 3,
              softWrap: true,
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.Home,
                );
              },
              child: const CustomText(
                'Voltar para home',
                // 'Tentar novamente',
                color: secondaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
