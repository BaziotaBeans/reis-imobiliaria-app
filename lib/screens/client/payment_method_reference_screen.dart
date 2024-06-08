import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/CountdownTimerWidget.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/components/header.dart';
import 'package:reis_imovel_app/components/reference_code_clip_boad.dart';
import 'package:reis_imovel_app/dto/Order.dart';
import 'package:reis_imovel_app/models/OrderList.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class PaymentMethodReferenceScreen extends StatefulWidget {
  const PaymentMethodReferenceScreen({super.key});

  @override
  State<PaymentMethodReferenceScreen> createState() =>
      _PaymentMethodReferenceScreenState();
}

class _PaymentMethodReferenceScreenState
    extends State<PaymentMethodReferenceScreen> {
  Future? loadLastOrderFuture;

  @override
  void initState() {
    super.initState();

    loadLastOrderFuture = Provider.of<OrderList>(
      context,
      listen: false,
    ).loadLastOrder();
  }

  Future<void> _refreshOrder(BuildContext context) async {
    setState(() {
      loadLastOrderFuture = Provider.of<OrderList>(
        context,
        listen: false,
      ).loadLastOrder();
    });
  }

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
    String formattedExpirationDate = data.expirationDate.replaceFirst('T', ' ');

    int diffBetweenDate =
        DateTime.parse(formattedExpirationDate).millisecondsSinceEpoch -
            DateTime.now().millisecondsSinceEpoch;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          'O tempo para você pagar acaba em:',
          color: Color(0xaf3c3c43),
          fontSize: 16,
        ),
        const SizedBox(height: 10),
        CountdownTimerWidget(
          expiryDate: DateTime.parse(
            formattedExpirationDate,
          ),
          diffBetweenDate: diffBetweenDate,
        ),
        const SizedBox(height: 10),
        const AppText(
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

  Widget _buttonGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Button(
          title: 'Ir para pedidos',
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              AppRoutes.ORDER_REFERENCE_LIST_SCREEN,
            );
          },
          variant: ButtonVariant.primary,
        ),
        const SizedBox(height: 16),
        Button(
          title: 'Ir para tela home',
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              AppRoutes.Home,
            );
          },
          variant: ButtonVariant.tertiary,
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
              color: Color(0xff3D3F33),
            ),
            const SizedBox(
              height: 16,
            ),
            const AppText(
              'Copie o código abaixo para pagar via Referencia em qualquer banco habilitado.',
              color: Color(0xaf3c3c43),
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
            const SizedBox(height: 32),
            _buttonGroup()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Order? data = Provider.of<OrderList>(
      context,
      listen: false,
    ).currentOrder;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: RefreshIndicator(
        onRefresh: () => _refreshOrder(context),
        child: SafeArea(
          child: FutureBuilder(
            future: loadLastOrderFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Enquanto os dados estão carregando, exibe um spinner
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.error != null) {
                return const Center(child: Text('Ocorreu um erro!'));
              } else {
                return SingleChildScrollView(
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
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
