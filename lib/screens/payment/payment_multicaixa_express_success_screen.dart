import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/components/new/snackbar_bar_widget.dart';
import 'package:reis_imovel_app/dto/Order.dart';
import 'package:reis_imovel_app/helper/payment_pdf_generator.dart';
import 'package:reis_imovel_app/models/PaymentList.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class PaymentMulticaixaExpressSuccess extends StatefulWidget {
  const PaymentMulticaixaExpressSuccess({super.key});

  @override
  State<PaymentMulticaixaExpressSuccess> createState() =>
      _PaymentMulticaixaExpressSuccessState();
}

class _PaymentMulticaixaExpressSuccessState
    extends State<PaymentMulticaixaExpressSuccess> {
  late ConfettiController _confettiController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 5),
    );

    // Start the confetti animation when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confettiController.play();
      _loadPaymentData();
    });
  }

  Future<void> _loadPaymentData() async {
    final args = ModalRoute.of(context)?.settings.arguments as Order?;

    if (args != null) {
      setState(() => _isLoading = true);

      try {
        await Provider.of<PaymentList>(
          context,
          listen: false,
        ).loadPaymentByReference(args.reference);
      } catch (e) {
        debugPrint('Error loading payment: ${e.toString()}');
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  dynamic _formatDateTime(String dateTimeStr) {
    final dateTime = DateTime.parse(dateTimeStr);
    final date = DateFormat('dd MMM, yyyy').format(dateTime);
    final time = DateFormat('hh:mm a').format(dateTime);
    return {'date': date, 'time': time};
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Widget _builtPaimentTag() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: successColor.withOpacity(0.1),
      ),
      child: const CustomText(
        'Pago',
        fontWeight: FontWeight.w500,
        color: successColor,
        fontSize: 12,
      ),
    );
  }

  Future<void> _handleDownloadPdf() async {
    final payment =
        Provider.of<PaymentList>(context, listen: false).currentPayment;

    if (payment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Não foi possível gerar o PDF. Dados do pagamento não encontrados.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Mostrar loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        },
      );

      // Gerar e baixar PDF
      await PaymentPdfGenerator.generateAndDownloadPdf(payment);

      // Fechar loading
      Navigator.of(context).pop();

      // Mostrar mensagem de sucesso
      if (mounted) {
        SnackBarWidget.showSuccess(
          context: context,
          message: 'PDF gerado com sucesso!',
        );
      }
    } catch (e) {
      // Fechar loading
      Navigator.of(context).pop();

      // Mostrar erro
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao gerar PDF: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final payment = Provider.of<PaymentList>(context).currentPayment;

    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final dateTime =
        _formatDateTime(payment?.createdAt ?? DateTime.now().toString());

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/icons/Success.svg",
                  height: 64,
                  width: 64,
                ),
              ),
              const SizedBox(height: defaultPadding),
              const CustomText(
                'Pagamento realizado com sucesso!',
                color: secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF7FAFC),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          formatPrice(payment?.totalValue ?? 0),
                          color: secondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        _builtPaimentTag()
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(
                      height: 1,
                      color: blackColor20,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CustomText(
                          'Nº Referência',
                          color: secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        CustomText(
                          payment?.reference ?? '-',
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CustomText(
                          'Método de pagamento',
                          color: secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        CustomText(
                          AppUtils.getPaymentMethodLabel(
                              payment?.paymentMethod ?? '-'),
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CustomText(
                          'Tipo Item',
                          color: secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        CustomText(
                          AppUtils.getPropertyType(payment?.property) ?? '-',
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CustomText(
                          'Data',
                          color: secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        CustomText(
                          dateTime['date'],
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CustomText(
                          'Hora',
                          color: secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        CustomText(
                          dateTime['time'],
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CustomText(
                          'Responsável',
                          color: secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        CustomText(
                          AppUtils.getFirstAndLastName(
                              payment?.user.fullName ?? ''),
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomButton(
                text: 'Baixar PDF',
                variant: ButtonVariant.outline,
                prefixIcon: Icons.download_sharp,
                forcedBackgroundColor: Colors.white,
                onPressed: _handleDownloadPdf,
              ),
              const SizedBox(height: defaultPadding),
              CustomButton(
                text: 'Ir para home',
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.Home);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
