import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/header.dart';
import 'package:reis_imovel_app/components/reference_code_clip_boad.dart';
import 'package:reis_imovel_app/dto/Order.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class OrderReferenceScreen extends StatefulWidget {
  const OrderReferenceScreen({super.key});

  @override
  State<OrderReferenceScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OrderReferenceScreen> {
  Widget _boxExpress() {
    return Center(
      child: Image.asset(
        'assets/images/multicaixa-express.png',
        fit: BoxFit.cover,
        width: 83,
      ),
    );
  }

  Widget _timeLeft(Order data) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'O tempo para você pagar acaba em:',
          color: Color(0xaf3c3c43),
          fontSize: 16,
        ),
        SizedBox(height: 10),
        // CountdownTimerWidget(
        //   expiryDate: DateTime.parse(
        //     formattedExpirationDate,
        //   ),
        //   diffBetweenDate: diffBetweenDate,
        // ),
        SizedBox(height: 10),
        AppText(
          'O pedido será excluído após o tempo para efectuar o pagamento terminar.',
          color: Color(0xaf3c3c43),
          fontSize: 16,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _extraInfo(Order data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppText(
              'Entidade',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              data.entidade,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppText(
              'Valor total',
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            AppText(
              formatPrice(data.totalValue),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppText(
              'Tipo Item',
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            AppText(
              AppUtils.getPropertyTypeLabel(data.property.fkPropertyType),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      ],
    );
  }

  Widget _content(Order data) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppText(
              'Pague com Referência',
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: secondaryColor,
            ),
            const SizedBox(
              height: 16,
            ),
            const AppText(
              'Copie o código abaixo para pagar via Referencia em qualquer banco habilitado.',
              color: secondaryText,
              maxLines: 4,
              textAlign: TextAlign.center,
              softWrap: true,
              fontSize: 14,
              height: 1.5,
            ),
            const SizedBox(height: 32),
            ReferenceCodeClipBoard(code: data.reference),
            const SizedBox(height: 32),
            _timeLeft(data),
            const SizedBox(height: 32),
            _extraInfo(data),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Order data = ModalRoute.of(context)?.settings.arguments as Order;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                title: 'Pagamento Referência',
                onPressed: () {},
              ),
              _boxExpress(),
              const SizedBox(height: 40),
              if (data != null) _content(data),
            ],
          ),
        ),
      ),
    );
  }
}
