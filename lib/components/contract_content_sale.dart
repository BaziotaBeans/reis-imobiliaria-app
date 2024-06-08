

import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class ContractContentSale extends StatelessWidget {

  final Contract data;

  const ContractContentSale({ required this.data, super.key});

  @override
  Widget build(BuildContext context) {
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
          AppText(
            "Última actualização: ${AppUtils.formatDateDayMounthAndYear(data.startDate)}",
            color: const Color(0xaf3c3c43),
          ),
          const SizedBox(height: 16),
          const AppText(
            'CONTRATO DE COMPRA E VENDA DE IMÓVEL',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SizedBox(height: 16),
          const AppText(
            'ENTRE',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SizedBox(height: 16),
          AppText(
            "VENDEDOR: ${data.property.companyEntity.user.fullName}, [Nacionalidade], [Estado Civil], [Profissão], portador do BI nº ${data.property.companyEntity.nif}, inscrito no NIF sob o nº ${data.property.companyEntity.nif}, residente e domiciliado à [Endereço Completo do Vendedor].",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const AppText(
            'E',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SizedBox(height: 16),
          AppText(
            "COMPRADOR: ${data.user.fullName}, [Nacionalidade], [Estado Civil], [Profissão], portador do bilhete de identidade nº [Número da Identidade], inscrito no NIF sob o nº [Número do NIF], residente e domiciliado à [Endereço Completo do Comprador].",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const AppText(
            'OBJETO DO CONTRATO:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          const AppText(
            "Pelo presente instrumento particular, as partes acima identificadas têm, entre si, justo e acordado o seguinte contrato de compra e venda do imóvel, que será regido pelas cláusulas seguintes e pelas condições de preço, forma de pagamento e termos descritos abaixo.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const AppText(
            '1. DESCRIÇÃO DO IMÓVEL:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
           AppText(
            "Imóvel localizado à ${data.property.province} - ${data.property.county}/${data.property.address}, com área total de ${data.property.totalArea} m², inscrito na matrícula nº [Número da Matrícula] do Registro de Imóveis de [Nome da Cidade/Estado], cadastrado sob o nº [Número do Cadastro Imobiliário Municipal] na Prefeitura Municipal de [Nome da Cidade/Estado].",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const AppText(
            '2. VALOR:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
           AppText(
            "O valor total da venda é de ${formatPrice(data.property.price)}, que foi pago por referência.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const AppText(
            '3. DA POSSE E DA TRANSFERÊNCIA:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
           AppText(
            "A posse do imóvel será transferida do VENDEDOR para o COMPRADOR na data de ${AppUtils.formatDateDayMounthAndYear(data.startDate)}, após a quitação integral do valor acordado e cumprimento de todas as obrigações contratuais por ambas as partes.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const AppText(
            '4. DAS OBRIGAÇÕES:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
           const AppText(
            "a) O VENDEDOR se compromete a entregar o imóvel livre de quaisquer ônus, dívidas ou impedimentos.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
           const AppText(
            "b) O COMPRADOR se compromete a cumprir com o pagamento do valor acordado nas datas e condições estipuladas neste contrato.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const AppText(
            '5. DA DOCUMENTAÇÃO:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
           const AppText(
            "Ambas as partes se comprometem a providenciar e apresentar toda a documentação necessária para a efetivação da transferência do imóvel, conforme exigido por lei.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const AppText(
            '6. DISPOSIÇÕES GERAIS:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
           const AppText(
            "Este contrato é firmado em caráter irrevogável e irretratável, obrigando não só as partes contratantes, como também seus herdeiros e sucessores.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
           const AppText(
            "Qualquer alteração neste contrato deverá ser feita por escrito, mediante aditamento assinado por ambas as partes.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
        ],
      ),
    );
  }
}

