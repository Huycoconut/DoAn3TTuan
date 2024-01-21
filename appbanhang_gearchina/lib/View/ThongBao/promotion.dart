import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Promotion extends StatefulWidget {
  const Promotion({super.key});

  @override
  State<Promotion> createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  final ref = FirebaseDatabase.instance.ref("/KhuyenMai");
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border()),
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
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(snapshot.child('Ten').value.toString()),
                    Text(
                      "Hiệu lực từ ${snapshot.child('NgayBatDau').value.toString()} - ${snapshot.child('NgayKetThuc').value.toString()}",
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
