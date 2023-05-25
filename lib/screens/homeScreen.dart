import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:fresh_bits_test/ConstantsClass/constants_class.dart';
import 'package:fresh_bits_test/ConstantsClass/image_paths.dart';
import 'package:fresh_bits_test/ConstantsClass/preferences_manage.dart';
import 'package:fresh_bits_test/localDB/databaseHelper.dart';
import 'package:fresh_bits_test/models/productModel.dart';
import 'package:fresh_bits_test/screens/cartScreen.dart';
import 'package:fresh_bits_test/screens/loginScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ProductModel> productList = [];
  var productInCart = 0;

  @override
  void initState() {

    prepareProductList();

    super.initState();
  }

  prepareProductList() async {
    productList.clear();
    productList.add(ProductModel(id: "1", proName: "Fastrack watch", proPrice: "1500", proImage: "https://staticimg.titan.co.in/Fastrack/Catalog/3147KM01_1.jpg", proInCart: false));
    productList.add(ProductModel(id: "2", proName: "Oneplus watch", proPrice: "4500", proImage: "https://image01.oneplus.net/ebp/202103/12/1-m00-21-ed-rb8lb2bk1uuajj_daai4dpxzbes482.png", proInCart: false));
    productList.add(ProductModel(id: "3", proName: "Oneplus XWE", proPrice: "6110", proImage: "https://cdn.opstatics.com/store/20170907/assets/images/events/2021/03/watches/en/common/1920/kv/kv-2.png", proInCart: false));
    productList.add(ProductModel(id: "4", proName: "Casio WR 50M", proPrice: "2700", proImage: "https://m.media-amazon.com/images/I/61Ku1aM72wL._UL1100_.jpg", proInCart: false));
    productList.add(ProductModel(id: "5", proName: "Jone Watch WW12", proPrice: "1720", proImage: "https://m.media-amazon.com/images/I/71GIYSZpW+L._SX522_.jpg", proInCart: false));
    productList.add(ProductModel(id: "6", proName: "New-Mockups T-shirt", proPrice: "999", proImage: "https://cdn.shopify.com/s/files/1/1002/7150/products/New-Mockups---no-hanger---TShirt-Man-of-Masses---NTR-a.jpg", proInCart: false));
    productList.add(ProductModel(id: "7", proName: "RRR Mockup", proPrice: "1799", proImage: "https://cdn.shopify.com/s/files/1/1002/7150/products/New-Mockups---no-hanger---TShirt-Yellow.jpg", proInCart: false));
    productList.add(ProductModel(id: "8", proName: "Lady T-shirt", proPrice: "2099", proImage: "https://m.media-amazon.com/images/I/51ZeW4RBJaS._UL1024_.jpg", proInCart: false));
    productList.add(ProductModel(id: "9", proName: "iPhone 14", proPrice: "80000", proImage: "https://www.links.hr/content/images/thumbs/016/0164974_smartphone-apple-iphone-14-6-1-6-gb-128-gb-ios-plavi-010301349.jpg", proInCart: false));
    productList.add(ProductModel(id: "10", proName: "iPhone 14 Pro Gold", proPrice: "130000", proImage: "https://media.croma.com/image/upload/v1662703136/Croma%20Assets/Communication/Mobiles/Images/261962_pmfreq.png", proInCart: false));

    await getCartProducts();
  }

  getCartProducts() async {

    List<ProductModel> cartProductList = await databaseHelper.getCartProducts();
    productInCart = cartProductList.length;
    for(int i = 0 ; i < productList.length ; i++){
      if(await databaseHelper.isProductExistsInCart(productList[i].id.toString())){
        productList[i].proInCart = true;
      }else{
        productList[i].proInCart = false;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorWhite,
      appBar: AppBar(
        backgroundColor: ColorConstant.colorWhite,
        centerTitle: true,
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: ColorConstant.colorPrimary,
            fontSize: 18,
            fontFamily: ConstantsClass.fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: InkWell(
          onTap: () {

            AwesomeDialog(
              context: context,
              dialogType: DialogType.question,
              animType: AnimType.scale,
              dismissOnTouchOutside: true,
              dismissOnBackKeyPress: true,
              padding: const EdgeInsets.all(10),
              title: "Logout user",
              desc: "Are you sure you want to logout?",
              titleTextStyle: TextStyle(color: ColorConstant.colorBlack,fontFamily: ConstantsClass.fontFamily,fontSize: 16,fontWeight: FontWeight.bold),
              descTextStyle: TextStyle(color: ColorConstant.colorBlack,fontFamily: ConstantsClass.fontFamily,fontSize: 14,fontWeight: FontWeight.normal),
              btnOkColor: ColorConstant.colorRed,
              btnCancelColor: ColorConstant.colorGrey,
              btnOkText: 'Logout',
              btnCancelText: 'Cancel',
              btnCancelOnPress: () {},
              btnOkOnPress: () async {

                PreferencesManage.setPreferencesValue(PreferencesManage.isUserLogin, "");

                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()));

              },
            ).show();

          },
          child: Container(
            padding: EdgeInsets.all(12),
            child: const Icon(Icons.logout,color: Colors.black,),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              if(productInCart > 0){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const CartScreen())).then((value) => getCartProducts());
              }else{
                ConstantsClass.toastMessage("Please add product in cart.");
              }
            },
            child: Container(
              padding: EdgeInsets.only(top: 5),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Image(image: AssetImage(ImagePaths.iconCart)),
                  ),

                  productInCart > 0
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
                        child: Text(
                          productInCart.toString(),
                          style: TextStyle(
                            color: ColorConstant.colorWhite,
                            fontSize: 12,
                            fontFamily: ConstantsClass.fontFamily,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                      :
                  const SizedBox()

                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: GridView.count(
          physics: const BouncingScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 2.0,
            children: List.generate(productList.length, (index) {
              return Center(
                child: itemProductCart(index),
              );
            })
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
                      imageUrl: productList[index].proImage,
                      placeholder: (context, url) => Center(child: SizedBox(width: 30, height : 30, child: SpinKitSpinningLines(color: ColorConstant.colorPrimary,size: 30,))),
                      errorWidget: (context, url, error) => const Center(child: SizedBox(width: 100, child: Icon(Icons.image_not_supported_outlined,size: 50,color: Colors.grey,))),
                    ),
                  ),
                ),
            ),

            Container(height: 0.5,width: double.infinity,color: Colors.grey,),


            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productList[index].proName,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ColorConstant.colorBlack,
                      fontSize: 14,
                      fontFamily: ConstantsClass.fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

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

                ],
              ),
            ),

            productList[index].proInCart
                ?
            removeProductFromCartButton(index)
                :
            addToCartButton(index),

          ]
      ),
    );
  }

  Widget removeProductFromCartButton(var index) {
    return InkWell(
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
        child: Text(
          "Remove from cart",
          style: TextStyle(
            color: ColorConstant.colorRed,
            fontSize: 14,
            fontFamily: ConstantsClass.fontFamily,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget addToCartButton(var index) {
    return  InkWell(
        onTap: () async {
          await databaseHelper.addProductDataInCart(productList[index]);
          getCartProducts();
        },
        child: Container(
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorConstant.colorPrimary,
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5.0),bottomRight: Radius.circular(5.0)),
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

              Text(
                "Add to cart",
                style: TextStyle(
                  color: ColorConstant.colorWhite,
                  fontSize: 14,
                  fontFamily: ConstantsClass.fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              )


            ],
          ),
        )
    );
  }

}
