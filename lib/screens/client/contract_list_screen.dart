import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/header.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/models/ContractList.dart';
import 'package:reis_imovel_app/screens/contract/components/contract_card.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class ContractListScreen extends StatefulWidget {
  const ContractListScreen({super.key});

  @override
  State<ContractListScreen> createState() => _ContractListScreenState();
}

class _ContractListScreenState extends State<ContractListScreen> {
  Future? _loadContractsFuture;

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

  @override
  Widget build(BuildContext context) {
    ContractList contractList = Provider.of(context);

    List<Contract> contracts = contractList.contracts;

    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: whiteColor,
        onRefresh: () => _refreshProperties(context),
        child: Scaffold(
          backgroundColor: whiteColor,
          body: SafeArea(
            child: FutureBuilder(
              future: _loadContractsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.error != null) {
                  return const Center(child: CustomText('Ocorreu um erro!'));
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Header(title: 'Contratos'),
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
              },
            ),
          ),
        ),
      ),
    );
  }
}
