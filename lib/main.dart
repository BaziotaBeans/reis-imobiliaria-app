import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/user_update_form.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/dto/PropertyTypeEntity.dart';
import 'package:reis_imovel_app/firebase_options.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/models/ContractList.dart';
import 'package:reis_imovel_app/models/OrderList.dart';
import 'package:reis_imovel_app/models/PaymentList.dart';
import 'package:reis_imovel_app/models/PropertyList.dart';
import 'package:reis_imovel_app/models/PropertyScheduleList.dart';
import 'package:reis_imovel_app/models/SchedulingList.dart';
import 'package:reis_imovel_app/screens/property/apartment/new_apartament_screen.dart';
import 'package:reis_imovel_app/screens/property/select_property_type_screen.dart';
import 'package:reis_imovel_app/screens/property/success_new_property_screen.dart';
import 'package:reis_imovel_app/screens/property/terrain/new_terrain_screen.dart';
import 'package:reis_imovel_app/theme/app_theme.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/route/screen_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppUtils.signInUserAnon();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                previous?.propertiesAvailableSchedules ?? [],
              );
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
                previous?.currentContract,
              );
            }),
        ChangeNotifierProxyProvider<Auth, PaymentList>(
          create: (_) => PaymentList(),
          update: (ctx, auth, previous) {
            return PaymentList(
              auth.token ?? '',
              previous?.currentPayment,
            );
          },
        )
      ],
      child: MaterialApp(
        title: 'Reis Imóvel',
        // builder: (context, child) => AccessibilityTools(
        //   minimumTapAreas: const MinimumTapAreas(
        //     mobile: 1,
        //     desktop: 1,
        //   ),
        //   enableButtonsDrag: true,
        //   logLevel: LogLevel.warning,
        //   checkImageLabels: true,
        //   checkFontOverflows: true,
        //   child: child,
        // ),
        theme: AppTheme.lightTheme(context),
        themeMode: ThemeMode.light,
        // localizationsDelegates: const [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate
        // ],
        // supportedLocales: [const Locale('pt', 'BR')],
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.Home,
        // initialRoute: AppRoutes.ORDER_REFERENCE_LIST_SCREEN,
        routes: {
          AppRoutes.Home: (ctx) => const AuthOrHomeScreen(),
          AppRoutes.SIGN_IN: (ctx) => const LoginScreen(),
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
          AppRoutes.PAYMENT_MULTICAIXA_EXPRESS_SCREEN: (ctx) =>
              const PaymentMulticaixaExpressScreen(),
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
          AppRoutes.SIGNUP_NORMAL_USER_SCREEN: (ctx) =>
              const SignUpNormalUserScreen(),
          AppRoutes.SIGNUP_PROPERTY_USER_SCREEN: (ctx) =>
              const SignUpPropertyUserScreen(),
          AppRoutes.SUCCESS_SIGNUP_SCREEN: (ctx) => const SuccessSignUpScreen(),
          AppRoutes.PAYMENT_MULTICAIXA_EXPRESS_SUCCESS_SCREEN: (ctx) =>
              const PaymentMulticaixaExpressSuccess(),
          AppRoutes.SELECT_PROPERTY_TYPE_SCREEN: (ctx) =>
              const SelectPropertyTypeScreen(),
          AppRoutes.NEW_APARTMENT_SCREEN: (ctx) => const NewApartmentScreen(),
          AppRoutes.SUCCESS_NEW_PROPERTY_SCREEN: (ctx) =>
              const SuccessNewPropertyScreen(),
          AppRoutes.NEW_TERRAIN_SCREEN: (ctx) => const NewTerrainScreen(),
        },
      ),
    );
  }
}
