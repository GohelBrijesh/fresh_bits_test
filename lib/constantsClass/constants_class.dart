
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:google_fonts/google_fonts.dart';



class ConstantsClass{

  static var fontFamily = GoogleFonts.urbanist().fontFamily;
  static var currencySymbol  = "₹";

  static hideKeyboad(){
    FocusManager.instance.primaryFocus?.unfocus();
  }
  static logPrint(var message){

    if(kDebugMode){
      print("$message");
    }

  }

  static toastMessage(var message){
    Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorConstant.colorPrimaryLite,
        textColor: ColorConstant.colorBlack,
        fontSize: 16.0
    );


  }

  // static Widget apiLoadingWidget(){
  //   return Container(
  //     height: Get.height,
  //     width: Get.width,
  //     color: ColorConstant.colorBlackTransparent,
  //     child: Center(
  //       child: Container(
  //         height: 70,
  //         width: 70,
  //         decoration: BoxDecoration(
  //           color: ColorConstant.colorWhite,
  //           borderRadius: const BorderRadius.all(Radius.circular(5.0)),
  //           boxShadow: [
  //             BoxShadow(
  //               color: ColorConstant.colorGrey,
  //               spreadRadius: 0.50,
  //               blurRadius: 0.50,
  //             ),
  //           ],
  //         ),
  //         child: Stack(
  //           children: [
  //
  //             Center(
  //               child: Image(image: AssetImage(ImagePaths.imgLogo),
  //                 height: 40,
  //                 width: 40,
  //               ),
  //             ),
  //
  //             Center(
  //               child: Container(
  //                 height: 50,
  //                 width: 50,
  //                 child: SpinKitDualRing(
  //                   color: ColorConstant.colorPrimary,
  //                   size: 50,
  //                   lineWidth: 2,
  //                   duration: const Duration(milliseconds: 600),
  //                 )
  //
  //               ),
  //             )
  //
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }



}
