import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:fresh_bits_test/widgets/CustomText.dart';

class CustomProductItem extends StatefulWidget {

  var imgURL;
  var proName;
  var proPrice;
  Widget? actionButton;

  CustomProductItem({required this.imgURL, required this.proName, required this.proPrice, required this.actionButton});

  @override
  State<CustomProductItem> createState() => _CustomProductItemState();
}

class _CustomProductItemState extends State<CustomProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorConstant.colorWhite,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.colorGrey,
            spreadRadius: 0.50,
            blurRadius: 0.50,
          ),
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.fitHeight,
                    width: double.infinity,
                    imageUrl: widget.imgURL,
                    placeholder: (context, url) => Center(child: SizedBox(width: 30, height: 30, child: SpinKitSpinningLines(color: ColorConstant.colorPrimary, size: 30,))),
                    errorWidget: (context, url, error) =>
                    const Center(child: SizedBox(width: 100, child: Icon(Icons.image_not_supported_outlined, size: 50, color: Colors.grey,))),
                  ),
                ),
              ),
            ),

            Container(height: 0.5, width: double.infinity, color: Colors.grey,),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CustomText(
                      label: widget.proName,
                      textAlign: TextAlign.left,
                      maxLine: 1,
                      textSize: 14.00,
                      textColor: ColorConstant.colorBlack,
                      fontWeight: FontWeight.bold
                  ),

                  CustomText(
                      label: "₹ ${widget.proPrice}",
                      textAlign: TextAlign.left,
                      maxLine: 1,
                      textSize: 14.00,
                      textColor: ColorConstant.colorBlack,
                      fontWeight: FontWeight.normal
                  ),

                ],
              ),
            ),

            Container(child: widget.actionButton,),

          ]
      ),
    );
  }
}
