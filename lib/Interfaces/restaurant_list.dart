import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Widgets/contents.dart';
import '../../models.dart';
import '../globals.dart' as globals;

class RestaurantList extends StatefulWidget {
  final String text;
  final Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;
  const RestaurantList({Key? key, required this.text, required this.snapshot})
      : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  setSaved(FeedElement x) async {
    if (x.source == "assets/icons/heart.png") {
      await globals.addRestaurantToSaved(x.restaurant,x.id);
      setState(() {
        x.source = "assets/icons/heart1.png";
      });
    } else {
      await globals.removeRestaurantFromSaved(x.id);
      setState(() {
        x.source = "assets/icons/heart.png";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffbd2005),
        title: Text(
          widget.text,
          style: const TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      body: StreamBuilder(
          stream:
              widget.snapshot,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                      children: snapshot.data!.docs.map((document) {
                    RestaurantModel r =
                        RestaurantModel.fromJson(document.data());
                    return FeedElement(
                      restaurant: r,
                      id: document.reference.id, setSaved: setSaved,
                    );
                  }).toList()),
                ),
              );
            }
          }),
    );
  }
}
