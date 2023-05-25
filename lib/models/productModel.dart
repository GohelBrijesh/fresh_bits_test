import 'package:fresh_bits_test/localDB/databaseHelper.dart';

class ProductModel{

  var id;
  var proName;
  var proPrice;
  var proImage;
  var proInCart;

  ProductModel({required this.id, required this.proName,required this.proPrice, required this.proImage, required this.proInCart,});


  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnProductId:id,
      DatabaseHelper.columnProductName:proName,
      DatabaseHelper.columnProductPrice:proPrice,
      DatabaseHelper.columnProductImage:proImage,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        id: map[DatabaseHelper.columnProductId],
        proName: map[DatabaseHelper.columnProductName],
        proPrice: map[DatabaseHelper.columnProductPrice],
        proImage: map[DatabaseHelper.columnProductImage],
        proInCart: true
    );
  }

}