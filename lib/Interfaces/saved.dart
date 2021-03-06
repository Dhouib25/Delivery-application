import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iac_project/Widgets/parts.dart';
import '../Widgets/contents.dart';
import '../models.dart';
import '../globals.dart' as globals;

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  setSaved(FeedElement x) async {
      await globals.removeRestaurantFromSaved(x.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffbd2005),
        title: const Text(
          "Favorites",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      bottomNavigationBar: const BotBar(i: 3),
      body: ListView(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('savedRestaurants')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Restaurants :",
                            style: TextStyle(
                                fontSize: 22, color: Color(0xffbd2005)),
                          )),
                      Center(
                        child: Column(
                            children: snapshot.data!.docs.map((document) {
                          RestaurantModel restaurant =
                              RestaurantModel.fromJson(document.data());
                          return FeedElement(
                            restaurant: restaurant,
                            id: document.id, setSaved: setSaved,
                          );
                        }).toList()),
                      ),
                    ],
                  );
                }
              }),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('savedDeals')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Deals :",
                            style: TextStyle(
                                fontSize: 22, color: Color(0xffbd2005)),
                          )),
                      Center(
                        child: Column(
                            children: snapshot.data!.docs.map((document) {
                          DealModel d = DealModel.fromJson(document.data());
                          return RestaurantElement(
                              deal: d,
                              id: document.id,
                              buttonText: "Add to cart",
                              buttonRole: () {
                                globals.addToCart(d);
                              });
                        }).toList()),
                      ),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}
