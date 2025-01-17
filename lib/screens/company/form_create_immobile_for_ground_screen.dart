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
import 'package:reis_imovel_app/data/property_status_data.dart';
import 'package:reis_imovel_app/data/province_data.dart';
import 'package:reis_imovel_app/models/PropertyList.dart';
import 'package:reis_imovel_app/models/Schedule.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_validators.dart';

class FormCreateImmobileForGround extends StatefulWidget {
  const FormCreateImmobileForGround({super.key});

  @override
  State<FormCreateImmobileForGround> createState() =>
      _FormCreateImmobileForGroundState();
}

class _FormCreateImmobileForGroundState
    extends State<FormCreateImmobileForGround> {
  final _formKey = GlobalKey<FormState>();

  final _formData = <String, Object>{};

  bool _isLoading = false;

  String updateProvinceValueState = '';

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _provinceController = TextEditingController();

  final TextEditingController _countyController = TextEditingController();

  final TextEditingController _streetController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _totalAreaController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _selectedStatusController =
      TextEditingController();

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
    List<MediaFile> mediaFiles = await GalleryPicker.pickMedia(
          context: context,
          singleMedia: false,
          // config:
        ) ??
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

  Future<void> _submitForm(String propertyType) async {
    setState(() => _isLoading = true);

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
      debugPrint('Error: ${e.toString()}');

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
        title: const AppText('Características'),
        content: Column(
          children: [
            AppTextFormField(
              hintText: 'Digite a área total',
              labelText: 'Área total (m²)',
              helperText: 'Área total do terreno, medido em m².',
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
            AppTextFormField(
              hintText: 'Digite o preço',
              labelText: 'Preço da compra',
              helperText:
                  'Por favor, insira o preço de compra do terreno dentro da faixa correspondente.',
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
        title: const AppText("Images do terreno"),
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
    String anncounementType =
        ModalRoute.of(context)?.settings.arguments as String;

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
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: AppText(
                      'Complete o formulário abaixo para registrar o imóvel que deseja vender.',
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
                    )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
