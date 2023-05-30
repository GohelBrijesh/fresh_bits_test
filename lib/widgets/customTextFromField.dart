import 'package:flutter/material.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:fresh_bits_test/ConstantsClass/constants_class.dart';

class CustomTextFromField extends StatefulWidget {

  TextEditingController? controller;
  FocusNode? textFieldFocus;
  TextInputAction? textInputAction;
  FormFieldValidator<String>? validator;
  Widget? suffixIcon;
  TextInputType inputTypeKeyboard = TextInputType.text;
  var obscureText = false;
  var maxLength;
  var label = "";

  CustomTextFromField({required this.controller,required this.textFieldFocus,required this.textInputAction,required this.suffixIcon,
    required this.obscureText,required this.inputTypeKeyboard,required this.label,required this.maxLength,required this.validator});

  @override
  State<CustomTextFromField> createState() => _CustomTextFromFieldState();
}

class _CustomTextFromFieldState extends State<CustomTextFromField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.textFieldFocus,
      maxLength: widget.maxLength,
      textInputAction: widget.textInputAction,
      keyboardType: widget.inputTypeKeyboard,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        counterText: "",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: ColorConstant.colorPrimary,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: ColorConstant.colorPrimary,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 0,bottom: 0,right: 10,left: 10),
        labelText: widget.label,
        hintStyle: TextStyle(
          color: ColorConstant.colorBlack,
          fontSize: 14,
          fontFamily: ConstantsClass.fontFamily,
          fontWeight: FontWeight.bold,
        ),
        labelStyle: TextStyle(
          color: ColorConstant.colorBlack,
          fontSize: 14,
          fontFamily: ConstantsClass.fontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
      validator: widget.validator,
    );
  }
}
