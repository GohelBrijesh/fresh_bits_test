import 'package:flutter/material.dart';
import 'package:fresh_bits_test/app/routes/app_pages.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {

  runApp(
    GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Fresh bits test",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );


}


