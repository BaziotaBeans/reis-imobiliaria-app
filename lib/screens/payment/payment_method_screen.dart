import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/new/custom_back_button.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/components/new/dialog_widget.dart';
import 'package:reis_imovel_app/components/new/toast_widget.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/enums.dart';
import 'package:reis_imovel_app/models/OrderList.dart';
import 'package:reis_imovel_app/screens/payment/components/payment_method_options.dart';
import 'package:reis_imovel_app/screens/payment/components/payment_property_detail.dart';
import 'package:reis_imovel_app/screens/payment/components/payment_security_info.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  PaymentMethodOptionsEnum? _paymentMethod = PaymentMethodOptionsEnum.reference;

  bool _isLoading = false;

  void onSelectPaymentMethod(PaymentMethodOptionsEnum? value) {
    setState(() {
      _paymentMethod = value;
    });
  }

  void _submitReference(PropertyResult data) async {
    setState(() => _isLoading = true);

    final totalValue = AppUtils.getTotalValueToPaidInProperty(data);

    try {
      if (_paymentMethod?.name == PaymentMethodOptionsEnum.reference.name) {
        await Provider.of<OrderList>(
          context,
          listen: false,
        ).createOrder(
            data.property.pkProperty, totalValue, PaymentMethod.REFERENCE.name);

        await Provider.of<OrderList>(
          context,
          listen: false,
        ).loadLastOrder();

        ToastWidget.showSuccessToast("Pedido criado com sucesso");

        Navigator.of(context).pushNamed(
          AppRoutes.PAYMENT_METHOD_REFERENCE_SCREEN,
        );

        return;
      }

      await Provider.of<OrderList>(
        context,
        listen: false,
      ).createOrder(data.property.pkProperty, totalValue,
          PaymentMethod.MULTICAIXA_EXPRESS.name);

      await Provider.of<OrderList>(
        context,
        listen: false,
      ).loadLastOrder();

      ToastWidget.showSuccessToast("Pedido criado com sucesso");

      Navigator.of(context).pushNamed(
        AppRoutes.PAYMENT_MULTICAIXA_EXPRESS_SCREEN,
      );
    } catch (e) {
      debugPrint('Error: ${e.toString()}');

      if (mounted) {
        await DialogWidget.showErrorDialog(
          context: context,
          title: 'Ocorreu um erro!',
          message: 'Ocorreu um erro ao criar pedido.',
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    PropertyResult data =
        ModalRoute.of(context)?.settings.arguments as PropertyResult;

    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(defaultPadding),
        height: 150,
        child: Column(
          children: [
            if (_isLoading)
              const Center(
                  child: CircularProgressIndicator(color: primaryColor))
            else
              CustomButton(
                text: 'Continuar',
                onPressed: () {
                  _submitReference(data);
                  // return;
                  // if (_paymentMethod == PaymentMethodOptionsEnum.reference) {
                  //   _submitReference(data);
                  //   return;
                  // }
                  // Navigator.of(context).pushNamed(
                  //   AppRoutes.PAYMENT_MULTICAIXA_EXPRESS_SCREEN,
                  // );
                },
              ),
            const SizedBox(height: defaultPadding),
            const PaymentSecurityInfo(),
          ],
        ),
      ),
      appBar: AppBar(
        title: const CustomText(
          'Pagamento',
          color: secondaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        leading: const CustomBackButton(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          PaymentPropertyDetail(
            data: data,
          ),
          PaymentMethodOptions(
            onSelectPaymentMethod: onSelectPaymentMethod,
            selectedPaymentMethod: _paymentMethod,
          ),
        ],
      ),
    );
  }
}
