import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/user_update_form.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/dto/PropertyTypeEntity.dart';
import 'package:reis_imovel_app/firebase_options.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/models/ContractList.dart';
import 'package:reis_imovel_app/models/OrderList.dart';
import 'package:reis_imovel_app/models/PropertyList.dart';
import 'package:reis_imovel_app/models/PropertyScheduleList.dart';
import 'package:reis_imovel_app/models/SchedulingList.dart';
import 'package:reis_imovel_app/screens/auth/reset-password.dart';
import 'package:reis_imovel_app/screens/auth/select-user-type.dart';
import 'package:reis_imovel_app/screens/auth/sign-in.dart';
import 'package:reis_imovel_app/screens/auth/sign-up-client.dart';
import 'package:reis_imovel_app/screens/auth/sign-up-company.dart';
import 'package:reis_imovel_app/screens/auth/sign-up.dart';
import 'package:reis_imovel_app/screens/auth_or_home_page.dart';
import 'package:reis_imovel_app/screens/client/all_immobile_screen.dart';
import 'package:reis_imovel_app/screens/client/contract_list_screen.dart';
import 'package:reis_imovel_app/screens/client/order_reference_list_screen.dart';
import 'package:reis_imovel_app/screens/client/order_reference_screen.dart';
import 'package:reis_imovel_app/screens/client/payment_method_reference_screen.dart';
import 'package:reis_imovel_app/screens/client/payment_method_screen.dart';
import 'package:reis_imovel_app/screens/client/payment_method_transfer_screen.dart';
import 'package:reis_imovel_app/screens/client/payment_success_screen.dart';
import 'package:reis_imovel_app/screens/client/result_search_screen.dart';
import 'package:reis_imovel_app/screens/company/announcement_preview_detail_screen.dart';
import 'package:reis_imovel_app/screens/company/form_create_immobile_for_ground_screen.dart';
import 'package:reis_imovel_app/screens/company/form_create_immobile_for_rent_screen.dart';
import 'package:reis_imovel_app/screens/company/select_announcement_sale_type_screen.dart';
import 'package:reis_imovel_app/screens/company/select_announcement_type.dart';
import 'package:reis_imovel_app/screens/company/tabs_screen.dart';
import 'package:reis_imovel_app/screens/contract_screen.dart';
import 'package:reis_imovel_app/screens/file_upload_screen.dart';
import 'package:reis_imovel_app/screens/client/immobile_detail_screen.dart';
import 'package:reis_imovel_app/screens/client/latest_announcement_screen.dart';
import 'package:reis_imovel_app/screens/multi_step_form_screen.dart';
import 'package:reis_imovel_app/screens/onboarding_screen.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppUtils.signInUserAnon();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, PropertyList>(
          create: (_) => PropertyList(),
          update: (ctx, auth, previous) {
            return PropertyList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.propertiesCompany ?? <PropertyResult>[],
              previous?.propertiesPublic ?? <PropertyResult>[],
              previous?.propertyTypes ?? <PropertyTypeEntity>[],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, PropertyScheduleList>(
            create: (_) => PropertyScheduleList(),
            update: (ctx, auth, previous) {
              return PropertyScheduleList(
                  auth.token ?? '',
                  previous?.propertiesSchedule ?? [],
                  previous?.propertiesAvailableSchedules ?? []);
            }),
        ChangeNotifierProxyProvider<Auth, SchedulingList>(
            create: (_) => SchedulingList(),
            update: (ctx, auth, previous) {
              return SchedulingList(
                auth.token ?? '',
                auth.userId ?? '',
                previous?.schedulingsByUser ?? [],
                previous?.schedulingsByCompany ?? [],
              );
            }),
        ChangeNotifierProxyProvider<Auth, OrderList>(
            create: (_) => OrderList(),
            update: (ctx, auth, previous) {
              return OrderList(
                auth.token ?? '',
                auth.userId ?? '',
                previous?.currentOrder,
                previous?.ordersByUser ?? [],
              );
            }),
        ChangeNotifierProxyProvider<Auth, ContractList>(
            create: (_) => ContractList(),
            update: (ctx, auth, previous) {
              return ContractList(
                auth.token ?? '',
                auth.userId ?? '',
                previous?.contracts ?? <Contract>[],
                previous?.contractsByCompany ?? <Contract>[],
              );
            }),
      ],
      child: MaterialApp(
        title: 'Reis Imóvel',
        theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
                primary: const Color(0xFF1886F9), secondary: Colors.white),
            scaffoldBackgroundColor: const Color.fromRGBO(249, 249, 249, 1),
            bottomSheetTheme:
                const BottomSheetThemeData(backgroundColor: Colors.white)
            // useMaterial3: true
            ),
        // localizationsDelegates: const [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate
        // ],
        // supportedLocales: [const Locale('pt', 'BR')],
        debugShowCheckedModeBanner: false,
        // initialRoute: AppRoutes.ONBOARDING_SCREEN,
        // initialRoute: AppRoutes.ORDER_REFERENCE_LIST_SCREEN,
        routes: {
          AppRoutes.Home: (ctx) => const AuthOrHomeScreen(),
          AppRoutes.SIGN_IN: (ctx) => const SignInScreen(),
          AppRoutes.SIGN_UP_CLIENT: (ctx) => const SignUpClientScreen(),
          AppRoutes.SIGN_UP_COMPANY: (ctx) => const SignUpCompany(),
          AppRoutes.RESET_PASSWORD: (ctx) => const ResetPasswordScreen(),
          AppRoutes.SELECT_USER_TYPE: (ctx) => const SelectUserTypeScreen(),
          AppRoutes.IMMOBILE_DETAIL_SCREEN: (ctx) =>
              const ImmobileDetailScreen(),
          AppRoutes.PAYMENT_METHOD_SCREEN: (ctx) => const PaymentMethodScreen(),
          AppRoutes.PAYMENT_METHOD_TRANSFER_SCREEN: (ctx) =>
              const PaymentMethodTransferScreen(),
          AppRoutes.PAYMENT_METHOD_REFERENCE_SCREEN: (ctx) =>
              const PaymentMethodReferenceScreen(),
          AppRoutes.PAYMENT_SUCCESS_SCREEN: (ctx) =>
              const PaymentSuccessScreen(),
          AppRoutes.ANNOUNCEMENT_SCREEN: (ctx) => const TabsScreenCompany(),
          AppRoutes.SELECT_ANNOUNCEMENT_TYPE: (ctx) =>
              const SelectAnnouncementTypeScreen(),
          AppRoutes.FormCreateImmboleForRent: (ctx) =>
              const FormCreateImmboleForRent(),
          AppRoutes.FormCreateImmboleForGround: (ctx) =>
              const FormCreateImmobileForGround(),
          AppRoutes.AnnouncementPreviewDetail: (ctx) =>
              const AnnouncementPreviewDetailScreen(),
          AppRoutes.SELECT_ANNOUNCEMENT_SALE_TYPE: (ctx) =>
              const SelectAnnouncementSaleTypeScreen(),
          AppRoutes.CONTRACT_SCREEN: (ctx) => const ContractScreen(),
          AppRoutes.CONTRACT_LIST: (ctx) => const ContractListScreen(),
          AppRoutes.MULTI_STEP_FORM: (ctx) => const MultiStepForm(),
          AppRoutes.FILE_UPLOAD: (ctx) => const FileUploadScreen(),
          AppRoutes.USER_UPDATE_FORM_SCREEN: (ctx) => const UserUpdateForm(),
          AppRoutes.ORDER_REFERENCE_LIST_SCREEN: (ctx) =>
              const OrderReferenceListScreen(),
          AppRoutes.ORDER_REFERENCE_SCREEN: (ctx) =>
              const OrderReferenceScreen(),
          AppRoutes.LATEST_ANNOUNCEMENT_SCREEN: (ctx) =>
              const LatestAnnouncementScreen(),
          AppRoutes.ALL_IMMOBILE_SCREEN: (ctx) => const AllImmobileScreen(),
          AppRoutes.RESULT_SEARCH_SCREEN: (ctx) => const ResultSearchScreen(),
          AppRoutes.ONBOARDING_SCREEN: (ctx) => const OnboardingScreen(),
        },
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

//useMaterial3: true,