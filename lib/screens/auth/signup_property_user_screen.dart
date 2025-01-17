import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/show-custom-toast.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/models/Company.dart';
import 'package:reis_imovel_app/models/user_signup.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/screens/auth/components/company_user/first_page.dart';
import 'package:reis_imovel_app/screens/auth/components/company_user/quaternary_page.dart';
import 'package:reis_imovel_app/screens/auth/components/company_user/second_page.dart';
import 'package:reis_imovel_app/screens/auth/components/company_user/third_page.dart';
import 'package:reis_imovel_app/screens/auth/components/dot_indicator.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class SignUpPropertyUserScreen extends StatefulWidget {
  const SignUpPropertyUserScreen({super.key});

  @override
  State<SignUpPropertyUserScreen> createState() =>
      _SignUpPropertyUserScreenState();
}

class _SignUpPropertyUserScreenState extends State<SignUpPropertyUserScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController nifController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController nationalityController = TextEditingController();

  final TextEditingController maritalStatusController = TextEditingController();

  final TextEditingController bankNameController = TextEditingController();

  final TextEditingController bankAccountNumberController =
      TextEditingController();

  final TextEditingController bankIBANController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Form keys para validação
  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  PlatformFile? _selectedPDF;

  bool _isLoading = false;

  String urlDocument = '';

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    usernameController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    nifController.dispose();
    addressController.dispose();
    bankNameController.dispose();
    bankAccountNumberController.dispose();
    bankIBANController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void addDocument(String downloadURL) {
    setState(() {
      urlDocument = downloadURL;
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um Erro'),
        backgroundColor: whiteColor,
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
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
      // Exibe um Snackbar laranja se o formulário não for válido
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          elevation: 0,
          content: const CustomText(
            'Por favor, preencha todos os campos obrigatórios!',
            fontWeight: FontWeight.w500,
            color: whiteColor,
          ),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Faz o formulário "mostrar" os erros automaticamente
      _formKeys[_pageIndex].currentState?.validate();
    }
  }

  void _submitForm() async {
    if (_selectedPDF == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          elevation: 0,
          content: CustomText('Por favor, envie o documento em PDF.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 7),
        ),
      );

      return;
    }

    setState(() => _isLoading = true);

    Auth auth = Provider.of(context, listen: false);

    try {
      final bool uploadSuccess =
          await AppUtils.uploadPDF(_selectedPDF!, addDocument);

      if (uploadSuccess && urlDocument.isNotEmpty) {
        final user = UserSignup(
          username: usernameController.text.trim(),
          fullName: fullNameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          phone: phoneController.text.trim(),
          role: ["company"],
          nif: nifController.text.trim(),
          address: addressController.text.trim(),
          nationality: nationalityController.text.trim(),
          maritalStatus: maritalStatusController.text.trim(),
          urlDocument: urlDocument,
        );

        final company = Company(
          nif: nifController.text.trim(),
          bankName: bankNameController.text.trim(),
          bankAccountNumber: bankAccountNumberController.text.trim(),
          iban: bankIBANController.text.trim(),
        );

        await auth.signupWithCompany(user, company);

        showCustomToast("Conta criada com sucesso.");

        Navigator.pushNamed(context, AppRoutes.SUCCESS_SIGNUP_SCREEN);
      } else {
        throw Exception("Erro ao enviar o PDF.");
      }
    } on Exception catch (error) {
      _showErrorDialog(error.toString());
    } catch (e) {
      _showErrorDialog('Por favor verifique se os seus dados são válidos.');
    } finally {
      setState(() => _isLoading = false);
    }

    // Coletar os dados dos controladores
    final userData = {
      "username": usernameController.text,
      "fullName": fullNameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "phone": phoneController.text,
      "role": ["company"],
      "nif": nifController.text,
      "address": addressController.text,
      "nationality": nationalityController.text,
      "maritalStatus": maritalStatusController.text,
    };

    final companyData = {
      "nif": nifController.text,
      "bankName": bankNameController.text,
      "bankAccountNumber": bankAccountNumberController.text,
      "iban": bankIBANController.text,
    };

    print("Dados do user enviados para o backend: $userData");
    print("Dados do imobiliaria enviados para o backend: $companyData");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 24,
          color: Theme.of(context).primaryColor,
          onPressed: _validateGoBack,
        ),
        actions: [
          ...List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.only(right: defaultPadding / 4),
              child: DotIndicator(isActive: index == _pageIndex),
            ),
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
                usernameController: usernameController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              ),
              SecondPage(
                formKey: _formKeys[1],
                addressController: addressController,
                fullNameController: fullNameController,
                phoneController: phoneController,
                maritalStatusController: maritalStatusController,
                nationalityController: nationalityController,
                nifController: nifController,
              ),
              ThirdPage(
                formKey: _formKeys[2],
                bankNameController: bankNameController,
                bankAccountNumberController: bankAccountNumberController,
                bankIBANController: bankIBANController,
              ),
              QuaternaryPage(
                formKey: _formKeys[3],
                onFileSelected: (file) => _selectedPDF = file,
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
              ElevatedButton(
                onPressed: _validateAndAdvance,
                child: const Text("Continuar"),
              ),
          ],
        ),
      ),
    );
  }
}
