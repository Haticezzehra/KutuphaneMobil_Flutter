import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:kutuphane_mobil/Views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 153, 140, 175)),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
                centerTitle: true,
                systemOverlayStyle: SystemUiOverlayStyle.light,
                backgroundColor: Color.fromARGB(255, 131, 83, 202))),
        home: const SplashScreen());
  }
}
