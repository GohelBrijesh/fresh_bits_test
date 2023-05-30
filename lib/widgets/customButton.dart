import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:fresh_bits_test/widgets/CustomText.dart';
import 'package:get/get.dart';

class CustomButton extends StatefulWidget {

  var label = "";
  VoidCallback onPressedButton;

  CustomButton({required this.label,required this.onPressedButton});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BouncingWidget(
            onPressed: widget.onPressedButton,
            child: Container(
              width: Get.width - 50,
              height: 45,
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorConstant.colorPrimary,
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.colorGrey,
                    spreadRadius: 0.50,
                    blurRadius: 0.50,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  CustomText(
                      textAlign: TextAlign.center,
                      maxLine: 1,
                      label: widget.label,
                      textSize: 18.00,
                      textColor: ColorConstant.colorWhite,
                      fontWeight: FontWeight.bold
                  ),

                ],
              ),
            )
          )
        ],
      ),
    );
  }

}
