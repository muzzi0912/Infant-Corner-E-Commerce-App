// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unnecessary_import, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:infant_corner/models/categories_model.dart';
import 'package:infant_corner/screens/user-panel/single-category-product-screen.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('categories').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: Get.height / 5,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text("No Categories available for this time!"),
          );
        }

        if (snapshot.data != null) {
          // Sort the list of categories by category name
          final sortedCategories = snapshot.data!.docs.map((doc) {
            return CategoriesModel(
              categoryId: doc['categoryId'],
              categoryImage: doc['categoryImage'],
              categoryName: doc['categoryName'],
              createdAt: doc['createdAt'],
              updatedAt: doc['updatedAt'],
            );
          }).toList()
            ..sort((a, b) => a.categoryName.compareTo(b.categoryName));

          return Container(
            height: Get.height / 6,
            child: ListView.builder(
              itemCount: sortedCategories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                CategoriesModel categoriesModel = sortedCategories[index];
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => AllSingleCategoryProductScreen(
                            categoryId: categoriesModel.categoryId,
                            categoryName: categoriesModel.categoryName,
                          )),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width / 4.0,
                            heightImage: Get.height / 12.0,
                            imageProvider: CachedNetworkImageProvider(
                              categoriesModel.categoryImage,
                            ),
                            title: Center(
                              child: Text(
                                categoriesModel.categoryName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
