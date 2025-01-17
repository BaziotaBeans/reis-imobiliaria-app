import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/components/new/snackbar_bar_widget.dart';
import 'package:reis_imovel_app/components/show-custom-toast.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/models/Client.dart';
import 'package:reis_imovel_app/models/user_signup.dart';
import 'package:reis_imovel_app/screens/auth/components/dot_indicator.dart';
import 'package:reis_imovel_app/screens/auth/components/normal_user/first_page.dart';
import 'package:reis_imovel_app/screens/auth/components/normal_user/second_page.dart';
import 'package:reis_imovel_app/screens/auth/components/normal_user/third_page.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class SignUpNormalUserScreen extends StatefulWidget {
  const SignUpNormalUserScreen({super.key});

  @override
  State<SignUpNormalUserScreen> createState() => _SignUpNormalUserScreenState();
}

class _SignUpNormalUserScreenState extends State<SignUpNormalUserScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  final _formPageSize = 3;

  // Form keys para validação
  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  PlatformFile? _selectedPDF;

  bool _isLoading = false;

  // Controladores dos campos
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController nifController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController nationalityController = TextEditingController();

  final TextEditingController maritalStatusController = TextEditingController();

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
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    nifController.dispose();
    phoneController.dispose();
    addressController.dispose();
    nationalityController.dispose();
    maritalStatusController.dispose();
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
      SnackBarWidget.showError(
        context: context,
        message: 'Por favor selecione o documento e envie o documento em PDF.',
      );

      return;
    }

    setState(() => _isLoading = true);

    Auth auth = Provider.of(context, listen: false);

    try {
      final bool uploadSuccess =
          await AppUtils.uploadPDF(_selectedPDF!, addDocument);

      if (uploadSuccess && urlDocument.isNotEmpty) {
        // Coletar os dados dos controladores
        final formData = {
          "username": usernameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text,
          "fullName": fullNameController.text.trim(),
          "nif": nifController.text.trim(),
          "phone": phoneController.text.trim(),
          "address": addressController.text.trim(),
          "nationality": nationalityController.text.trim(),
          "maritalStatus": maritalStatusController.text.trim(),
        };

        final user = UserSignup(
          username: usernameController.text.trim(),
          fullName: fullNameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          phone: phoneController.text.trim(),
          role: ["user"],
          nif: nifController.text.trim(),
          address: addressController.text.trim(),
          nationality: nationalityController.text.trim(),
          maritalStatus: maritalStatusController.text.trim(),
          urlDocument: urlDocument,
        );

        final client = Client(nif: nifController.text.trim());

        await auth.signupWithClient(user, client);

        showCustomToast("Conta criada com sucesso.");

        print("Dados enviados para o backend: $formData");

        Navigator.pushNamed(context, AppRoutes.SUCCESS_SIGNUP_SCREEN);
      } else {
        throw Exception("Erro ao enviar o PDF.");
      }
    } on Exception catch (error) {
      _showErrorDialog(error.toString());
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     elevation: 0,
      //     content: CustomText('Falha no envio do PDF.'),
      //     backgroundColor: Colors.red,
      //     behavior: SnackBarBehavior.floating,
      //   ),
      // );

      _showErrorDialog('Por favor verifique se os seus dados são válidos.');
    } finally {
      setState(() => _isLoading = false);
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
            3,
            (index) => Padding(
              padding: EdgeInsets.only(right: defaultPadding / _formPageSize),
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
                onFileSelected: (file) => _selectedPDF = file,
              ),
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
