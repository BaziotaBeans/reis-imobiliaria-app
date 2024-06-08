import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/components/header.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/enums.dart';
import 'package:reis_imovel_app/models/OrderList.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool _isLoading = false;

  PaymentMethodEnum? _paymentMethod = PaymentMethodEnum.reference_payment;

  Widget _imageBox(PropertyResult data) {
    return Container(
      width: 86,
      height: 69,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(data.images[0].url),
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _displayDetail(BuildContext context, PropertyResult data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width) - (86 + 20 + 40),
          child: AppText(
            data.property.title,
            color: const Color(0xFF3D3F33),
            fontSize: 16,
            fontWeight: FontWeight.w700,
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.location_on, size: 18, color: Color(0xff687553)),
            const SizedBox(width: 4),
            SizedBox(
              width: 200,
              child: AppText(
                "${data.property.province}, ${data.property.county}",
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w400,
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: formatPrice(data.property.price),
                style: const TextStyle(
                  color: Color(0xff687553),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Avenir',
                ),
              ),
              if (data.property.fkPropertyType == AppConstants.propertyTypeRent)
                TextSpan(
                  text: ' / mês',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Avenir',
                  ),
                ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _cardPrimary(BuildContext context, PropertyResult data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _imageBox(data),
          const SizedBox(
            width: 20,
          ),
          _displayDetail(context, data)
        ],
      ),
    );
  }

  Widget _paymentMethodBox(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            'Formas de pagamento',
            color: Color(0xff3D3F33),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(
            height: 20,
          ),
          RadioListTile(
            contentPadding: const EdgeInsets.all(0),
            title: const AppText(
              'Pagamento por referência',
              color: Color(0xff3D3F33),
            ),
            value: PaymentMethodEnum.reference_payment,
            fillColor: const MaterialStatePropertyAll(Color(0xff687553)),
            groupValue: _paymentMethod,
            onChanged: (PaymentMethodEnum? value) {
              setState(() {
                _paymentMethod = value;
              });
            },
          ),
          RadioListTile(
            title: const AppText(
              'Pagamento por transferência',
              color: Color(0xff3D3F33),
            ),
            contentPadding: const EdgeInsets.all(0),
            value: PaymentMethodEnum.transfer_payment,
            fillColor: const MaterialStatePropertyAll(Color(0xff687553)),
            groupValue: _paymentMethod,
            onChanged: (PaymentMethodEnum? value) {
              setState(() {
                _paymentMethod = value;
              });
            },
          ),
        ],
      ),
    );
  }

  void _submitReference(PropertyResult data) async {
    setState(() => _isLoading = true);

    final totalValue = AppUtils.getTotalValueToPaidInProperty(data);

    try {
      await Provider.of<OrderList>(
        context,
        listen: false,
      ).createOrder(data.property.pkProperty, totalValue);

      await Provider.of<OrderList>(
        context,
        listen: false,
      ).loadLastOrder();

      Navigator.of(context).pushNamed(
        AppRoutes.PAYMENT_METHOD_REFERENCE_SCREEN,
      );

      Fluttertoast.showToast(
        msg: "Pedido criado com sucesso",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[700],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print('Error: ${e.toString()}');

      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const AppText('Ocorreu um erro!'),
          content: const AppText('Ocorreu um erro ao criar pedido.'),
          actions: [
            TextButton(
              child: const AppText('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _footer(PropertyResult data) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          AppText(
            data.property.fkPropertyType == AppConstants.propertyTypeRent
                ? 'Preço do aluguel'
                : 'Preço da compra',
            textAlign: TextAlign.center,
            color: Colors.grey[500],
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Avenir',
          ),
          const SizedBox(
            height: 12,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: formatPrice(data.property.price),
                  style: const TextStyle(
                    color: Color(0xFF687553),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Avenir',
                  ),
                ),
                if (data.property.fkPropertyType ==
                    AppConstants.propertyTypeRent)
                  TextSpan(
                    text: ' / mês',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Avenir',
                    ),
                  ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 100),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Button(
              title: 'Continuar',
              onPressed: () {
                if (_paymentMethod == PaymentMethodEnum.reference_payment) {
                  _submitReference(data);
                  return;
                }
                Navigator.of(context).pushNamed(
                  AppRoutes.PAYMENT_METHOD_TRANSFER_SCREEN,
                  arguments: data,
                );
              },
              variant: ButtonVariant.primary,
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PropertyResult data =
        ModalRoute.of(context)?.settings.arguments as PropertyResult;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Header(
                  title: 'Pagamento',
                  onPressed: () {},
                ),
                _cardPrimary(context, data),
                _paymentMethodBox(context),
                _footer(data)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
