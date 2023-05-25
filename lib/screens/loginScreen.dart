import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:fresh_bits_test/ConstantsClass/color_constant.dart';
import 'package:fresh_bits_test/ConstantsClass/constants_class.dart';
import 'package:fresh_bits_test/ConstantsClass/preferences_manage.dart';
import 'package:fresh_bits_test/screens/homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final FocusNode _focusNodeUsername = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var _obscureText = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorWhite,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [

          Center(
            child: Form(
                key: _formKey,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  padding: EdgeInsets.only(right: 25,left: 25,bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SizedBox(height: 40,),

                        Text(
                          "Sign In",
                          style: TextStyle(
                            color: ColorConstant.colorBlack,
                            fontSize: 24,
                            fontFamily: ConstantsClass.fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                        SizedBox(height: 40,),

                        TextFormField(
                          controller: usernameController,
                          focusNode: _focusNodeUsername,
                          maxLength: 10,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
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
                            contentPadding: EdgeInsets.only(top: 0,bottom: 0,right: 10,left: 10),
                            labelText: "Username",
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 25,),

                        TextFormField(
                          controller: passwordController,
                          focusNode: _focusNodePassword,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText ? Icons.visibility_off : Icons.visibility,
                                color: _obscureText ? ColorConstant.colorGrey : ColorConstant.colorPrimary,
                              ),
                            ),
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
                            contentPadding: EdgeInsets.only(top: 0,bottom: 0,right: 10,left: 10),
                            labelText: "Password",
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),

                        signInButton(),


                        SizedBox(height: 40,),

                      ],
                    ),
                  ),
                )
            ),
          ),

        ],
      ),
    );
  }


  Widget signInButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BouncingWidget(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {

                ConstantsClass.hideKeyboad();

                var username = usernameController.text.toString().trim();
                var password = passwordController.text.toString().trim();

                if(username == "admin" && password == "123456"){
                  ConstantsClass.toastMessage("Login successfully.");
                  PreferencesManage.setPreferencesValue(PreferencesManage.isUserLogin,"1");
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));
                }else{
                  ConstantsClass.toastMessage("Please enter valid username and password.");
                }

              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 45,
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorConstant.colorPrimary,
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
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
                    "Sign In",
                    style: TextStyle(
                      color: ColorConstant.colorWhite,
                      fontSize: 18,
                      fontFamily: ConstantsClass.fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  )

                ],
              ),
            )
        )
      ],
    );
  }


}
