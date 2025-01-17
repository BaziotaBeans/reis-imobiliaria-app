import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
// import 'package:reis_imovel_app/screens/auth/components/login_form.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isEnable = false;

  final Map<String, String> _authData = {
    'userName': '',
    'password': '',
  };

  bool _isLoading = false;

  bool isObscure = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void validateSubmitButton() {
    bool isValid = true;

    isValid = _userNameController.text.isNotEmpty &&
        _userNameController.text.length >= 5 &&
        _passwordController.text.isNotEmpty &&
        _passwordController.text.length >= 5;

    setState(() {
      isEnable = isValid;
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um Erro'),
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

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    try {
      await auth.login(
        _authData['userName']!,
        _authData['password']!,
      );

      debugPrint('#############################');
      debugPrint('LOGIN FEITO NO COMPONENTE');
      debugPrint('#############################');

      Navigator.of(context).pushReplacementNamed(AppRoutes.Home);
    } on Exception catch (error) {
      print('ERRO');
      print(error);
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Por favor verifique se os seus dados são válidos.');

      print(error);
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/woman-house.jpg",
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bem vindo de volta!",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    const Text(
                      "Faça login com os dados que você inseriu durante seu registro.",
                    ),
                    const SizedBox(height: defaultPadding),
                    // LogInForm(formKey: _formKey),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onSaved: (userName) =>
                                _authData['userName'] = userName ?? '',
                            controller: _userNameController,
                            validator: userNameValidator.call,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Nome de usuário",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: defaultPadding * 0.75),
                                child: SvgPicture.asset(
                                  "assets/icons/User - Normal.svg",
                                  height: 24,
                                  width: 24,
                                  colorFilter: ColorFilter.mode(
                                      Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withOpacity(0.3),
                                      BlendMode.srcIn),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          TextFormField(
                            onSaved: (password) =>
                                _authData['password'] = password ?? '',
                            validator: passwordValidator.call,
                            obscureText: isObscure,
                            decoration: InputDecoration(
                              hintText: "Digite a senha",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: defaultPadding * 0.75),
                                child: SvgPicture.asset(
                                  "assets/icons/Lock.svg",
                                  height: 24,
                                  width: 24,
                                  colorFilter: ColorFilter.mode(
                                      Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withOpacity(0.3),
                                      BlendMode.srcIn),
                                ),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(48, 48)),
                                  ),
                                  icon: Icon(
                                    isObscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      child: TextButton(
                        child: const Text("Esqueci a senha"),
                        onPressed: () {
                          // Navigator.pushNamed(
                          //     context, passwordRecoveryScreenRoute);
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height > 700
                          ? size.height * 0.1
                          : defaultPadding,
                    ),
                    if (_isLoading)
                      const Center(
                          child: CircularProgressIndicator(color: primaryColor))
                    else
                      ElevatedButton(
                        onPressed: _submit,
                        // onPressed: () {
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context,
                        //     entryPointScreenRoute,
                        //     ModalRoute.withName(logInScreenRoute));
                        // if (_formKey.currentState!.validate()) {
                        //   Navigator.pushNamedAndRemoveUntil(
                        //       context,
                        //       entryPointScreenRoute,
                        //       ModalRoute.withName(logInScreenRoute));
                        // }
                        // },
                        child: const Text("Entrar"),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Não tem uma conta?"),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.SELECT_USER_TYPE);
                            // Navigator.pushNamed(context, selectUserTypeScreenRoute);
                          },
                          child: const Text("Criar conta"),
                        )
                      ],
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
