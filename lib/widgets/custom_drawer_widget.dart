// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, no_leading_underscores_for_local_identifiers, unnecessary_string_interpolations

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:infant_corner/screens/auth_ui/welcome-screen.dart';
import 'package:infant_corner/screens/user-panel/all-categories-screen.dart';
import 'package:infant_corner/screens/user-panel/all-orders-screen.dart';
import 'package:infant_corner/screens/user-panel/all-product-screen.dart';
import 'package:infant_corner/screens/user-panel/main-screen.dart';
import 'package:infant_corner/utils/app-constant.dart';

import '../controllers/get_user_data_controller.dart';
import '../models/user_model.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final GetUserDataController _userDataController =
      Get.put(GetUserDataController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Wrap(
        runSpacing: 10,
        children: [
          FutureBuilder(
            future: _userDataController
                .getUserData(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppConstant.appSecoundryColor,
                  ),
                );
              } else {
                UserModel user = UserModel.fromMap(
                    snapshot.data![0].data() as Map<String, dynamic>);

                String greeting = _getGreeting();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 26, left: 16),
                      child: Text(
                        "$greeting,",
                        style: TextStyle(
                          color: AppConstant.appMainColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        user.username,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        AppConstant.appMainName,
                        style: TextStyle(
                            color: AppConstant.appSecoundryColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: AppConstant.appSecoundryColor,
                        child: Text(
                          user.username.substring(0, 1),
                          style: TextStyle(
                            color: AppConstant.appTextColor,
                            fontFamily: "Poppins",
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Divider(
                      indent: 16.0,
                      endIndent: 16.0,
                      thickness: 1.5,
                      color: Colors.grey,
                    ),
                    buildListTile(
                      "Home",
                      Icons.home_outlined,
                      () => Get.to(() => MainScreen()),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    buildListTile(
                      "Products",
                      Icons.production_quantity_limits,
                      () => Get.to(() => AllProductScreen()),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    buildListTile(
                      "Categories",
                      Icons.category,
                      () => Get.to(() => AllCategoriesScreen()),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    buildListTile(
                      "Orders",
                      Icons.shopping_bag_outlined,
                      () => Get.to(() => AllOrdersScreen()),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    buildListTile(
                      "Contact",
                      Icons.help_center,
                      () {
                        // Handle Contact tap
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      indent: 16.0,
                      endIndent: 16.0,
                      thickness: 1.5,
                      color: Colors.grey,
                    ),
                    buildListTile(
                      "Log Out",
                      Icons.logout_outlined,
                      () async {
                        GoogleSignIn googleSignIn = GoogleSignIn();
                        FirebaseAuth _auth = FirebaseAuth.instance;
                        await _auth.signOut();
                        await googleSignIn.signOut();
                        Get.offAll(() => WelcomeScreen());
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 170),
                      child: Center(
                        child: Text(
                          AppConstant.appPoweredBy,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        AppConstant.appVersion,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      title: Text(
        title,
        style: TextStyle(
          color: AppConstant.appTextBlackColor,
          fontFamily: "Poppins",
          fontSize: 16,
        ),
      ),
      leading: Icon(
        icon,
        color: AppConstant.appSecoundryColor,
        size: 26,
      ),
      trailing: Icon(
        Icons.arrow_forward,
        color: AppConstant.appSecoundryColor,
        size: 24,
      ),
      onTap: onTap,
    );
  }

  String _getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
