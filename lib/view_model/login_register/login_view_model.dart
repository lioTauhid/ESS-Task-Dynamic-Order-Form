import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginRegViewModel extends GetxController {
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  Future<bool> loginWithEmailPassword() async {
    if (emailController.value.text == "esssumon@gmail.com" &&
        passwordController.value.text == "admin") {
      return true;
    } else {
      return false;
    }
  }
}
