import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class MauSac_Sp extends StatefulWidget {
  const MauSac_Sp({super.key});

  @override
  State<MauSac_Sp> createState() => _MauSac_SpState();
}

class _MauSac_SpState extends State<MauSac_Sp> {
  final dbref = FirebaseDatabase.instance.ref().child('SanPham/');
  final bool _isPress = false;
  final _soLuong = 0;
  final _tongTien = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 25, top: 15),
          child: const Text(
            "Màu sắc",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.circle,
                size: 40,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.circle,
                size: 40,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.circle,
                size: 40,
                color: Colors.pinkAccent,
              ),
            )
          ],
        )
      ],
    );
  }
}
