import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:fresh_bits_test/app/modules/cart/controllers/cart_controller.dart';
import 'package:fresh_bits_test/widgets/customCartItem.dart';
import 'package:fresh_bits_test/widgets/customText.dart';
import 'package:get/get.dart';

class CartView extends GetWidget<CartController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorWhite,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: ColorConstant.colorWhite,
        centerTitle: true,
        title: CustomText(
            textAlign: TextAlign.center,
            maxLine: 1,
            label: "Cart",
            textSize: 18.00,
            textColor: ColorConstant.colorPrimary,
            fontWeight: FontWeight.w500
        ),
      ),
      body: Obx(() {
        return Container(
          child: controller.productList.isNotEmpty
              ?
          ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.productList.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomCartItem(
                    imgURL: controller.productList[index].proImage,
                    proName: controller.productList[index].proName,
                    proPrice: controller.productList[index].proPrice,
                    actionButton: InkWell(
                      onTap: () async {
                        controller.removeItemFromCart(index);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: ColorConstant.colorRed),
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: CustomText(
                            textAlign: TextAlign.left,
                            maxLine: 1,
                            label: "Remove",
                            textSize: 14.00,
                            textColor: ColorConstant.colorRed,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    )
                );
              })
              :
          Center(
            child: CustomText(
                textAlign: TextAlign.center,
                maxLine: 3,
                label: "Cart is empty!\n Add Product in cart",
                textSize: 14.00,
                textColor: ColorConstant.colorGrey,
                fontWeight: FontWeight.normal
            ),
          ),
        );
      }),
    );
  }

}
