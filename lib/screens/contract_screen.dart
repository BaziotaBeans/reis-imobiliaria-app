import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/contract_content_sale.dart';
import 'package:reis_imovel_app/components/new/custom_back_button.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/components/new/snackbar_bar_widget.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/helper/contract_pdf_generator.dart';
import 'package:reis_imovel_app/helper/property_purchase_pdf_generator.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/models/ContractList.dart';
import 'package:reis_imovel_app/screens/contract/components/contract_rented_content.dart';
import 'package:reis_imovel_app/screens/contract/components/signature_contract_view.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class ContractScreen extends StatefulWidget {
  const ContractScreen({super.key});

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  // late Future<void> _loadContractById;
  Future<void>? _loadContractById;
  late Contract data;
  bool _isLoading = false;

  Future<void> fetchContractById() async {
    try {
      setState(() => _isLoading = true);
      await Provider.of<ContractList>(
        context,
        listen: false,
      ).loadContractsById(data.pkContract);
    } catch (e) {
      debugPrint('ERRO ao buscar por id: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      data = ModalRoute.of(context)!.settings.arguments as Contract;
      setState(() {
        _loadContractById = fetchContractById();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refreshContract(BuildContext context) async {
    setState(() {
      _loadContractById = fetchContractById();
    });
  }

  Future<void> _handleDownloadPdf(Contract data) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(color: whiteColor),
          );
        },
      );

      if (data.property.fkPropertyTypeEntity.designation == 'Arrendamento') {
        await ContractPdfGenerator.generateContractPdf(data);
      } else {
        await PropertyPurchasePdfGenerator.generatePurchaseContractPdf(data);
      }

      Navigator.of(context).pop();

      if (mounted) {
        SnackBarWidget.showSuccess(
          context: context,
          message: 'PDF gerado com sucesso!',
        );
      }
    } catch (e) {
      Navigator.of(context).pop();

      if (mounted) {
        SnackBarWidget.showError(
          context: context,
          message: 'Erro ao gerar PDF: ${e.toString()}',
        );

        debugPrint('Erro ao gerar PDF: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Contract data = ModalRoute.of(context)?.settings.arguments as Contract;

    Auth auth = Provider.of(context);

    Contract? data = Provider.of<ContractList>(
      context,
      listen: false,
    ).currentContract;

    String contractPurpose =
        data?.property.fkPropertyType == AppConstants.propertyTypeRent
            ? 'Aluguel'
            : 'Compra';

    bool isNotHaveSignature = auth.roles?.contains("ROLE_USER") == true &&
        data?.contractStatus == 'PENDING' &&
        data?.signaturePropertyCustomer == null;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: CustomText(
          'Contrato de $contractPurpose',
          color: secondaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        leading: const CustomBackButton(),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        backgroundColor: whiteColor,
        onRefresh: () => _refreshContract(context),
        child: SafeArea(
          child: FutureBuilder(
            future: _loadContractById,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(child: CustomText('Ocorreu um erro!'));
              } else {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isNotHaveSignature)
                        SignatureContractView(
                          data: data!,
                          onRefresh: _refreshContract,
                        ),
                      if (data?.property.fkPropertyType ==
                              AppConstants.propertyTypeRent &&
                          !isNotHaveSignature)
                        ContractRentedContent(
                          data: data!,
                          isClient: auth.roles?.contains("ROLE_USER") == true,
                          onDownloadPdf: _handleDownloadPdf,
                          onRefresh: _refreshContract,
                        ),
                      if ((data?.property.fkPropertyType ==
                                  AppConstants.propertyTypeGround ||
                              data?.property.fkPropertyType ==
                                  AppConstants.propertyTypeSale) &&
                          !isNotHaveSignature)
                        ContractContentSale(
                          data: data!,
                          isClient: auth.roles?.contains("ROLE_USER") == true,
                          onDownloadPdf: _handleDownloadPdf,
                          onRefresh: _refreshContract,
                        )
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
