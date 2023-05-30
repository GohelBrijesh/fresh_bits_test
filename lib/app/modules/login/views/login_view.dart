
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:fresh_bits_test/widgets/customButton.dart';
import 'package:fresh_bits_test/widgets/customText.dart';
import 'package:fresh_bits_test/widgets/customTextFromField.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetWidget<LoginController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.colorWhite,
        resizeToAvoidBottomInset: false,
        body:  Stack(
          children: [

            Obx(() {
              return Center(
                child: Form(
                    key: controller.formKey,
                    child: Container(
                      padding: EdgeInsets.only(right: 25,left: 25,bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            const SizedBox(height: 40,),

                            CustomText(
                                textAlign: TextAlign.center,
                                maxLine: 1,
                                label: "Sign In",
                                textSize: 24.00,
                                textColor: ColorConstant.colorBlack,
                                fontWeight: FontWeight.bold
                            ),


                            SizedBox(height: 40,),

                            CustomTextFromField(
                              controller: controller.usernameController,
                              textFieldFocus: controller.focusNodeUsername,
                              textInputAction: TextInputAction.next,
                              suffixIcon: null,
                              obscureText: false,
                              inputTypeKeyboard: TextInputType.text,
                              label: "Username",
                              maxLength: TextField.noMaxLength,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter username';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 25,),

                            CustomTextFromField(
                              controller: controller.passwordController,
                              textFieldFocus: controller.focusNodePassword,
                              textInputAction: TextInputAction.done,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.obscureText.value = !controller.obscureText.value;
                                },
                                child: Icon(
                                  controller.obscureText.value ? Icons.visibility_off : Icons.visibility,
                                  color: controller.obscureText.value ? ColorConstant.colorGrey : ColorConstant.colorPrimary,
                                ),
                              ),
                              obscureText: controller.obscureText.value,
                              inputTypeKeyboard: TextInputType.visiblePassword,
                              label: "Password",
                              maxLength: TextField.noMaxLength,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                            ),

                            CustomButton(label: "Sign In", onPressedButton: () => controller.onClickSignInButton()),

                            SizedBox(height: 40,),

                          ],
                        ),
                      ),
                    )
                ),
              );
            }),

          ],
        )
    );
  }

}
