import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/new/custom_back_button.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/components/new/dialog_widget.dart';
import 'package:reis_imovel_app/components/new/snackbar_bar_widget.dart';
import 'package:reis_imovel_app/components/new/toast_widget.dart';
import 'package:reis_imovel_app/dto/Order.dart';
import 'package:reis_imovel_app/enums.dart';
import 'package:reis_imovel_app/models/OrderList.dart';
import 'package:reis_imovel_app/models/PaymentList.dart';
import 'package:reis_imovel_app/screens/payment/components/payment_detail.dart';
import 'package:reis_imovel_app/screens/payment/components/payment_footer.dart';
import 'package:reis_imovel_app/screens/payment/components/payment_multicaixa_express_box.dart';
import 'package:reis_imovel_app/screens/payment/components/payment_multicaixa_express_error_box.dart';
import 'package:reis_imovel_app/screens/payment/components/payment_multicaixa_express_info.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class PaymentMulticaixaExpressScreen extends StatefulWidget {
  const PaymentMulticaixaExpressScreen({super.key});

  @override
  State<PaymentMulticaixaExpressScreen> createState() =>
      _PaymentMulticaixaExpressScreenState();
}

class _PaymentMulticaixaExpressScreenState
    extends State<PaymentMulticaixaExpressScreen> {
  Future? loadLastOrderFuture;

  bool _isExpired = false;

  bool _isValid = false;

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController phoneNumberController = TextEditingController();

  void _handleExpiration() {
    setState(() {
      _isExpired = true;
    });
    // Aqui você pode adicionar qualquer lógica adicional que precise ser executada quando o tempo expirar
  }

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

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  void _submitPayment(Order data) async {
    setState(() => _isLoading = true);

    try {
      await Provider.of<PaymentList>(
        context,
        listen: false,
      ).createPayment(data.reference, data.totalValue,
          data.paymentMethod ?? PaymentMethod.MULTICAIXA_EXPRESS.name);

      ToastWidget.showSuccessToast("Pagamento realizado com sucesso");

      Navigator.of(context).pushNamed(
        AppRoutes.PAYMENT_MULTICAIXA_EXPRESS_SUCCESS_SCREEN,
        arguments: data,
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

  void _validateAndAdvance(Order? data) {
    bool? isValid = _formKey.currentState?.validate();

    debugPrint('####');
    // debugPrint('See ${phoneNumberController.text.isEmpty}');
    debugPrint('See ${_formKey.currentState?.validate()}');

    setState(() {
      _isValid = isValid ?? false;
    });

    if (_isValid && data != null) {
      _submitPayment(data);
    } else {
      SnackBarWidget.showError(
        context: context,
        message: 'Por favor, preencha todos os campos obrigatórios!',
      );
    }
  }

  void _handleValidateOnChange() {
    setState(() {
      _isValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Order? data = Provider.of<OrderList>(
      context,
      listen: false,
    ).currentOrder;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const CustomText(
          'Pagamento Multicaixa Express',
          color: secondaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        leading: const SizedBox(),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        backgroundColor: whiteColor,
        onRefresh: () => _refreshOrder(context),
        child: SafeArea(
          child: FutureBuilder(
            future: loadLastOrderFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(color: primaryColor));
              } else if (snapshot.error != null) {
                return const Center(child: CustomText('Ocorreu um erro!'));
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: expressColor,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, bottom: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const PaymentMulticaixaExpressInfo(),
                              const SizedBox(height: 24),
                              if (_isExpired)
                                const PaymentMulticaixaExpressErrorBox(
                                  errorType: PaymentMulticaixaErrorTypeEnum
                                      .expiredTime,
                                )
                              else
                                PaymentMulticaixaExpressBox(
                                  phoneNumberController: phoneNumberController,
                                  expirationDate: data?.expirationDate ?? '',
                                  onExpired: _handleExpiration,
                                  formKey: _formKey,
                                  onInputChange: _handleValidateOnChange,
                                ),
                              const SizedBox(height: defaultPadding),
                              PaymentDetail(
                                reference: data?.reference ?? '',
                                totalToPaid: data?.totalValue ?? 0.0,
                                typeItem:
                                    AppUtils.getPropertyType(data?.property) ??
                                        '',
                              ),
                              const SizedBox(height: defaultPadding),
                              if (_isLoading)
                                const Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                )
                              else
                                CustomButton(
                                  text: 'Finalizar compra',
                                  onPressed: _isValid
                                      ? () {
                                          _validateAndAdvance(data);
                                        }
                                      : null,
                                ),
                              const SizedBox(height: defaultPadding),
                            ],
                          ),
                        ),
                      ),
                      const PaymentFooter()
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
