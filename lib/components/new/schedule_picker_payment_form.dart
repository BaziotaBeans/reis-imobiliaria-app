import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:reis_imovel_app/components/new/custom_form_field.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/components/new/dialog_widget.dart';
import 'package:reis_imovel_app/components/new/snackbar_bar_widget.dart';
import 'package:reis_imovel_app/dto/Scheduling.dart';
import 'package:reis_imovel_app/models/PaymentList.dart';
import 'package:reis_imovel_app/models/PropertyScheduleList.dart';
import 'package:reis_imovel_app/screens/payment/components/payment_footer.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/validators/angola_phone_validator.dart';

class SchedulePickerPaymentForm extends StatefulWidget {
  final String pkProperty;
  final String selectedScheduleId;

  const SchedulePickerPaymentForm({
    super.key,
    required this.pkProperty,
    required this.selectedScheduleId,
  });

  @override
  State<SchedulePickerPaymentForm> createState() =>
      _SchedulePickerPaymentFormState();
}

class _SchedulePickerPaymentFormState extends State<SchedulePickerPaymentForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  bool _isValid = false;

  final TextEditingController phoneController = TextEditingController();

  Future<void> _submit() async {
    final msg = ScaffoldMessenger.of(context);
    setState(() => _isLoading = true);

    try {
      debugPrint(
          'Agendando: ${widget.selectedScheduleId}, ${widget.pkProperty}');

      // Criar o agendamento
      final scheduleList =
          Provider.of<PropertyScheduleList>(context, listen: false);
      await scheduleList.createScheduling(
          widget.selectedScheduleId, widget.pkProperty);

      // Carregar o último agendamento
      await scheduleList.loadLastScheduling();
      final currentScheduling = scheduleList.currentScheduling;

      if (currentScheduling != null) {
        debugPrint('Agendamento criado: ${currentScheduling.pkScheduling}');

        // Criar o pagamento
        await Provider.of<PaymentList>(
          context,
          listen: false,
        ).createSchedulingPayment(
          widget.pkProperty,
          currentScheduling.pkScheduling,
        );

        msg.showSnackBar(
          const SnackBar(content: Text('Visita agendada com sucesso')),
        );

        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        throw Exception('Erro: Agendamento não encontrado após criação.');
      }
    } catch (e) {
      debugPrint('Erro no _submit: ${e.toString()}');
      if (mounted) {
        await DialogWidget.showErrorDialog(
          context: context,
          title: 'Ocorreu um erro!',
          message: 'Erro ao realizar o agendamento.',
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _validateAndAdvance() {
    bool? isValid = _formKey.currentState?.validate();

    setState(() {
      _isValid = isValid ?? false;
    });

    if (_isValid) {
      _submit();
    } else {
      SnackBarWidget.showError(
        context: context,
        message: 'Por favor, preencha os campos obrigatórios!',
      );
    }
  }

  void _handleValidateOnChange() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isValid = _formKey.currentState?.validate() ?? false;
      });
    });
  }

  Widget _paymentImage() {
    return Center(
      child: Image.asset(
        'assets/images/multicaixa-express.png',
        fit: BoxFit.cover,
        width: 83,
      ),
    );
  }

  Widget _infoText() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomText(
                  'Para agendar a sua visita ao imóvel, será necessário realizar o pagamento de uma taxa de 3000kz',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 8,
                  color: Colors.grey[700],
                ),
              )
            ],
          ),
          const SizedBox(height: 6),
          CustomText(
            'Digite o seu número de telefone associado a tua conta express para ser reflectido o desconto, em caso de dúvida clique aqui.',
            textAlign: TextAlign.center,
            softWrap: true,
            maxLines: 4,
            color: Colors.grey[700],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _paymentImage(),
          const SizedBox(height: 6),
          Center(
            child: CustomText(
              'Pague com Multicaixa Express',
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 2),
          _infoText(),
          const SizedBox(height: 8),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFormField(
                  controller: phoneController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onChanged: (val) {
                    _handleValidateOnChange();
                  },
                  labelText: 'Número de telefone',
                  hintText: 'Digite o número de telefone',
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: 'Este campo é obrigatório'),
                      AngolaPhoneValidator(
                        errorText: 'Número de telefone inválido.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                if (_isLoading)
                  const Center(
                      child: CircularProgressIndicator(color: primaryColor))
                else
                  CustomButton(
                    text: 'Finalizar pagamento',
                    onPressed: _isValid ? _validateAndAdvance : null,
                  ),
                const PaymentFooter()
              ],
            ),
          )
        ],
      ),
    );
  }
}
