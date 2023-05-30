import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:fresh_bits_test/ConstantsClass/constants_class.dart';
import 'package:fresh_bits_test/ConstantsClass/image_paths.dart';
import 'package:fresh_bits_test/app/routes/app_pages.dart';
import 'package:fresh_bits_test/widgets/customProductItem.dart';
import 'package:fresh_bits_test/widgets/customText.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorWhite,
      appBar: AppBar(
        backgroundColor: ColorConstant.colorWhite,
        centerTitle: true,
        title: CustomText(
            textAlign: TextAlign.center,
            maxLine: 1,
            label: "Dashboard",
            textSize: 18.00,
            textColor: ColorConstant.colorPrimary,
            fontWeight: FontWeight.w500
        ),
        leading: InkWell(
          onTap: () {
            controller.onTapLogoutUser(context);
          },
          child: Container(
            padding: EdgeInsets.all(12),
            child: const Icon(Icons.logout, color: Colors.black,),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              if (controller.productInCart.value > 0) {
                Get.toNamed(Routes.CART)?.then((value) =>
                    controller.getCartProducts());
              } else {
                ConstantsClass.toastMessage("Please add product in cart.");
              }
            },
            child: Obx(() {
              return Container(
                padding: EdgeInsets.only(top: 5),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Image(image: AssetImage(ImagePaths.iconCart)),
                    ),

                    controller.productInCart.value > 0
                        ?
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 3, bottom: 3, right: 6, left: 6),
                        decoration: BoxDecoration(
                          color: ColorConstant.colorRed,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.colorGrey,
                              spreadRadius: 0.50,
                              blurRadius: 0.50,
                            ),
                          ],
                        ),
                        child: Center(
                          child: CustomText(
                              textAlign: TextAlign.left,
                              maxLine: 1,
                              label: controller.productInCart.value.toString(),
                              textSize: 12.00,
                              textColor: ColorConstant.colorWhite,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    )
                        :
                    const SizedBox()

                  ],
                ),
              );
            }),
          ),
        ],
      ),
      body: Obx(() {
        return Container(
          margin: EdgeInsets.all(10),
          child: GridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 2.0,
              children: List.generate(controller.productList.length, (index) {

                return Center(
                  child: CustomProductItem(
                      imgURL: controller.productList[index].proImage,
                      proName: controller.productList[index].proName,
                      proPrice: controller.productList[index].proPrice,
                      actionButton: controller.productList[index].proInCart.value
                          ?
                      InkWell(
                          onTap: () async {
                            controller.onTapRemoveCartEvent(index,context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: CustomText(
                                label: "Remove from cart",
                                textAlign: TextAlign.center,
                                maxLine: 1,
                                textSize: 14.00,
                                textColor: ColorConstant.colorRed,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        )
                          :
                      InkWell(
                          onTap: () async {
                            controller.onTapAddToCartEvent(index);
                          },
                          child: Container(
                            height: 25,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorConstant.colorPrimary,
                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5.0), bottomRight: Radius.circular(5.0)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                    label: "Add to cart",
                                    textAlign: TextAlign.center,
                                    maxLine: 1,
                                    textSize: 14.00,
                                    textColor: ColorConstant.colorWhite,
                                    fontWeight: FontWeight.bold
                                ),
                              ],
                            ),
                          )
                      ),
                  ),
                );
              })
          ),
        );
      }),
    );
  }

}
