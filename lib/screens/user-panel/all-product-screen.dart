// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:infant_corner/utils/app-constant.dart';

import '../../models/product_model.dart';
import 'product-detail-screen.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  _AllProductScreenState createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  String dropdownValue = 'Alphabetical A to Z'; // Default sorting option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "All Product",
          style: TextStyle(color: AppConstant.whiteColor),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              setState(() {
                dropdownValue = result;
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'Alphabetical A to Z',
                child: Text(
                  'Alphabetical A to Z',
                  style: TextStyle(
                      color: AppConstant.appSecoundryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              PopupMenuItem<String>(
                value: 'Alphabetical Z to A',
                child: Text(
                  'Alphabetical Z to A',
                  style: TextStyle(
                      color: AppConstant.appSecoundryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              PopupMenuItem<String>(
                value: 'Price Low to High',
                child: Text(
                  'Price Low to High',
                  style: TextStyle(
                      color: AppConstant.appSecoundryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              PopupMenuItem<String>(
                value: 'Price High to Low',
                child: Text(
                  'Price High to Low',
                  style: TextStyle(
                      color: AppConstant.appSecoundryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('product')
            .where('isSale', isEqualTo: false)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No products found!"),
            );
          }

          if (snapshot.data != null) {
            // Sort the list of products based on the selected dropdown value
            List<ProductModel> sortedProducts = snapshot.data!.docs.map((doc) {
              return ProductModel(
                productId: doc['productId'],
                categoryId: doc['categoryId'],
                productName: doc['productName'],
                categoryName: doc['categoryName'],
                salePrice: doc['salePrice'],
                fullPrice: doc['fullPrice'],
                productImages: doc['productImages'],
                deliveryTime: doc['deliveryTime'],
                isSale: doc['isSale'],
                productDescription: doc['productDescription'],
                createdAt: doc['createdAt'],
                updatedAt: doc['updatedAt'],
              );
            }).toList();

            if (dropdownValue == 'Alphabetical A to Z') {
              sortedProducts
                  .sort((a, b) => a.productName.compareTo(b.productName));
            } else if (dropdownValue == 'Alphabetical Z to A') {
              sortedProducts
                  .sort((a, b) => b.productName.compareTo(a.productName));
            } else if (dropdownValue == 'Price Low to High') {
              sortedProducts.sort((a, b) => a.fullPrice.compareTo(b.fullPrice));
            } else if (dropdownValue == 'Price High to Low') {
              sortedProducts.sort((a, b) => b.fullPrice.compareTo(a.fullPrice));
            }

            return GridView.builder(
              itemCount: sortedProducts.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.70,
              ),
              itemBuilder: (context, index) {
                final productModel = sortedProducts[index];
                return GestureDetector(
                  onTap: () => Get.to(
                      () => ProductDetailScreen(productModel: productModel)),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FillImageCard(
                      borderRadius: 20.0,
                      width: Get.width / 2.3,
                      heightImage: Get.height / 5,
                      imageProvider: CachedNetworkImageProvider(
                          productModel.productImages[0]),
                      title: Center(
                        child: Text(
                          productModel.productName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      footer:
                          Center(child: Text("PKR: ${productModel.fullPrice}")),
                    ),
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
