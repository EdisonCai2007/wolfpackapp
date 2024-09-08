import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolfpackapp/firebase_options.dart';
import 'package:wolfpackapp/models_services/teachassist_model.dart';
import 'package:wolfpackapp/models_services/uhs_teachers_model.dart';
import 'package:wolfpackapp/screens/contact_teachers_screen.dart';
import 'package:wolfpackapp/screens/courses_screen/courses_screen.dart';
import 'package:wolfpackapp/screens/guidance_screen/guidance_screen.dart';
import 'package:wolfpackapp/screens/login_screen.dart';
import 'package:wolfpackapp/shared_prefs.dart';
import 'package:wolfpackapp/themes/theme_manager.dart';

import 'screens/settings_screen.dart';
import 'screens/home_screen/home_screen.dart';

import 'dart:io';


// - 🏁 START HERE 🏁 -
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HttpOverrides.global = MyHttpOverrides();

  await sharedPrefs.init();
  if (sharedPrefs.username != '' && sharedPrefs.password != '') await TeachAssistModel().init();
  UHSTeachersModel().init();

  runApp(
    ChangeNotifierProvider(
        create: (context) => ThemeManager(),
      child: const MyApp(),
    )
  );
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host,
          int port) => true;
  }
}


// MyApp Widget; Holds Themes and Pages
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: (sharedPrefs.username == '' && sharedPrefs.password == '') ? const LoginScreen() : const HomeScreen(),
      routes: {
        '/loginScreen': (context) => const LoginScreen(),
        '/homeScreen': (context) => const HomeScreen(),
        '/contactTeachersScreen': (context) => const ContactTeachersScreen(),
        '/guidanceScreen': (context) => const GuidanceScreen(),
        '/coursesScreen': (context) => const CoursesScreen(),
        '/settingsScreen': (context) => const SettingsScreen(),
      },
      title: 'UHS Student Tools',

      theme: Provider.of<ThemeManager>(context).themeData,
    );
  }
}
