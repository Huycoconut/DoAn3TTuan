import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Anh_Sp extends StatefulWidget {
  const Anh_Sp({super.key});

  @override
  State<Anh_Sp> createState() => _Anh_SpState();
}

class _Anh_SpState extends State<Anh_Sp> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    final dbref = FirebaseDatabase.instance.ref().child('SanPham');

    List<SanPham> _ListSp = [];


    @override
    void initState() {
      dbref.onValue.listen((event) {
        _ListSp = event.snapshot.children.map((snapshot) {
          return SanPham.fromSnapshot(snapshot);
        }).toList();
      });
    }

    return FirebaseAnimatedList(
      query: dbref,
      itemBuilder: (context, snapshot, animation, index) {
        return Expanded(
          flex: 1,
          child: Image.network(
            _ListSp[index].Hinh,
            fit: BoxFit.cover,
            width: media.width / 1,
            height: media.height / 2,
          ),
        );
      },
    );
  }
}
