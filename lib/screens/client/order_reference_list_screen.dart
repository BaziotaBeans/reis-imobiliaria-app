import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/header.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/components/new/dialog_widget.dart';
import 'package:reis_imovel_app/components/new/toast_widget.dart';
import 'package:reis_imovel_app/components/timer_box.dart';
import 'package:reis_imovel_app/dto/Order.dart';
import 'package:reis_imovel_app/models/OrderList.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class OrderReferenceListScreen extends StatefulWidget {
  const OrderReferenceListScreen({super.key});

  @override
  State<OrderReferenceListScreen> createState() =>
      _OrderReferenceListScreenState();
}

class _OrderReferenceListScreenState extends State<OrderReferenceListScreen> {
  Future? _loadOrders;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadOrders = Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrdersByUser();
  }

  Future<void> _refreshOrders(BuildContext context) async {
    setState(() {
      _loadOrders = Provider.of<OrderList>(
        context,
        listen: false,
      ).loadOrdersByUser();
    });
  }

  Future<void> _deleteOrder(String pkOrder) async {
    setState(() => _isLoading = true);

    try {
      await Provider.of<OrderList>(
        context,
        listen: false,
      ).deleteOrder(pkOrder);

      if (mounted) {
        await _refreshOrders(context);
        ToastWidget.showSuccessToast("Pedido cancelado com sucesso");
      }
    } catch (e) {
      if (mounted) {
        await DialogWidget.showErrorDialog(
          context: context,
          title: 'Ocorreu um erro!',
          message: 'Não foi possível cancelar o pedido.',
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

  Widget _orderCard(BuildContext context, Order order) {
    return InkWell(
      onTap: () {},
      child: Card(
        color: Colors.white,
        borderOnForeground: true,
        surfaceTintColor: Colors.white,
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    "Pedido",
                    color: secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    "Referência - ${order.reference}",
                    color: secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // _timerBox(),
                        TimerBox(
                          expirationDate: DateTime.parse(
                            order.expirationDate,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const CustomText(
                          "Pagamento pendente",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff3D3F33),
                        ),
                        const SizedBox(height: 6),
                        CustomText(
                          formatPrice(order.totalValue),
                          fontSize: 16,
                          color: secondaryColor,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomButton(
                          text: 'Visualizar',
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.ORDER_REFERENCE_SCREEN,
                              arguments: order,
                            );
                          },
                          fontSize: 14,
                        ),
                        const SizedBox(height: 10),
                        if (_isLoading)
                          const Center(
                            child:
                                CircularProgressIndicator(color: primaryColor),
                          )
                        else
                          CustomButton(
                            text: 'Cancelar',
                            variant: ButtonVariant.outline,
                            onPressed: () {
                              _deleteOrder(order.pkOrder);
                            },
                            fontSize: 14,
                            forcedBackgroundColor: whiteColor,
                            // minimumSize: 30,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final OrderList orderList = Provider.of(context);

    List<Order> orders = orderList.ordersByUser;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const CustomText(
          'Pedidos',
          fontWeight: FontWeight.w500,
          color: secondaryColor,
          fontSize: 16,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: primaryColor,
        backgroundColor: whiteColor,
        onRefresh: () => _refreshOrders(context),
        child: SafeArea(
          child: FutureBuilder(
            future: _loadOrders,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                debugPrint('############ERROR########');
                debugPrint('${snapshot.error}');
                debugPrint('##########################');
                return const Center(child: Text('Ocorreu um erro!'));
              } else {
                if (orders.isEmpty) {
                  return const Center(
                    child: CustomText(
                      'Sem Pedidos',
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
                          padding: const EdgeInsets.all(4),
                          child: ListView.separated(
                            itemBuilder: (_, i) {
                              return _orderCard(context, orders[i]);
                            },
                            separatorBuilder: (_, index) {
                              return const Divider(
                                color: Colors.transparent,
                                height: 4,
                              );
                            },
                            itemCount: orders.length,
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
