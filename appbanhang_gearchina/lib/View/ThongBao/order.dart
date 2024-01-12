import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({super.key});
  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    String? userId;
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser?.uid;
    }
    final ref = FirebaseDatabase.instance.ref("/order");
    return Container(
      decoration: const BoxDecoration(border: Border()),
      child: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (context, snapshot, animation, index) {
            if (snapshot.child('userId').value.toString() == userId) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Tổng tiền: ${snapshot.child('total').value.toString()}"),
                      Row(
                        children: [
                          const Text(
                            "Trạng thái đơn: ",
                            style: const TextStyle(fontSize: 11),
                          ),
                          Text(
                            snapshot.child('status').value == 1
                                ? "Đang xác nhận"
                                : snapshot.child('status').value == 2
                                    ? "Đang giao"
                                    : "Đã giao",
                            style: const TextStyle(fontSize: 11),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
