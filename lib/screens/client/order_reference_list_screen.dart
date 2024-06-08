import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/components/header.dart';
import 'package:reis_imovel_app/components/timer_box.dart';
import 'package:reis_imovel_app/dto/Order.dart';
import 'package:reis_imovel_app/models/OrderList.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class OrderReferenceListScreen extends StatefulWidget {
  const OrderReferenceListScreen({super.key});

  @override
  State<OrderReferenceListScreen> createState() =>
      _OrderReferenceListScreenState();
}

class _OrderReferenceListScreenState extends State<OrderReferenceListScreen> {
  Future? _loadOrders;

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

  Widget showEmptyMessage() {
    double height = MediaQuery.of(context).size.height / 3;

    return SizedBox(
      height: height,
      child: Center(
        child: AppText(
          'Sem pedidos',
          color: Colors.grey[400],
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
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
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    "Pedido #10291",
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
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
                        const SizedBox(height: 4),
                        const AppText(
                          "Pagamento pendente",
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xff3D3F33),
                        ),
                        const SizedBox(height: 4),
                        AppText(
                          formatPrice(order.totalValue),
                          fontSize: 14,
                          color: const Color(0xff3D3F33),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Button(
                          title: 'Visualizar',
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                              AppRoutes.ORDER_REFERENCE_SCREEN,
                              arguments: order,
                            );
                          },
                          variant: ButtonVariant.primary,
                          fontSize: 12,
                          minimumSize: 30,
                        ),
                        Button(
                          title: 'Cancelar',
                          onPressed: () {},
                          variant: ButtonVariant.outline,
                          fontSize: 12,
                          minimumSize: 30,
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
      body: RefreshIndicator(
        onRefresh: () => _refreshOrders(context),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(title: 'Pedidos'),
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(4),
                  child: orders.isEmpty
                      ? showEmptyMessage()
                      : ListView.separated(
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
          ),
        ),
      ),
    );
  }
}
