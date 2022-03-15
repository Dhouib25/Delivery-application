library globals;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iac_project/models.dart';

bool? signedIn;
UserModel? user;
getsign() async {
  await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) {
    signedIn = value.data()!["autoSigned"];
  });
}

Future<void> addToCart(DealModel deal) async {
  if (await exist("cart", deal.photoUrl)) {
    Fluttertoast.showToast(msg: "Item already in cart :) ");
  } else {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .add(deal.toJson())
        .whenComplete(() {
      Fluttertoast.showToast(msg: "Item added Successfully to cart :) ");});
  }
}

Future<void> addDealToSaved(DealModel deal) async {
  if (await exist("savedDeals", deal.photoUrl)) {
    Fluttertoast.showToast(msg: "Item already in saved");
  } else {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("savedDeals")
        .add(deal.toJson()).whenComplete(() {
          Fluttertoast.showToast(msg: "Item added successfully to Saved");});
  }
}

Future<void> removeDealFromSaved(String id) async {
  await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("savedDeals")
      .doc(id)
      .delete().whenComplete(() {
    Fluttertoast.showToast(msg: "Item removed successfully from Saved");
  });
}

Future<void> addRestaurantToSaved(restaurant) async {
  if (await exist("savedRestaurants", restaurant.photoUrl)) {
    Fluttertoast.showToast(msg: "Restaurant already in saved");
  } else {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("savedRestaurants")
        .add(restaurant.toJson()).whenComplete(() {
      Fluttertoast.showToast(msg: "Restaurant added successfully to Saved");});
  }
}

Future<void> removeRestaurantFromSaved(String id) async {
  await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("savedRestaurants")
      .doc(id)
      .delete().whenComplete(() {  Fluttertoast.showToast(msg: "Restaurant removed successfully from Saved");
  });
}

Future<bool> exist(String source, String photoUrl) async {
  return await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(source)
      .get()
      .then((element) {
    return element.docs.any((element) {
      return element.data()["photoUrl"] == photoUrl;
    });
  });
}
