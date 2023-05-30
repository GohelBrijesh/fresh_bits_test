import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:fresh_bits_test/widgets/CustomText.dart';

class CustomCartItem extends StatefulWidget {

  var imgURL;
  var proName;
  var proPrice;
  Widget? actionButton;

  CustomCartItem({required this.imgURL, required this.proName, required this.proPrice, required this.actionButton});

  @override
  State<CustomCartItem> createState() => _CustomCartItemState();
}

class _CustomCartItemState extends State<CustomCartItem> {
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
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 120,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  fit: BoxFit.fitHeight,
                  width: double.infinity,
                  imageUrl: widget.imgURL,
                  placeholder: (context, url) =>
                      Center(child: SizedBox(
                          width: 30, height: 30, child: SpinKitSpinningLines(
                        color: ColorConstant.colorPrimary, size: 30,))),
                  errorWidget: (context, url, error) => const Center(
                      child: SizedBox(width: 100,
                          child: Icon(
                            Icons.image_not_supported_outlined, size: 50,
                            color: Colors.grey,))),
                ),
              ),
            ),


            Container(
              margin: EdgeInsets.only(left: 0, right: 10),
              height: 120,
              width: 0.5,
              color: Colors.grey,
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(3),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomText(
                        textAlign: TextAlign.left,
                        maxLine: 2,
                        label: widget.proName,
                        textSize: 14.00,
                        textColor: ColorConstant.colorBlack,
                        fontWeight: FontWeight.bold
                    ),

                    SizedBox(height: 10,),

                    CustomText(
                        textAlign: TextAlign.left,
                        maxLine: 1,
                        label: "₹ ${widget.proPrice}",
                        textSize: 14.00,
                        textColor: ColorConstant.colorBlack,
                        fontWeight: FontWeight.normal
                    ),

                    SizedBox(height: 15,),

                    Container(child: widget.actionButton,),

                  ],
                ),
              ),
            )

          ]
      ),
    );
  }
}
