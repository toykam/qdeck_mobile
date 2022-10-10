import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khoot/frontend/providers/auth_provider.dart';
import 'package:khoot/frontend/providers/my_deck_provider.dart';
import 'package:khoot/frontend/route/routes.dart';
import 'package:khoot/service_locator.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => MyDeckProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  final botBuilder = BotToastInit();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: appRoutes,
          // routerDelegate: appRoutes.routerDelegate,
          // routeInformationParser: appRoutes.routeInformationParser,
          // routeInformationProvider: appRoutes.routeInformationProvider,
          title: 'QDeck',
          theme: ThemeData.dark(),
          builder: (context, child) {

            return botBuilder(context, child);
          },
        );
      },
    );
  }
}

