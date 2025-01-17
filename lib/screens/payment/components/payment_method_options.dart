import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/enums.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class PaymentMethodOptions extends StatelessWidget {
  final Function(PaymentMethodOptionsEnum?) onSelectPaymentMethod;
  final PaymentMethodOptionsEnum? selectedPaymentMethod;

  const PaymentMethodOptions({
    super.key,
    required this.onSelectPaymentMethod,
    required this.selectedPaymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            'Formas de pagamento',
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: secondaryColor,
          ),
          const SizedBox(height: 16.0),
          _PaymentMethod(
            icon: 'assets/images/express-box.png',
            title: 'Pagamento com Referencia',
            description: 'Pague com Referencia em qualquer banco credenciado',
            isPrimary: true,
            onSelectPaymentMethod: onSelectPaymentMethod,
            paymentMethodOption: PaymentMethodOptionsEnum.reference,
            selectedPaymentMethod: selectedPaymentMethod,
          ),
          const SizedBox(height: 16.0),
          _PaymentMethod(
            icon: 'assets/images/express-box.png',
            title: 'Pagamento Multicaixa Express',
            description: 'Pague com multicaixa online',
            isPrimary: false,
            onSelectPaymentMethod: onSelectPaymentMethod,
            paymentMethodOption: PaymentMethodOptionsEnum.multicaixa_express,
            selectedPaymentMethod: selectedPaymentMethod,
          ),
        ],
      ),
    );
  }
}

class _PaymentMethod extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final bool isPrimary;
  final PaymentMethodOptionsEnum paymentMethodOption;
  final Function(PaymentMethodOptionsEnum?) onSelectPaymentMethod;
  final PaymentMethodOptionsEnum? selectedPaymentMethod;

  const _PaymentMethod({
    required this.icon,
    required this.title,
    required this.description,
    required this.isPrimary,
    required this.paymentMethodOption,
    required this.onSelectPaymentMethod,
    required this.selectedPaymentMethod,
  });

  Widget _builtTag() {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(defaultBorderRadious),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: CustomText(
          'Primário',
          fontWeight: FontWeight.bold,
          fontSize: 11,
          color: primaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedPaymentMethod == paymentMethodOption;

    return InkWell(
      onTap: () => {onSelectPaymentMethod(paymentMethodOption)},
      child: Stack(
        children: [
          if (isPrimary)
            Positioned(
              top: 8,
              right: 24,
              child: _builtTag(),
            ),
          AnimatedContainer(
            duration: Durations.medium4,
            padding: const EdgeInsets.all(16.0),
            height: 100,
            decoration: BoxDecoration(
              color: isSelected ? primaryColor.withOpacity(0.1) : whiteColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  icon,
                  width: 48.0,
                  height: 48.0,
                ),
                const SizedBox(width: defaultPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                if (isSelected)
                  SvgPicture.asset(
                    "assets/icons/Checked.svg",
                    width: 24,
                    height: 24,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
