import 'package:flutter/material.dart';
import 'package:frutter/res/constants/app_color.dart';
import 'package:frutter/res/constants/value.dart';
import 'package:get/get.dart';

import '../../res/components/common_widgets.dart';
import '../../res/routes/routes_name.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primaryBackground,
        appBar: AppBar(
          title: const Text("Home Page"),
        ),
        body: SizedBox(
          width: Size.infinite.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: normalButton("Custom order", AppColor.primaryColor,
                    AppColor.white, Values.fontBig, onPressed: () {
                  Get.toNamed(RouteName.customOrderView);
                }),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                width: 200,
                child: normalButton("Feedback", AppColor.primaryColor,
                    AppColor.white, Values.fontBig, onPressed: () {
                  Get.toNamed(RouteName.feedbackView);
                }),
              ),
            ],
          ),
        ));
  }
}
