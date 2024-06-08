import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/header.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/models/ContractList.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';

class ContractListScreen extends StatefulWidget {
  const ContractListScreen({super.key});

  @override
  State<ContractListScreen> createState() => _ContractListScreenState();
}

class _ContractListScreenState extends State<ContractListScreen> {
  Future? _loadContractsFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<ContractList>(
  //     context,
  //     listen: false,
  //   ).loadContracts();
  // }

  // Future<void> _refreshProperties(BuildContext context) {
  //   return Provider.of<ContractList>(
  //     context,
  //     listen: false,
  //   ).loadContracts();
  // }

  @override
  void initState() {
    super.initState();
    _loadContractsFuture = Provider.of<ContractList>(
      context,
      listen: false,
    ).loadContracts();
  }

  Future<void> _refreshProperties(BuildContext context) async {
    setState(() {
      _loadContractsFuture = Provider.of<ContractList>(
        context,
        listen: false,
      ).loadContracts();
    });
  }

  Widget _contractCard(BuildContext context, Contract data) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.CONTRACT_SCREEN,
          arguments: data,
        );
      },
      child: Card(
        color: Colors.white,
        borderOnForeground: true,
        surfaceTintColor: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                data.property.title,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              AppText(
                "${data.property.province}, ${data.property.county}",
                color: Colors.grey[700],
              ),
              const SizedBox(
                height: 14,
              ),
              AppText(
                "Tipo: ${AppUtils.getPropertyTypeLabel(data.property.fkPropertyType)}",
                color: Colors.grey[700],
              ),
              const SizedBox(
                height: 14,
              ),
              if (data.property.fkPropertyType ==
                      AppConstants.propertyTypeGround ||
                  data.property.fkPropertyType == AppConstants.propertyTypeSale)
                AppText(
                  'Data da compra: ${AppUtils.formatDateDayMounthAndYear(data.startDate)}',
                  color: Colors.grey[700],
                ),
              if (data.property.fkPropertyType == AppConstants.propertyTypeRent)
                AppText(
                  'Data de início: ${AppUtils.formatDateDayMounthAndYear(data.startDate)}',
                  color: Colors.grey[700],
                ),
              const SizedBox(
                height: 14,
              ),
              if ((data.property.fkPropertyType ==
                  AppConstants.propertyTypeRent))
                AppText(
                  'Data de termino: ${AppUtils.formatDateDayMounthAndYear(data.endDate ?? DateTime.now().toString())}',
                  color: Colors.grey[700],
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ContractList contractList = Provider.of(context);

    List<Contract> contracts = contractList.contracts;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _refreshProperties(context),
        child: SafeArea(
          child: FutureBuilder(
              future: _loadContractsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Enquanto os dados estão carregando, exibe um spinner
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.error != null) {
                  return const Center(child: Text('Ocorreu um erro!'));
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Header(title: 'Contratos'),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.all(4),
                          child: ListView.separated(
                            itemBuilder: (_, i) {
                              return _contractCard(context, contracts[i]);
                            },
                            separatorBuilder: (_, index) {
                              return const Divider(
                                color: Colors.transparent,
                                height: 4,
                              );
                            },
                            itemCount: contracts.length,
                          ),
                        )
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
