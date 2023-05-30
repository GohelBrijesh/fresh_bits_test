import 'dart:async';
import 'package:fresh_bits_test/ConstantsClass/preferences_manage.dart';
import 'package:fresh_bits_test/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  @override
  Future<void> onInit() async {
    navigateToNextScreen();
    super.onInit();
  }

  navigateToNextScreen(){

    Timer(const Duration(seconds:3), () async {

      var isUserLogin = await PreferencesManage.getPreferencesValue(PreferencesManage.isUserLogin) ?? "";

      if(isUserLogin.toString() == "1"){
        Get.offAllNamed(Routes.HOME);
      }else{
        Get.offAllNamed(Routes.LOGIN);
      }

    });
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
