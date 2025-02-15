import 'dart:async';
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
  bool _isSigned = false; // Controle para a animação de sucesso

  void _signContract() async {
    setState(() => _isLoading = true);

    try {
      String nameToSign =
          AppUtils.getFirstAndLastName(widget.data.user.fullName);

      // Adicionando um pequeno delay antes da assinatura para melhorar UX
      await Future.delayed(const Duration(milliseconds: 600));

      await Provider.of<ContractList>(
        context,
        listen: false,
      ).updateCustomerSignature(nameToSign, widget.data.pkContract);

      // Exibir feedback visual com animação de sucesso
      setState(() {
        _isSigned = true;
        _isLoading = false;
      });

      // Exibir toast de sucesso
      ToastWidget.showSuccessToast("Assinado com sucesso");

      // Pequeno delay antes de atualizar a tela para que o usuário veja o efeito
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        await widget.onRefresh(context);
      }
    } catch (e) {
      debugPrint('Error: ${e.toString()}');

      if (mounted) {
        await DialogWidget.showErrorDialog(
          context: context,
          title: "Ocorreu um erro!",
          message: "Ocorreu um erro ao realizar a assinatura digital.",
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
              'Para finalizar, basta assinar o contrato!',
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
              'Agora você pode assinar seu documento referente ao contrato de aluguel do imóvel.',
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
              'Ao clicar no botão abaixo, será emitida uma assinatura digital relativa ao contrato.',
              color: secondaryText,
              fontSize: 14,
              softWrap: true,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 80),

          // Se estiver carregando, exibe o loader
          if (_isLoading)
            const Center(child: CircularProgressIndicator(color: primaryColor))

          // Se já assinou, exibe um check animado
          else if (_isSigned)
            Center(
              child: AnimatedOpacity(
                opacity: _isSigned ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: const Column(
                  children: [
                    Icon(Icons.check_circle, size: 80, color: Colors.green),
                    SizedBox(height: 10),
                    CustomText(
                      'Contrato assinado com sucesso!',
                      color: secondaryColor,
                      fontSize: 18,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            )

          // Botão normal para assinar
          else
            CustomButton(
              text: 'Confirmar e finalizar a assinatura',
              suffixIcon: Icons.check_rounded,
              onPressed: _signContract,
            ),
        ],
      ),
    );
  }
}
