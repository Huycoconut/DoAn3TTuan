import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class DetailPromoScreen extends StatelessWidget {
  const DetailPromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref("/KhuyenMai");
    return Scaffold(
      appBar: AppBar(title: Text("Chi tiết khuyến mãi")),
      body: Container(
        padding: EdgeInsets.all(8),
        child: FirebaseAnimatedList(
            query: ref,
            itemBuilder: (context, snapshot, animation, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.child('Ten').value.toString()),
                          Text(
                            "${snapshot.child('NgayBatDau').value.toString()} - ${snapshot.child('NgayKetThuc').value.toString()}",
                            style: TextStyle(fontSize: 11),
                          )
                        ],
                      ),
                      Text(snapshot.child('MoTa').value.toString()),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
