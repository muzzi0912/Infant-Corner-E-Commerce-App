// ignore_for_file: file_names, unnecessary_overrides, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  RxList<String> bannerUrls = RxList<String>([]);

  @override
  void onInit() {
    super.onInit();
    fetchbannerUrls();
  }

  //Fetch Banners
  Future<void> fetchbannerUrls() async {
    try {
      QuerySnapshot bannersSnapShot =
          await FirebaseFirestore.instance.collection('banners').get();

      if (bannersSnapShot.docs.isNotEmpty) {
        bannerUrls.value = bannersSnapShot.docs
            .map((doc) => doc['imageUrls'] as String)
            .toList();
      }
    } catch (e) {
      print("Error : $e");
    }
  }
}
