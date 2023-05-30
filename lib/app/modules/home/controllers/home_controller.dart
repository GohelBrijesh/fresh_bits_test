import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:fresh_bits_test/ConstantsClass/constants_class.dart';
import 'package:fresh_bits_test/ConstantsClass/preferences_manage.dart';
import 'package:fresh_bits_test/app/routes/app_pages.dart';
import 'package:fresh_bits_test/models/productModel.dart';
import 'package:get/get.dart';

import '../../../../localDB/databaseHelper.dart';

class HomeController extends GetxController {

  DatabaseHelper databaseHelper = DatabaseHelper();
  RxList<dynamic> productList =[].obs;
  var productInCart = 0.obs;

  @override
  Future<void> onInit() async {

    prepareProductList();

    super.onInit();
  }

  prepareProductList() async {
    productList.clear();
    productList.add(ProductModel(id: "1", proName: "Fastrack watch", proPrice: "1500", proImage: "https://staticimg.titan.co.in/Fastrack/Catalog/3147KM01_1.jpg", proInCart: false.obs));
    productList.add(ProductModel(id: "2", proName: "Oneplus watch", proPrice: "4500", proImage: "https://image01.oneplus.net/ebp/202103/12/1-m00-21-ed-rb8lb2bk1uuajj_daai4dpxzbes482.png", proInCart: false.obs));
    productList.add(ProductModel(id: "3", proName: "Oneplus XWE", proPrice: "6110", proImage: "https://cdn.opstatics.com/store/20170907/assets/images/events/2021/03/watches/en/common/1920/kv/kv-2.png", proInCart: false.obs));
    productList.add(ProductModel(id: "4", proName: "Casio WR 50M", proPrice: "2700", proImage: "https://m.media-amazon.com/images/I/61Ku1aM72wL._UL1100_.jpg", proInCart: false.obs));
    productList.add(ProductModel(id: "5", proName: "Jone Watch WW12", proPrice: "1720", proImage: "https://m.media-amazon.com/images/I/71GIYSZpW+L._SX522_.jpg", proInCart: false.obs));
    productList.add(ProductModel(id: "6", proName: "New-Mockups T-shirt", proPrice: "999", proImage: "https://cdn.shopify.com/s/files/1/1002/7150/products/New-Mockups---no-hanger---TShirt-Man-of-Masses---NTR-a.jpg", proInCart: false.obs));
    productList.add(ProductModel(id: "7", proName: "RRR Mockup", proPrice: "1799", proImage: "https://cdn.shopify.com/s/files/1/1002/7150/products/New-Mockups---no-hanger---TShirt-Yellow.jpg", proInCart: false.obs));
    productList.add(ProductModel(id: "8", proName: "Lady T-shirt", proPrice: "2099", proImage: "https://m.media-amazon.com/images/I/51ZeW4RBJaS._UL1024_.jpg", proInCart: false.obs));
    productList.add(ProductModel(id: "9", proName: "iPhone 14", proPrice: "80000", proImage: "https://www.links.hr/content/images/thumbs/016/0164974_smartphone-apple-iphone-14-6-1-6-gb-128-gb-ios-plavi-010301349.jpg", proInCart: false.obs));
    productList.add(ProductModel(id: "10", proName: "iPhone 14 Pro Gold", proPrice: "130000", proImage: "https://media.croma.com/image/upload/v1662703136/Croma%20Assets/Communication/Mobiles/Images/261962_pmfreq.png", proInCart: false.obs));

    await getCartProducts();

  }

  getCartProducts() async {

    List<ProductModel> cartProductList = await databaseHelper.getCartProducts();
    productInCart.value = cartProductList.length;
    for(int i = 0 ; i < productList.length ; i++){
      if(await databaseHelper.isProductExistsInCart(productList[i].id.toString())){
        productList[i].proInCart.value = true;
      }else{
        productList[i].proInCart.value = false;
      }
    }

  }

  onTapAddToCartEvent(var index) async {
    await databaseHelper.addProductDataInCart(productList[index]);
    getCartProducts();
  }

  onTapRemoveCartEvent(var index,BuildContext context){
    AwesomeDialog(
      context: context,
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

  onTapLogoutUser(BuildContext context){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.scale,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      padding: const EdgeInsets.all(10),
      title: "Logout user",
      desc: "Are you sure you want to logout?",
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
      btnOkText: 'Logout',
      btnCancelText: 'Cancel',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        databaseHelper.deleteMyCartRecords();
        PreferencesManage.setPreferencesValue(PreferencesManage.isUserLogin, "");
        Get.offAllNamed(Routes.LOGIN);
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
