import 'package:dashboard/HomePage.dart';
import 'package:dashboard/pages/SignIn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DataProvider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('ar'),Locale('en') ],
      path: 'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('ar', ''),
      child: MyApp()
  ),);}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    context.locale = Locale('ar');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataProvider>(
            create: (context) => DataProvider()),
      ],
      child: MaterialApp(
        title: 'Tall3ah | لوحة التحكم',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,

        initialRoute: '/login',
        routes: {
          '/login': (context) => SignIn(),
          '/home': (context) => MainPage(),
        },

        theme: ThemeData(
      // fontFamily: 'default',

          primarySwatch: Colors.blue,
        ),
        home: SignIn(),
      ),
    );
  }
}

