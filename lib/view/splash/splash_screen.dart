import 'package:flutter/material.dart';
import 'package:frutter/res/constants/value.dart';
import 'package:get/get.dart';

import '../../res/constants/app_color.dart';
import '../../view_model/splash/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashScreen = SplashController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
          child: Text(
        'Welcome Back'.tr,
        style: const TextStyle(color: AppColor.white, fontSize: Values.fontBig),
      )),
    );
  }
}
