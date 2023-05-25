import 'package:fresh_bits_test/models/productModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  // database name
  static var databaseName = 'freshBitsTest.db';

  // database version
  static var databaseVersion = 1;

  // table name
  static var tableCart = 'cart';

  // => name
  static var columnId = "id";
  static var columnProductId = "pro_id";
  static var columnProductName = "pro_name";
  static var columnProductPrice = "pro_price";
  static var columnProductImage = "pro_Image";

  // initialize database
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(join(path, databaseName), onCreate: (database, version) async {

      await database.execute(
        "CREATE TABLE $tableCart("
            "$columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
            "$columnProductId TEXT,"
            "$columnProductName TEXT,"
            "$columnProductPrice TEXT,"
            "$columnProductImage TEXT"
            ")",
      );

    }, version: databaseVersion,
    );
  }


  // Insert Product into Local DB
  addProductDataInCart(ProductModel productModel) async
  {
    final Database database = await initializeDB();
    var result = await database.insert(tableCart, productModel.toMap());
    print("result : success");

    return result;

  }

  // Retrieve All Product from Local DB..
  Future<List<ProductModel>> getCartProducts() async {
    final Database database = await initializeDB();
    final List<Map<String, Object?>> queryResult = await database.query(tableCart);
    return queryResult.map((e) => ProductModel.fromMap(e)).toList();
  }

  // check Product is added in cart ot not..
  Future<bool> isProductExistsInCart(var proId) async {
    final Database database = await initializeDB();
    var result = await database.rawQuery('SELECT EXISTS(SELECT 1 FROM $tableCart WHERE $columnProductId="$proId")',);
    var exists = Sqflite.firstIntValue(result);
    return exists == 1;
  }

  Future<int> removeProductFromCart(var proId) async {
    final Database database = await initializeDB();
    var result = await database.delete(tableCart, where: '$columnProductId = ?', whereArgs: [proId]);
    return result;
  }


}