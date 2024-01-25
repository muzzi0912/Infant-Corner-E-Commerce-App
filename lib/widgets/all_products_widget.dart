// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/product_model.dart';
import '../screens/user-panel/product-detail-screen.dart';

class AllProductWidget extends StatelessWidget {
  const AllProductWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('product')
          .where('isSale', isEqualTo: false)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error",
              style: TextStyle(
                fontFamily: "Poppins",
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: Get.height / 5,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No products found!",
              style: TextStyle(
                fontFamily: "Poppins",
              ),
            ),
          );
        }

        if (snapshot.data != null) {
          // Sort the list of products by product name
          final sortedProducts = snapshot.data!.docs.map((doc) {
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
          }).toList()
            ..sort((a, b) => a.productName.compareTo(b.productName));

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
                  child: Container(
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
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      footer: Center(
                        child: Text(
                          "PKR: ${productModel.fullPrice}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }

        return Container();
      },
    );
  }
}
