import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/components/new/dialog_widget.dart';
import 'package:reis_imovel_app/components/new/toast_widget.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/models/ContractList.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class AwaitingSignatureContractBox extends StatefulWidget {
  final Contract data;
  final Future<void> Function(BuildContext) onRefresh;

  const AwaitingSignatureContractBox({
    super.key,
    required this.data,
    required this.onRefresh,
  });

  @override
  State<AwaitingSignatureContractBox> createState() =>
      _AwaitingSignatureContractBoxState();
}

class _AwaitingSignatureContractBoxState
    extends State<AwaitingSignatureContractBox> {
  bool _isLoading = false;
  bool _isSigned = false; // Controle da animação de sucesso

  void _signContract() async {
    setState(() => _isLoading = true);

    try {
      String nameToSign = AppUtils.getFirstAndLastName(
          widget.data.property.companyEntity.user.fullName);

      // Pequeno atraso antes de chamar a assinatura para suavizar a experiência
      await Future.delayed(const Duration(milliseconds: 500));

      await Provider.of<ContractList>(
        context,
        listen: false,
      ).updateOwnerSignature(nameToSign, widget.data.pkContract);

      // Exibir animação de sucesso
      setState(() {
        _isSigned = true;
        _isLoading = false;
      });

      // Exibir mensagem de sucesso
      ToastWidget.showSuccessToast("Assinado com sucesso");

      // Aguardar um tempo antes de atualizar a interface
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
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: alertBoxColor,
        borderRadius: BorderRadius.circular(defaultBorderRadious),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                'Aguardando assinatura',
                color: whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SvgPicture.asset(
                "assets/icons/Alert.svg",
                height: 16,
                width: 16,
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          const Expanded(
            child: CustomText(
              'A assinatura do responsável do imóvel é obrigatória para a geração e confirmação do contrato. Após a geração, o imóvel será liberado para o locatário e o valor será transferido para o responsável do imóvel.',
              color: whiteColor,
              fontSize: 14,
              softWrap: true,
              maxLines: 6,
            ),
          ),
          const SizedBox(height: defaultPadding),

          // Se estiver carregando, exibe o loader
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: defaultPadding),
                child: SizedBox(
                  height: 28,
                  width: 28,
                  child: CircularProgressIndicator(color: whiteColor),
                ),
              ),
            )

          // Se já assinou, exibe um check animado
          else if (_isSigned)
            Center(
              child: AnimatedOpacity(
                opacity: _isSigned ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    const Icon(Icons.check_circle,
                        size: 40, color: Colors.green),
                    const SizedBox(height: 5),
                    const CustomText(
                      'Contrato assinado!',
                      color: whiteColor,
                      fontSize: 16,
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
              text: 'Assinar Contrato',
              variant: ButtonVariant.tertiary,
              forcedTextColor: alertBoxColor,
              onPressed: _signContract,
            ),
        ],
      ),
    );
  }
}
