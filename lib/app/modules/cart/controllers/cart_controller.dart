import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:fresh_bits_test/ConstantsClass/constants_class.dart';
import 'package:fresh_bits_test/localDB/databaseHelper.dart';
import 'package:get/get.dart';

class CartController extends GetxController {

  DatabaseHelper databaseHelper = DatabaseHelper();
  RxList<dynamic> productList =[].obs;

  @override
  Future<void> onInit() async {
    getCartProducts();
    super.onInit();
  }

  getCartProducts() async {
    productList.value = await databaseHelper.getCartProducts();
  }

  removeItemFromCart(var index){
    AwesomeDialog(
      context: Get.context as BuildContext,
      dialogType: DialogType.question,
      animType: AnimType.scale,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      padding: const EdgeInsets.all(10),
      title: "Remove product",
      desc: "Are you sure you want to remove this product from cart?",
      titleTextStyle: TextStyle(color: ColorConstant.colorBlack,
          fontFamily: ConstantsClass.fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.bold),
      descTextStyle: TextStyle(color: ColorConstant.colorBlack,
          fontFamily: ConstantsClass.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.normal),
      btnOkColor: ColorConstant.colorRed,
      btnCancelColor: ColorConstant.colorGrey,
      btnOkText: 'Remove',
      btnCancelText: 'Cancel',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        await databaseHelper.removeProductFromCart(productList[index].id);
        getCartProducts();
      },
    ).show();
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
