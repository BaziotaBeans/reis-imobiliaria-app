import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/components/header.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';

class PaymentMethodTransferScreen extends StatelessWidget {
  const PaymentMethodTransferScreen({super.key});

  Widget _imageUpload() {
    return Container(
      width: double.infinity,
      // decoration: ShapeDecoration(
      //   color: Colors.white,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      // ),
      child: DottedBorder(
        color: Colors.black.withOpacity(0.15000000596046448),
        strokeWidth: 2,
        dashPattern: [10, 6],
        radius: const Radius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'hfdfdfdfdfdfdf.jpg',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              Icon(Icons.upload)
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardPrimary(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Pague por transferência',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              'Adicione o comprovativo de pagamento, no campo de upload abaixo.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0x993C3C43),
                  fontSize: 16,
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.w400,
                  height: 1.5),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          _imageUpload(),
          const SizedBox(
            height: 24,
          ),
          Button(
            title: 'Adicionar',
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PAYMENT_SUCCESS_SCREEN);
            },
            variant: ButtonVariant.primary,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                title: 'Pagamento Transferência',
                onPressed: () {},
              ),
              _cardPrimary(context)
            ],
          ),
        ),
      ),
    );
  }
}
