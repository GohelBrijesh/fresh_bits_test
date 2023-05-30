import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fresh_bits_test/ConstantsClass/constants_class.dart';
import 'package:fresh_bits_test/ConstantsClass/preferences_manage.dart';
import 'package:fresh_bits_test/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  var formKey = GlobalKey<FormState>();

  FocusNode focusNodeUsername = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var obscureText = true.obs;

  onClickSignInButton(){
    if (formKey.currentState!.validate()) {
      ConstantsClass.hideKeyboad();
      var username = usernameController.text.toString().trim();
      var password = passwordController.text.toString().trim();
      if(username == "admin" && password == "123456"){
        ConstantsClass.toastMessage("Login successfully.");
        PreferencesManage.setPreferencesValue(PreferencesManage.isUserLogin,"1");
        Get.offAllNamed(Routes.HOME);
      }else{
        ConstantsClass.toastMessage("Please enter valid username and password.");
      }

    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
