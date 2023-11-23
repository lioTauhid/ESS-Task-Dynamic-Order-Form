import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frutter/res/constants/app_color.dart';
import 'package:frutter/res/constants/value.dart';
import 'package:frutter/res/routes/routes.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Values.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColor.primaryColor,
        secondary: AppColor.secondaryColor,
      )),
      getPages: AppRoutes.appRoutes(),
    );
  }
}
