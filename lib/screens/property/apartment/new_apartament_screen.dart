import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/components/new/dialog_widget.dart';
import 'package:reis_imovel_app/components/new/snackbar_bar_widget.dart';
import 'package:reis_imovel_app/components/new/toast_widget.dart';
import 'package:reis_imovel_app/models/PropertyList.dart';
import 'package:reis_imovel_app/screens/property/apartment/pages/fifth_page.dart';
import 'package:reis_imovel_app/screens/property/apartment/pages/first_page.dart';
import 'package:reis_imovel_app/screens/property/apartment/pages/fourth_page.dart';
import 'package:reis_imovel_app/screens/property/apartment/pages/second_page.dart';
import 'package:reis_imovel_app/screens/property/apartment/pages/sixth_page.dart';
import 'package:reis_imovel_app/screens/property/apartment/pages/third_page.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/models/Schedule.dart';
import 'package:reis_imovel_app/validators/new_apartment_form_validator.dart';

class NewApartmentScreen extends StatefulWidget {
  const NewApartmentScreen({super.key});

  @override
  State<NewApartmentScreen> createState() => _NewApartmentScreenState();
}

class _NewApartmentScreenState extends State<NewApartmentScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  bool _isLoading = false;

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController provinceController = TextEditingController();

  final TextEditingController countyController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController totalAreaController = TextEditingController();

  final TextEditingController suitsController = TextEditingController();

  final TextEditingController roomController = TextEditingController();

  final TextEditingController bathroomController = TextEditingController();

  final TextEditingController vacancyController = TextEditingController();

  final TextEditingController paymentMethodController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController latitudeController = TextEditingController();

  final TextEditingController longitudeController = TextEditingController();

  List<MediaFile> selectedFiles = [];

  List<String> images = [];

  List<Schedule> selectedSchedules = [];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    provinceController.dispose();
    countyController.dispose();
    addressController.dispose();
    totalAreaController.dispose();
    suitsController.dispose();
    addressController.dispose();
    roomController.dispose();
    bathroomController.dispose();
    vacancyController.dispose();
    paymentMethodController.dispose();
    priceController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (selectedFiles.isEmpty) {
      SnackBarWidget.showError(
        context: context,
        message: 'Por favor as imagens.',
      );

      return;
    }

    if (selectedSchedules.isEmpty) {
      SnackBarWidget.showError(
        context: context,
        message: 'Por favor selecione os horários de agendamentos.',
      );

      return;
    }

    String propertyType = ModalRoute.of(context)?.settings.arguments as String;

    if (propertyType.isEmpty) {
      SnackBarWidget.showError(
        context: context,
        message: 'Ocorreu um erro!',
      );

      return;
    }

    setState(() => _isLoading = true);

    try {
      bool success = await AppUtils.uploadMultipleFilesForUser(
          selectedFiles, addImageToImageList);

      if (!success) {
        ToastWidget.showErrorToast("Não foi possível salvar os dados");
        setState(() => _isLoading = false);
        return;
      }

      final formData = {
        'title': validateStringFormData(titleController.text.trim()),
        'description':
            validateStringFormData(descriptionController.text.trim()),
        'province': validateStringFormData(provinceController.text.trim()),
        'county': validateStringFormData(countyController.text.trim()),
        'address': validateStringFormData(addressController.text.trim()),
        'suits': validateIntFormData(suitsController.text.trim()),
        'room': validateIntFormData(roomController.text.trim()),
        'bathroom': validateIntFormData(bathroomController.text.trim()),
        'vacancy': validateIntFormData(vacancyController.text.trim()),
        'price': validateDoubleFormData(priceController.text.trim()),
        'totalArea': validateDoubleFormData(totalAreaController.text.trim()),
        'buildingArea': 0.0,
        'paymentModality':
            validateStringFormData(paymentMethodController.text.trim()),
        'status': true,
        'fkPropertyType': propertyType,
        'images': images,
        'propertyStatus': 'PUBLISHED',
        'schedules': selectedSchedules,
        'latitude': validateDoubleFormData(latitudeController.text.trim()),
        'longitude': validateDoubleFormData(longitudeController.text.trim()),
      };

      if (mounted) {
        await Provider.of<PropertyList>(
          context,
          listen: false,
        ).saveProperty(formData);
      }

      ToastWidget.showSuccessToast("Dados salvo com sucesso");

      if (mounted) {
        Navigator.of(context).pushNamed(AppRoutes.SUCCESS_NEW_PROPERTY_SCREEN);
      }

      debugPrint('########################');
      debugPrint('$formData');
      debugPrint('########################');
    } catch (e) {
      DialogWidget.showSuccessDialog(
        context: context,
        title: 'Ocorreu um erro!',
        message: 'Ocorreu um erro para salvar o imovel/propriedade.',
      );

      debugPrint('##########ERRO##########');
      debugPrint('$e');
      debugPrint('#########################');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _validateAndAdvance() {
    final isValid = _formKeys[_pageIndex].currentState?.validate() ?? false;

    if (isValid) {
      if (_pageIndex < _formKeys.length - 1) {
        setState(() {
          _pageController.nextPage(
            curve: Curves.ease,
            duration: const Duration(milliseconds: 300),
          );
          _pageIndex++;
        });
      } else {
        _submitForm();
      }
    } else {
      SnackBarWidget.showWarning(
        context: context,
        message: 'Por favor, preencha todos os campos obrigatórios!',
      );

      // Faz o formulário "mostrar" os erros automaticamente
      _formKeys[_pageIndex].currentState?.validate();
    }
  }

  void _validateGoBack() {
    if (_pageIndex > 0) {
      setState(() {
        _pageController.previousPage(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 300),
        );
        _pageIndex--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void handleAddAddress(
    String address,
    String province,
    String county,
    double latitude,
    double longitude,
  ) {
    provinceController.text = province;
    addressController.text = address;
    countyController.text = county;
    latitudeController.text = latitude.toString();
    longitudeController.text = longitude.toString();
  }

  void _updateSchedule(List<Schedule> schedules) {
    setState(() {
      selectedSchedules = schedules;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    String propertyType = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const CustomText(
          'Adicionar Imóvel',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 24,
          color: Theme.of(context).primaryColor,
          onPressed: _validateGoBack,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: defaultPadding),
            child: CustomText('${_pageIndex + 1}/${_formKeys.length}'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SizedBox(
          height: double.infinity,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              FirstPage(
                formKey: _formKeys[0],
                titleController: titleController,
                descriptionController: descriptionController,
              ),
              SecondPage(
                formKey: _formKeys[1],
                bathroomController: bathroomController,
                roomController: roomController,
                suitsController: suitsController,
                totalAreaController: totalAreaController,
                vacancyController: vacancyController,
              ),
              ThirdPage(
                formKey: _formKeys[2],
                addressController: addressController,
                countyController: countyController,
                provinceController: provinceController,
                onAddAddress: handleAddAddress,
                latitudeController: latitudeController,
                longitudeController: longitudeController,
              ),
              FourthPage(
                formKey: _formKeys[3],
                onUpdateSchedule: _updateSchedule,
                selectedSchedules: selectedSchedules,
              ),
              FifthPage(
                formKey: _formKeys[4],
                paymentMethodController: paymentMethodController,
                priceController: priceController,
                propertyType: propertyType,
              ),
              SixthPage(
                formKey: _formKeys[5],
                onRemoveImageFromSelectedFiles: removeImageFromSelectedFiles,
                onSelectFile: selectFile,
                selectedFiles: selectedFiles,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isLoading)
              const Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
              ))
            else
              CustomButton(
                text: 'Continuar',
                onPressed: _validateAndAdvance,
              )
          ],
        ),
      ),
    );
  }
}
