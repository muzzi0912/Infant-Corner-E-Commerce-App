// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:infant_corner/controllers/sign_up_controller.dart';
import 'package:infant_corner/screens/auth_ui/sign_in_screen.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app-constant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());

  TextEditingController username = TextEditingController();
  TextEditingController useremail = TextEditingController();
  TextEditingController useraddress = TextEditingController();
  TextEditingController userphonenumber = TextEditingController();
  TextEditingController userpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.appMainColor,
          centerTitle: true,
          title: Text(
            "Sign Up",
            style: TextStyle(
                color: AppConstant.whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 12,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Welcome to Infant Corners",
                    style: TextStyle(
                        color: AppConstant.appSecoundryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // SizedBox(
                //   height: Get.height / 12,
                // ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: username,
                      cursorColor: AppConstant.appSecoundryColor,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Please enter your username",
                        prefixIcon: Icon(Icons.email_outlined),
                        contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: useremail,
                      cursorColor: AppConstant.appSecoundryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Please enter your email address",
                        prefixIcon: Icon(Icons.person_outlined),
                        contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: useraddress,
                      cursorColor: AppConstant.appSecoundryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Please enter your address",
                        prefixIcon: Icon(Icons.location_city_outlined),
                        contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: userphonenumber,
                      cursorColor: AppConstant.appSecoundryColor,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Please enter your phone number",
                        prefixIcon: Icon(Icons.numbers_outlined),
                        contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Obx(
                      () => TextFormField(
                        controller: userpassword,
                        obscureText: signUpController.isPasswordVisible.value,
                        cursorColor: AppConstant.appSecoundryColor,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: "Please enter your password",
                          prefixIcon: Icon(Icons.password_outlined),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              signUpController.isPasswordVisible.toggle();
                            },
                            child: signUpController.isPasswordVisible.value
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined),
                          ),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: Get.height / 30,
                ),
                Material(
                  child: Container(
                    width: Get.width / 2,
                    height: Get.height / 18,
                    decoration: BoxDecoration(
                        color: AppConstant.appSecoundryColor,
                        borderRadius: BorderRadius.circular(25.0)),
                    child: TextButton(
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            color: AppConstant.whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        String name = username.text.trim();
                        String email = useremail.text.trim();
                        String address = useraddress.text.trim();
                        String PhoneNumber = userphonenumber.text.trim();
                        String password = userpassword.text.trim();
                        String userDeviceToken = '';

                        if (name.isEmpty ||
                            email.isEmpty ||
                            address.isEmpty ||
                            PhoneNumber.isEmpty ||
                            password.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please enter all required fields",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.whiteColor,
                            colorText: const Color.fromARGB(255, 93, 8, 8),
                          );
                        } else {
                          UserCredential? userCredential =
                              await signUpController.signUpMethod(
                                  name,
                                  email,
                                  address,
                                  PhoneNumber,
                                  password,
                                  userDeviceToken);
                          if (userCredential != null) {
                            Get.snackbar(
                              "Verification Email Sent.",
                              "Please check your email",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecoundryColor,
                              colorText: AppConstant.whiteColor,
                            );
                            FirebaseAuth.instance.signOut();
                            Get.offAll(() => SignInScreen());
                          }
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height / 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ? ",
                      style: TextStyle(color: AppConstant.appSecoundryColor),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAll(() => SignInScreen()),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: AppConstant.appSecoundryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
