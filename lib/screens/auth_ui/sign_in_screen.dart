// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:infant_corner/controllers/get_user_data_controller.dart';
import 'package:infant_corner/controllers/sign_in_controller.dart';
import 'package:infant_corner/screens/admin-panel/admin_main.dart';
import 'package:infant_corner/screens/auth_ui/forget_password_screen.dart';
import 'package:infant_corner/screens/auth_ui/sign_up_screen.dart';
import 'package:infant_corner/screens/user-panel/main-screen.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app-constant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppConstant.appTextColor),
          backgroundColor: AppConstant.appMainColor,
          centerTitle: true,
          title: Text(
            "Sign In",
            style: TextStyle(
                color: AppConstant.whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                isKeyboardVisible
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Welcome to Infant Corners",
                          style: TextStyle(
                              color: AppConstant.appSecoundryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Column(
                        children: [
                          Lottie.asset('assets/images/splash-screen.json')
                        ],
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
                      controller: userEmail,
                      cursorColor: AppConstant.appSecoundryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Please enter your email address",
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
                      child: Obx(
                        () => TextFormField(
                          controller: userPassword,
                          obscureText: signInController.isPasswordVisible.value,
                          cursorColor: AppConstant.appSecoundryColor,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "Please enter your password",
                            prefixIcon: Icon(Icons.password_outlined),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signInController.isPasswordVisible.toggle();
                              },
                              child: signInController.isPasswordVisible.value
                                  ? Icon(Icons.visibility_off_outlined)
                                  : Icon(Icons.visibility_outlined),
                            ),
                            contentPadding:
                                EdgeInsets.only(top: 2.0, left: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      )),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ForgetPasswordScreen());
                    },
                    child: Text(
                      "Forget Password ?",
                      style: TextStyle(
                          color: AppConstant.appSecoundryColor,
                          fontWeight: FontWeight.bold),
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
                        "SIGN IN",
                        style: TextStyle(
                            color: AppConstant.whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        String email = userEmail.text.trim();
                        String password = userPassword.text.trim();

                        if (email.isEmpty || password.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please enter all of the following information for your account",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appTextColor,
                            colorText: AppConstant.appErrorsColor,
                          );
                        } else {
                          UserCredential? userCredential =
                              await signInController.signInMethod(
                                  email, password);
                          var userData = await getUserDataController
                              .getUserData(userCredential!.user!.uid);

                          if (userCredential != null) {
                            if (userCredential.user!.emailVerified) {
                              //
                              if (userData[0]['isAdmin'] == true) {
                                Get.snackbar(
                                  "Success",
                                  "Admin Login successfully!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appTextColor,
                                  colorText: AppConstant.appSuccessColor,
                                );
                                Get.offAll(() => AdminMainScreen());
                              } else {
                                Get.offAll(() => MainScreen());
                                Get.snackbar(
                                  "Success",
                                  "User Login successfully!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appTextColor,
                                  colorText: AppConstant.appSuccessColor,
                                );
                              }
                            } else {
                              Get.snackbar(
                                "Error",
                                "Please Verify your email before signing",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appTextColor,
                                colorText: AppConstant.appErrorsColor,
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Error",
                              "Please Try Again",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appTextColor,
                              colorText: AppConstant.appErrorsColor,
                            );
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
                      "Don't have an account ? ",
                      style: TextStyle(color: AppConstant.appSecoundryColor),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAll(() => SignUpScreen()),
                      child: Text(
                        "Sign Up",
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
