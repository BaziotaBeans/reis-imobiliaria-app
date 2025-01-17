import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/models/ContractList.dart';
import 'package:reis_imovel_app/screens/contract/components/contract_card.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class ContractsScreen extends StatefulWidget {
  const ContractsScreen({super.key});

  @override
  State<ContractsScreen> createState() => _ContractsScreenState();
}

class _ContractsScreenState extends State<ContractsScreen> {
  Future? _loadContractsFuture;

  @override
  void initState() {
    super.initState();
    _loadContractsFuture = Provider.of<ContractList>(
      context,
      listen: false,
    ).loadContractsByCompany();
  }

  Future<void> _refreshProperties(BuildContext context) async {
    setState(() {
      _loadContractsFuture = Provider.of<ContractList>(
        context,
        listen: false,
      ).loadContractsByCompany();
    });
  }

  @override
  Widget build(BuildContext context) {
    ContractList contractList = Provider.of(context);

    List<Contract> contracts = contractList.contractsByCompany;

    return Scaffold(
      backgroundColor: whiteColor,
      body: RefreshIndicator(
        onRefresh: () => _refreshProperties(context),
        backgroundColor: whiteColor,
        color: primaryColor,
        child: SafeArea(
          child: FutureBuilder(
            future: _loadContractsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.error != null) {
                return const Center(child: CustomText('Ocorreu um erro!'));
              } else {
                if (contracts.isEmpty) {
                  return const Center(
                    child: CustomText(
                      'Sem Agendamentos',
                      color: secondaryText,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.all(defaultPadding),
                          child: ListView.separated(
                            itemBuilder: (_, i) {
                              return ContractCard(
                                context: context,
                                data: contracts[i],
                                index: i + 1,
                              );
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
              }
            },
          ),
        ),
      ),
    );
  }
}
