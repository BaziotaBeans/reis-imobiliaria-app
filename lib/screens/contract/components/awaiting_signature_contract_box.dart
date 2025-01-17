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

  void _signContract() async {
    setState(() => _isLoading = true);

    try {
      String nameToSign = AppUtils.getFirstAndLastName(
          widget.data.property.companyEntity.user.fullName);

      await Provider.of<ContractList>(
        context,
        listen: false,
      ).updateOwnerSignature(nameToSign, widget.data.pkContract);

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
              'A assinatura do responsável do imóvel é obrigatório para a geração e confirmação do contracto. após a geração do mesmo o imóvel será liberado para o locatório e o valor será transferido para o responsável do imóvel.',
              color: whiteColor,
              fontSize: 14,
              softWrap: true,
              maxLines: 6,
            ),
          ),
          const SizedBox(height: defaultPadding),
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
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomButton(
                  text: 'Assinar Contracto',
                  variant: ButtonVariant.tertiary,
                  forcedTextColor: alertBoxColor,
                  onPressed: _signContract,
                ),
                // const SizedBox(height: 10),
                // CustomButton(
                //   text: 'Cancelar Assinatura',
                //   variant: ButtonVariant.danger,
                //   onPressed: () {},
                // )
              ],
            )
        ],
      ),
    );
  }
}
