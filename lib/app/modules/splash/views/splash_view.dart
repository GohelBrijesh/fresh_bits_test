
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:fresh_bits_test/ConstantsClass/image_paths.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetWidget<SplashController> {

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
