// ignore_for_file: file_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infant_corner/screens/user-panel/all-categories-screen.dart';
import 'package:infant_corner/screens/user-panel/all-flash-sale-screen.dart';
import 'package:infant_corner/screens/user-panel/all-product-screen.dart';
import 'package:infant_corner/screens/user-panel/cart-screen.dart';
import 'package:infant_corner/widgets/all_products_widget.dart';
import 'package:infant_corner/widgets/banner_widget.dart';
import 'package:infant_corner/widgets/category_widget.dart';

import 'package:infant_corner/widgets/custom_drawer_widget.dart';
import 'package:infant_corner/widgets/flash_sale_widget.dart';
import 'package:infant_corner/widgets/heading_widget.dart';

import '../../utils/app-constant.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          AppConstant.appMainName,
          style: TextStyle(
            fontFamily: "Poppins",
            color: AppConstant.appTextColor,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.add_shopping_cart_outlined,
                color: AppConstant.appTextColor,
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 90.0,
              ),
              //Banners
              BannerWidget(),
              //Headdings
              HeadingWidget(
                headingTitle: "Categories",
                headingSubTitle: "According to your budget",
                buttonText: "See More >",
                onTap: () => Get.to(() => AllCategoriesScreen()),
              ),

              CategoryWidget(),

              HeadingWidget(
                headingTitle: "Flash Sale",
                headingSubTitle: "Limited Sale",
                buttonText: "See More >",
                onTap: () => Get.to(() => AllFlasSaleProduct()),
              ),
              FlashSaleWidget(),

              HeadingWidget(
                headingTitle: "All Products",
                headingSubTitle: "With 100% Gurantee",
                buttonText: "See More >",
                onTap: () => Get.to(() => AllProductScreen()),
              ),

              AllProductWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
