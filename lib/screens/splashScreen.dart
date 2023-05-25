import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:fresh_bits_test/ConstantsClass/constants_class.dart';
import 'package:fresh_bits_test/ConstantsClass/image_paths.dart';
import 'package:fresh_bits_test/ConstantsClass/preferences_manage.dart';
import 'package:fresh_bits_test/screens/homeScreen.dart';
import 'package:fresh_bits_test/screens/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    navigateToNextScreen();

    super.initState();
  }


  navigateToNextScreen(){

    Timer(const Duration(seconds:3), () async {

      var isUserLogin = await PreferencesManage.getPreferencesValue(PreferencesManage.isUserLogin) ?? "";

      if(isUserLogin.toString() == "1"){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()));
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorWhite,
      body: Stack(
        children: [

          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 80, left: 80),
              child: SvgPicture.asset(
                ImagePaths.imgSplashLogo,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
