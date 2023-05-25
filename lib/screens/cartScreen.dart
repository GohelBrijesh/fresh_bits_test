import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:fresh_bits_test/ConstantsClass/constants_class.dart';
import 'package:fresh_bits_test/ConstantsClass/image_paths.dart';
import 'package:fresh_bits_test/localDB/databaseHelper.dart';
import 'package:fresh_bits_test/models/productModel.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ProductModel> productList = [];

  @override
  void initState() {
    getCartProducts();
    super.initState();
  }


  getCartProducts() async {
    productList = await databaseHelper.getCartProducts();
    setState(() {});
  }


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
        title: Text(
          "Cart",
          style: TextStyle(
            color: ColorConstant.colorPrimary,
            fontSize: 18,
            fontFamily: ConstantsClass.fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        child: productList.isNotEmpty
            ?
        ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: productList.length,
            itemBuilder: (BuildContext context, int index) {
              return itemProductCart(index);
            })
            :
        Center(
          child: Text(
           "Cart is empty!\n Add Product in cart",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorConstant.colorGrey,
              fontSize: 14,
              fontFamily: ConstantsClass.fontFamily,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget itemProductCart(var index){
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
                  imageUrl: productList[index].proImage,
                  placeholder: (context, url) => Center(child: SizedBox(width: 30, height : 30, child: SpinKitSpinningLines(color: ColorConstant.colorPrimary,size: 30,))),
                  errorWidget: (context, url, error) => const Center(child: SizedBox(width: 100, child: Icon(Icons.image_not_supported_outlined,size: 50,color: Colors.grey,))),
                ),
              ),
            ),



            Container(
              margin: EdgeInsets.only(left: 0,right: 10),
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

                    Text(
                      productList[index].proName,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorConstant.colorBlack,
                        fontSize: 14,
                        fontFamily: ConstantsClass.fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10,),

                    Text(
                      "₹ ${productList[index].proPrice}",
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorConstant.colorBlack,
                        fontSize: 14,
                        fontFamily: ConstantsClass.fontFamily,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                    SizedBox(height: 15,),

                    removeProductFromCartButton(index),

                  ],
                ),
              ),
            )

          ]
      ),
    );
  }

  Widget removeProductFromCartButton(var index) {
    return Row(
      children: [
        InkWell(
          onTap: () async {

            AwesomeDialog(
              context: context,
              dialogType: DialogType.question,
              animType: AnimType.scale,
              dismissOnTouchOutside: true,
              dismissOnBackKeyPress: true,
              padding: const EdgeInsets.all(10),
              title: "Remove product",
              desc: "Are you sure you want to remove this product from cart?",
              titleTextStyle: TextStyle(color: ColorConstant.colorBlack,fontFamily: ConstantsClass.fontFamily,fontSize: 16,fontWeight: FontWeight.bold),
              descTextStyle: TextStyle(color: ColorConstant.colorBlack,fontFamily: ConstantsClass.fontFamily,fontSize: 14,fontWeight: FontWeight.normal),
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


          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: ColorConstant.colorRed),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Text(
              "Remove",
              style: TextStyle(
                color: ColorConstant.colorRed,
                fontSize: 14,
                fontFamily: ConstantsClass.fontFamily,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }



}
