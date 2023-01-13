import 'package:device_preview/device_preview.dart';
import 'package:elagk_delivery/auth/presentation/controller/confim_password/confirm_password_cubit.dart';
import 'package:elagk_delivery/auth/presentation/controller/forget_passord_controller/forget_password_cubit.dart';
import 'package:elagk_delivery/auth/presentation/controller/login_controller/login_cubit.dart';
import 'package:elagk_delivery/auth/presentation/controller/otp_password/otp_password_cubit.dart';
import 'package:elagk_delivery/auth/presentation/controller/reset_password_controller/reset_password_cubit.dart';
import 'package:elagk_delivery/drawer/presentation/controller/about_us_controller/about_us_cubit.dart';
import 'package:elagk_delivery/drawer/presentation/controller/contact_us_controller/contact_us_cubit.dart';
import 'package:elagk_delivery/drawer/presentation/controller/profile_controller/profile_cubit.dart';
import 'package:elagk_delivery/home/presentation/controllers/home_screen_controller/home_screen_cubit.dart';
import 'package:elagk_delivery/home/presentation/controllers/order_controller/order_cubit.dart';
import 'package:elagk_delivery/notification/controller/notification_cubit.dart';
import 'package:elagk_delivery/shared/bloc_observer.dart';
import 'package:elagk_delivery/shared/config/noti.dart';
import 'package:elagk_delivery/shared/local/shared_preference.dart';
import 'package:elagk_delivery/shared/network/dio_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'shared/global/app_theme.dart';
import 'shared/utils/app_routes.dart';
import 'shared/utils/app_strings.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) {

      // initialise the plugin of flutter local notifications.
      FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();

      // app_icon needs to be a added as a drawable
      // resource to the Android head project.
      var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
      var IOS = new DarwinInitializationSettings();

      // initialise settings for both Android and iOS device.
      var settings = new InitializationSettings(android: android, iOS: IOS);
      flip.initialize(settings);

      return Future.value(true);
    });
  }
  Workmanager().initialize(

    // The top level function, aka callbackDispatcher
      callbackDispatcher,

      // If enabled it will post a notification whenever
      // the task is running. Handy for debugging tasks
      isInDebugMode: true
  );

  // Periodic task registration
  Workmanager().registerPeriodicTask(
    "2",

    //This is the value that will be
    // returned in the callbackDispatcher
    "simplePeriodicTask",

    // When no frequency is provided
    // the default 15 minutes is set.
    // Minimum frequency is 15 min.
    // Android will automatically change
    // your frequency to 15 min
    // if you have configured a lower frequency.
    frequency: Duration(minutes: 15),
  );
  // await Firebase.initializeApp();
  // await initFCM(); // TODO: enable it after adding app notifications.
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  CacheHelper.init();

  Noti.initialize(flutterLocalNotificationsPlugin);
  // initializeFancyCart(
  //   child: MyApp(),
  // );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.dark, // For iOS (dark icons)
    ),
  );

  runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // const MyApp._internal();
  //
  // static const MyApp instance = MyApp._internal();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:
        [
          BlocProvider(create: (BuildContext context) =>LoginCubit()),
          BlocProvider(create: (BuildContext context) =>ForgetPasswordCubit()),
          BlocProvider(create: (BuildContext context) =>ResetPasswordCubit()),
          BlocProvider(create: (BuildContext context) =>OtpPasswordCubit()),
          BlocProvider(create: (BuildContext context) =>ConfirmPasswordCubit()),
          BlocProvider(create: (BuildContext context) =>ProfileCubit()..getUserProfileData()),
          BlocProvider(create: (BuildContext context) =>ContactUsCubit()..getContactUs()),
          BlocProvider(create: (BuildContext context) =>AboutUsCubit()..getAboutUs()),
          BlocProvider(create: (BuildContext context) =>OrderCubit()),
          BlocProvider(create: (BuildContext context) =>NotificationCubit()..getNotifications()),
          BlocProvider(create: (BuildContext context) =>HomeScreenCubit()..getNotifications()..checkNotifications()..getUserProfileData()..getOrders()),
        ],
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      onGenerateRoute: RouteGenerator.getRoute,
      theme: lightTheme,
      title: AppStrings.appTitle,
    )
    );
  }
}

