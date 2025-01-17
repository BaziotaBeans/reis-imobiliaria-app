import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/screens/contract/components/awaiting_signature_contract_box.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class ContractContentSale extends StatelessWidget {
  final Contract data;
  final bool isClient;
  final Future<void> Function(Contract) onDownloadPdf;
  final Future<void> Function(BuildContext) onRefresh;

  const ContractContentSale({
    super.key,
    required this.data,
    required this.isClient,
    required this.onDownloadPdf,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    bool isNotHaveSignatureOwner =
        !isClient && data.signaturePropertyOwner == null;

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            "Última actualização: ${AppUtils.formatDateDayMounthAndYear(data.startDate)}",
            color: const Color(0xaf3c3c43),
          ),
          const SizedBox(height: 16),
          const CustomText(
            'CONTRATO DE COMPRA E VENDA DE IMÓVEL',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SizedBox(height: 16),
          const CustomText(
            'ENTRE',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SizedBox(height: 16),
          CustomText(
            "VENDEDOR: ${data.property.companyEntity.user.fullName}, [Nacionalidade], [Estado Civil], [Profissão], portador do BI nº ${data.property.companyEntity.nif}, inscrito no NIF sob o nº ${data.property.companyEntity.nif}, residente e domiciliado à [Endereço Completo do Vendedor].",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const CustomText(
            'E',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SizedBox(height: 16),
          CustomText(
            "COMPRADOR: ${data.user.fullName}, ${data.user.nationality}, ${data.user.maritalStatus}, portador do bilhete de identidade nº ${data.user.nif}, inscrito no NIF sob o nº ${data.user.nif}, residente e domiciliado à ${data.user.address}.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const CustomText(
            'OBJETO DO CONTRATO:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          const CustomText(
            "Pelo presente instrumento particular, as partes acima identificadas têm, entre si, justo e acordado o seguinte contrato de compra e venda do imóvel, que será regido pelas cláusulas seguintes e pelas condições de preço, forma de pagamento e termos descritos abaixo.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const CustomText(
            '1. DESCRIÇÃO DO IMÓVEL:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          CustomText(
            "Imóvel localizado à ${data.property.province} - ${data.property.county}/${data.property.address}, com área total de ${data.property.totalArea} m², inscrito na matrícula nº [Número da Matrícula] do Registro de Imóveis de ${data.property.address}.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const CustomText(
            '2. VALOR:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          CustomText(
            "O valor total da venda é de ${formatPrice(data.property.price)}, que foi pago por referência.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const CustomText(
            '3. DA POSSE E DA TRANSFERÊNCIA:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          CustomText(
            "A posse do imóvel será transferida do VENDEDOR para o COMPRADOR na data de ${AppUtils.formatDateDayMounthAndYear(data.startDate)}, após a quitação integral do valor acordado e cumprimento de todas as obrigações contratuais por ambas as partes.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const CustomText(
            '4. DAS OBRIGAÇÕES:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          const CustomText(
            "a) O VENDEDOR se compromete a entregar o imóvel livre de quaisquer ônus, dívidas ou impedimentos.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const CustomText(
            "b) O COMPRADOR se compromete a cumprir com o pagamento do valor acordado nas datas e condições estipuladas neste contrato.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const CustomText(
            '5. DA DOCUMENTAÇÃO:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          const CustomText(
            "Ambas as partes se comprometem a providenciar e apresentar toda a documentação necessária para a efetivação da transferência do imóvel, conforme exigido por lei.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const CustomText(
            '6. DISPOSIÇÕES GERAIS:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          const CustomText(
            "Este contrato é firmado em caráter irrevogável e irretratável, obrigando não só as partes contratantes, como também seus herdeiros e sucessores.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const CustomText(
            "Qualquer alteração neste contrato deverá ser feita por escrito, mediante aditamento assinado por ambas as partes.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              const CustomText(
                'Assinatura do Comprador:',
                fontSize: 14,
                color: secondaryText,
              ),
              CustomText(
                data.user.fullName,
                fontSize: 14,
                color: secondaryText,
              ),
              const SizedBox(height: defaultPadding),
              Center(
                child: Text(
                  data.signaturePropertyCustomer ?? '---',
                  style: const TextStyle(
                    fontSize: 32,
                    fontFamily: 'Sign Painter',
                    fontWeight: FontWeight.w500,
                    color: secondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: defaultPadding),
              const CustomText(
                'Assinatura do Vendedor:',
                fontSize: 14,
                color: secondaryText,
              ),
              CustomText(
                data.property.companyEntity.user.fullName,
                fontSize: 14,
                color: secondaryText,
              ),
              const SizedBox(height: defaultPadding),
              Center(
                child: Text(
                  data.signaturePropertyOwner ?? '---',
                  style: const TextStyle(
                    fontSize: 32,
                    fontFamily: 'Sign Painter',
                    fontWeight: FontWeight.w500,
                    color: secondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          if (isNotHaveSignatureOwner)
            AwaitingSignatureContractBox(
              data: data,
              onRefresh: onRefresh,
            ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Baixar PDF',
            onPressed: () => onDownloadPdf(data),
            prefixIcon: Icons.download_sharp,
          ),
        ],
      ),
    );
  }
}
