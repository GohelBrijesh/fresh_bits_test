import 'package:flutter/material.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';

import '../constantsClass/constants_class.dart';

class CustomText extends StatefulWidget {

  var label = "";
  var textSize = 14.00;
  var textColor = ColorConstant.colorBlack;
  var fontWeight = FontWeight.bold;
  var maxLine = 1;
  var textAlign = TextAlign.left;

  CustomText({required this.label,required this.textSize,required this.textColor,required this.fontWeight,required this.maxLine,required this.textAlign});

  @override
  State<CustomText> createState() => _CustomTextState();

}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.label,
      maxLines: widget.maxLine,
      overflow: TextOverflow.ellipsis,
      textAlign: widget.textAlign,
      style: TextStyle(
        color: widget.textColor,
        fontSize: widget.textSize,
        fontFamily: ConstantsClass.fontFamily,
        fontWeight: widget.fontWeight,
      ),
    );
  }
}
