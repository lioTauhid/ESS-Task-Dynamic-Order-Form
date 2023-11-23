import 'package:flutter/material.dart';
import 'package:frutter/res/constants/app_color.dart';
import 'package:frutter/res/constants/value.dart';
import 'package:get/get.dart';
import '../../../res/components/common_widgets.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_model/login_register/login_view_model.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  LoginRegViewModel loginRegViewModel = Get.put(LoginRegViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackground,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Values.appName,
                  style: TextStyle(fontSize: 38, color: AppColor.textPrimary),
                ),
                const SizedBox(
                  height: 30,
                ),
                normalTextField(
                    loginRegViewModel.emailController.value, "Email",
                    prefIcon: Icon(Icons.email, color: AppColor.textPrimary)),
                const SizedBox(
                  height: 30,
                ),
                normalTextField(
                    loginRegViewModel.passwordController.value, "Password",
                    prefIcon: Icon(
                      Icons.lock,
                      color: AppColor.textPrimary,
                    )),
                Container(
                  width: double.infinity,
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                      child: Text(
                        "forget your password",
                        style: TextStyle(color: AppColor.textSecondary),
                      ),
                      onPressed: () {}),
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: normalButton("LOGIN", AppColor.primaryColor,
                      AppColor.white, Values.fontSmall, onPressed: () {
                    loginRegViewModel.loginWithEmailPassword().then((v) {
                      if (v) {
                        Get.offNamed(RouteName.homeView);
                      } else {
                        Utils.showSnackBar("Invalid login credential!");
                      }
                    });
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
