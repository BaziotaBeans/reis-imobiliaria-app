import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/new/dialog_widget.dart';
import 'package:reis_imovel_app/components/new/toast_widget.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/models/ContractList.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class SignatureContractView extends StatefulWidget {
  final Contract data;
  final Future<void> Function(BuildContext) onRefresh;

  const SignatureContractView({
    super.key,
    required this.data,
    required this.onRefresh,
  });

  @override
  State<SignatureContractView> createState() => _SignatureContractViewState();
}

class _SignatureContractViewState extends State<SignatureContractView> {
  bool _isLoading = false;

  void _signContract() async {
    setState(() => _isLoading = true);

    try {
      String nameToSign =
          AppUtils.getFirstAndLastName(widget.data.user.fullName);

      await Provider.of<ContractList>(
        context,
        listen: false,
      ).updateCustomerSignature(nameToSign, widget.data.pkContract);

      ToastWidget.showSuccessToast("Assinado com sucesso");

      if (mounted) {
        await widget.onRefresh(context);
      }
    } catch (e) {
      debugPrint('Error: ${e.toString()}');

      if (mounted) {
        await DialogWidget.showErrorDialog(
          context: context,
          title: "Ocorreu um erro!",
          message: "Ocorreu ao realizar a assinatura digital.",
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      width: double.infinity,
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 66),
          const Center(
            child: Image(
              image: AssetImage("assets/images/Send Hand.png"),
              fit: BoxFit.cover,
              width: 90,
            ),
          ),
          const SizedBox(height: defaultPadding),
          const Center(
            child: CustomText(
              'Para finalizar, basta assinar o contracto!',
              color: secondaryColor,
              fontSize: 24,
              softWrap: true,
              maxLines: 2,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: defaultPadding),
          const Center(
            child: CustomText(
              'Agora você pode assinar seu documento referente ao contracto, do aluguel do imóvel.',
              softWrap: true,
              maxLines: 2,
              color: secondaryText,
              fontSize: 14,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 56),
          Center(
            child: Text(
              AppUtils.getFirstAndLastName(widget.data.user.fullName),
              style: const TextStyle(
                fontSize: 40,
                fontFamily: 'Sign Painter',
                fontWeight: FontWeight.w500,
                color: secondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 2),
          const Center(
            child: Text(
              '------------------------------------',
              style: TextStyle(
                fontSize: 14,
                color: secondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Center(
            child: CustomText(
              'Ao clicar no botão abaixo, será emitido uma assinatura digital relativo ao contracto.',
              color: secondaryText,
              fontSize: 14,
              softWrap: true,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 80),
          if (_isLoading)
            const Center(child: CircularProgressIndicator(color: primaryColor))
          else
            CustomButton(
              text: 'Confirmar e finalizar a assinatura',
              suffixIcon: Icons.check_rounded,
              onPressed: _signContract,
            )
        ],
      ),
    );
  }
}
