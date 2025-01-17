import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reis_imovel_app/components/app_dropdown_form_field.dart';
import 'package:reis_imovel_app/components/app_load_form.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/app_text_form_field.dart';
import 'package:reis_imovel_app/components/header.dart';
import 'package:reis_imovel_app/components/schedule_status.dart';
import 'package:reis_imovel_app/components/upload_images.dart';
import 'package:reis_imovel_app/data/payment_modality_data.dart';
import 'package:reis_imovel_app/data/property_status_data.dart';
import 'package:reis_imovel_app/data/province_data.dart';
import 'package:reis_imovel_app/enums.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/models/PropertyList.dart';
import 'package:reis_imovel_app/models/Schedule.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/app_validators.dart';

class FormCreateImmboleForRent extends StatefulWidget {
  const FormCreateImmboleForRent({super.key});

  @override
  State<FormCreateImmboleForRent> createState() =>
      _FormCreateImmboleForRentState();
}

class _FormCreateImmboleForRentState extends State<FormCreateImmboleForRent> {
  final _formKey = GlobalKey<FormState>();

  final _formData = <String, Object>{};

  bool _isLoading = false;

  Set<PaymentModalityEnum> selectedPaymentModality = <PaymentModalityEnum>{
    PaymentModalityEnum.quarterly
  };

  String updateProvinceValueState = '';

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _provinceController = TextEditingController();

  final TextEditingController _countyController = TextEditingController();

  final TextEditingController _streetController = TextEditingController();

  final TextEditingController _suitsController = TextEditingController();

  final TextEditingController _roomController = TextEditingController();

  final TextEditingController _bathroomController = TextEditingController();

  final TextEditingController _vacancyController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _selectedStatusController =
      TextEditingController();

  final TextEditingController _paymentMethodController =
      TextEditingController();

  final TextEditingController _totalAreaController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  int _currentStep = 0;

  List<MediaFile> selectedFiles = [];

  List<String> images = [];

  List<Schedule> selectedSchedules = [];

  void removeImageFromSelectedFiles(int index) {
    setState(() {
      selectedFiles = List.from(selectedFiles)..removeAt(index);
    });
  }

  void selectFile() async {
    List<MediaFile> mediaFiles =
        await GalleryPicker.pickMedia(context: context, singleMedia: false) ??
            [];

    for (int i = 0; i < mediaFiles.length; i++) {
      setState(() {
        selectedFiles = List.from(selectedFiles)..add(mediaFiles[i]);
      });
    }
  }

  void addImageToImageList(String downloadURL) {
    setState(() {
      images = List.from(images)..add(downloadURL);
    });
  }

  void _updateSchedule(List<Schedule> schedules) {
    setState(() {
      selectedSchedules = schedules;
    });
  }

  void submitUpload() async {
    setState(() => _isLoading = true);

    bool success = await AppUtils.uploadMultipleFilesForUser(
        selectedFiles, addImageToImageList);

    if (success) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const AppText('Form Submitted'),
            content: const AppText('Your form has been submitted successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              )
            ],
          );
        },
      );
    }
    setState(() => _isLoading = false);
  }

  Future<void> _submitForm(String propertyType) async {
    setState(() => _isLoading = true);

    debugPrint(
        "-------------------------------------------ENTROU NO SUBMIT-------------------------------------------");

    bool success = await AppUtils.uploadMultipleFilesForUser(
        selectedFiles, addImageToImageList);

    final formData = {
      'title': AppValidators.validateStringFormData(_formData['title']),
      'province': AppValidators.validateStringFormData(_formData['province']),
      'county': AppValidators.validateStringFormData(_formData['county']),
      'address': AppValidators.validateStringFormData(_formData['address']),
      'suits': AppValidators.validateIntFormData(_formData['suits']),
      'room': AppValidators.validateIntFormData(_formData['room']),
      'bathroom': AppValidators.validateIntFormData(_formData['bathroom']),
      'vacancy': AppValidators.validateIntFormData(_formData['vacancy']),
      'price': AppValidators.validateDoubleFormData(_formData['price']),
      'totalArea': AppValidators.validateDoubleFormData(_formData['totalArea']),
      'buildingArea':
          AppValidators.validateDoubleFormData(_formData['buildingArea']),
      'description':
          AppValidators.validateStringFormData(_formData['description']),
      'paymentModality':
          AppValidators.validateStringFormData(_formData['paymentModality']),
      'status': true,
      'fkPropertyType': propertyType,
      'images': images,
      'propertyStatus':
          AppValidators.validateStringFormData(_formData["propertyStatus"]),
      'schedules': selectedSchedules as List<Schedule>
    };

    //jsonEncode(selectedSchedules.map((schedule) => schedule.toJson()).toList())

    if (!success) {
      Fluttertoast.showToast(
        msg: "Não foi possível salvar os dados",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[600],
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      await Provider.of<PropertyList>(
        context,
        listen: false,
      ).saveProperty(formData);

      Navigator.of(context).pushNamed(AppRoutes.ANNOUNCEMENT_SCREEN);

      Fluttertoast.showToast(
        msg: "Dados salvo com sucesso",
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
          content: const AppText(
              'Ocorreu um erro para salvar o imovel/propriedade.'),
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

  List<Step> getSteps(String anncounementType) {
    return <Step>[
      Step(
        title: const AppText('Informações Gerais'),
        content: Column(
          children: [
            AppTextFormField(
              hintText: 'Título/Nome',
              labelText: 'Título/Nome',
              helperText: 'O nome deve possuir no mínimo 5 caracteres',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              onSaved: (title) => _formData['title'] = title ?? '',
              onChanged: (value) {
                _formData['title'] = value ?? '';
              },
              controller: _titleController,
              validator: (value) {
                final title = value ?? '';
                if (title.isEmpty || title.length < 5) {
                  return 'Informe um nome válido';
                }
                return null;
              },
            ),
            AppDropdownFormField(
              controller: _selectedStatusController,
              hintText: 'Selecionar o estado do imóvel',
              labelText: 'Estado do imóvel',
              helperText:
                  "Selecione o estado atual do imóvel: Publicado, Em espera ou Arrendado.",
              list: propertyStatusData,
              widthValueOfPadding: 41,
              enableFilter: false,
              enableSearch: false,
              onSelected: (value) {
                if (value != null) {
                  _formData["propertyStatus"] =
                      AppUtils.getPropertyStatus(value);
                }
              },
            ),
          ],
        ),
      ),
      Step(
        title: const AppText('Localização'),
        content: Column(
          children: [
            AppDropdownFormField(
              controller: _provinceController,
              hintText: 'Selecionar uma provincia',
              labelText: 'Provincia',
              list: provincesData,
              widthValueOfPadding: 41,
              onSelected: (value) {
                setState(() => updateProvinceValueState = value ?? '');
                _formData['province'] = value ?? '';
              },
            ),
            AppDropdownFormField(
              controller: _countyController,
              hintText: 'Selecionar o município',
              labelText: 'Município',
              list: AppUtils.filtrarCountyData(updateProvinceValueState),
              // enabled: false,
              widthValueOfPadding: 41,
              onSelected: (value) => {_formData['county'] = value ?? ''},
            ),
            AppTextFormField(
              hintText: 'Digite o endereço ou bairro',
              labelText: 'Endereço / Bairro',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              onSaved: (value) => _formData['address'] = value ?? '',
              onChanged: (value) {
                _formKey.currentState?.validate();
                _formData['address'] = value ?? '';
              },
              controller: _streetController,
            ),
          ],
        ),
      ),
      Step(
        title: const AppText('Características Internas'),
        content: Column(
          children: [
            AppTextFormField(
              hintText: 'Digite o número de quartos',
              labelText: 'Número de Quartos',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onSaved: (value) => _formData['room'] = int.parse(value ?? '0'),
              onChanged: (value) {
                _formKey.currentState?.validate();
                _formData['room'] = int.parse(value ?? '0');
              },
              controller: _roomController,
            ),
            AppTextFormField(
              hintText: 'Digite o número de súites',
              labelText: 'Número de Súites',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onSaved: (value) => _formData['suits'] = int.parse(value ?? '0'),
              onChanged: (value) {
                _formKey.currentState?.validate();
                _formData['suits'] = int.parse(value ?? '0');
              },
              controller: _suitsController,
              validator: (_value) {
                AppUtils.validateValueAsNumber(_value, 'Súites');
              },
            ),
            AppTextFormField(
              hintText: 'Digite o número de banheiros',
              labelText: 'Número de banheiros',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onSaved: (value) =>
                  _formData['bathroom'] = int.parse(value ?? '0'),
              onChanged: (value) {
                _formKey.currentState?.validate();
                _formData['bathroom'] = int.parse(value ?? '0');
              },
              controller: _bathroomController,
            ),
          ],
        ),
      ),
      Step(
        title: const AppText('Características Externas'),
        content: Column(
          children: [
            AppTextFormField(
              hintText: 'Digite o número de vagas',
              labelText: 'Número de vagas',
              helperText:
                  'Número de vagas corresponde ao número de vagas para o estacionamento de carro.',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onSaved: (value) =>
                  _formData['vacancy'] = int.parse(value ?? '0'),
              onChanged: (value) {
                _formKey.currentState?.validate();
                _formData['vacancy'] = int.parse(value ?? '0');
              },
              controller: _vacancyController,
            ),
            AppTextFormField(
              hintText: 'Digite a área total',
              labelText: 'Área total (m²)',
              helperText: 'Área de construção do imóvel, medido em m².',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onSaved: (value) =>
                  _formData['totalArea'] = double.parse(value ?? '0'),
              onChanged: (value) {
                _formKey.currentState?.validate();
                _formData['totalArea'] = double.parse(value ?? '0');
              },
              controller: _totalAreaController,
            ),
          ],
        ),
      ),
      Step(
        title: const AppText("Agendamento"),
        content: ScheduleStatus(
          selectedSchedules: selectedSchedules,
          addSchedule: _updateSchedule,
        ),
      ),
      Step(
        title: const AppText("Informações Financeiras"),
        content: Column(
          children: [
            if (AppConstants.propertyTypeRent == anncounementType)
              AppDropdownFormField(
                controller: _paymentMethodController,
                hintText: 'Selecionar a modalidade pagamento',
                labelText: 'Modalidade de pagamento',
                list: payment_modality_data,
                enableFilter: false,
                enableSearch: false,
                widthValueOfPadding: 41,
                onSelected: (value) =>
                    {_formData['paymentModality'] = value ?? ''},
              ),
            AppTextFormField(
              hintText: 'Digite o preço',
              labelText: AppConstants.propertyTypeRent == anncounementType
                  ? 'Preço de aluguel'
                  : 'Preço da compra',
              helperText: AppConstants.propertyTypeRent == anncounementType
                  ? 'O preço do aluguel será multiplicado em função da modalidade de pagamento.'
                  : 'Por favor, insira o preço de compra do imóvel dentro da faixa correspondente.',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onSaved: (value) =>
                  _formData['price'] = double.parse(value ?? '0'),
              onChanged: (value) {
                _formKey.currentState?.validate();
                _formData['price'] = double.parse(value ?? '0');
              },
              controller: _priceController,
            ),
          ],
        ),
      ),
      Step(
        title: const AppText("Images do imóvel"),
        content: Column(
          children: [
            UploadImages(
              selectedFiles: selectedFiles,
              onDelete: removeImageFromSelectedFiles,
              onAdd: selectFile,
            )
          ],
        ),
      ),
      Step(
        title: const AppText("Outros"),
        content: Column(
          children: [
            AppTextFormField(
              hintText: 'Digite aqui...',
              labelText: 'Descrição (Opcional)',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              maxLines: 5,
              onSaved: (value) => _formData['description'] = value ?? '',
              onChanged: (value) {
                _formKey.currentState?.validate();
                _formData['description'] = value ?? '';
              },
              controller: _descriptionController,
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);

    String anncounementType =
        ModalRoute.of(context)?.settings.arguments as String;

    print(anncounementType);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                title: 'Cadastrar Imóvel',
                onPressed: () {},
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(24),
                      child: AppText(
                        AppConstants.propertyTypeRent == anncounementType
                            ? 'Complete o formulário abaixo para registrar o imóvel que deseja colocar no aluguel.'
                            : 'Complete o formulário abaixo para registrar o imóvel que deseja vender.',
                        color: const Color(0xFF74778B),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                    if (_isLoading)
                      const AppLoadForm()
                    else
                      Stepper(
                        steps: getSteps(anncounementType),
                        physics: const ClampingScrollPhysics(),
                        onStepTapped: (index) {
                          setState(() {
                            _currentStep = index;
                          });
                        },
                        onStepCancel: () {
                          if (_currentStep > 0) {
                            setState(() {
                              _currentStep--;
                            });
                          }
                        },
                        currentStep: _currentStep,
                        onStepContinue: () {
                          final isLastStep = _currentStep ==
                              getSteps(anncounementType).length - 1;
                          if (isLastStep) {
                            _submitForm(anncounementType);
                          } else {
                            setState(() => _currentStep++);
                          }
                        },
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
