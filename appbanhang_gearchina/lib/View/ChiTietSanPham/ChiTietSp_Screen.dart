import 'package:appbanhang_gearchina/View/ChiTietSanPham/Anh_Sp.dart';
import 'package:appbanhang_gearchina/View/ChiTietSanPham/Appbar_ChiTiet_Sp.dart';
import 'package:appbanhang_gearchina/View/ChiTietSanPham/Btn_Them&Mua.dart';
import 'package:appbanhang_gearchina/View/ChiTietSanPham/MauSac_Sp.dart';
import 'package:appbanhang_gearchina/View/ChiTietSanPham/QL_SoLuongSp.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/ThanhToan_Screen.dart';
import 'package:appbanhang_gearchina/View/GioHang/GioHang_Screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class chiTietSp_Screen extends StatefulWidget {
  const chiTietSp_Screen({super.key});

  @override
  State<chiTietSp_Screen> createState() => _chiTietSp_ScreenState();
}

class _chiTietSp_ScreenState extends State<chiTietSp_Screen> {
  final dbref = FirebaseDatabase.instance.ref().child("SanPham");

  List<SanPham> _listChiTiet_Sp = [];

  @override
  void initState() {
    // TODO: implement initState

    dbref.onValue.listen((event) {
      setState(() {
        _listChiTiet_Sp = event.snapshot.children.map((snapshot) {
          return SanPham.fromSnapshot(snapshot);
        }).toList();
      });
    });
  }

  final bool _isPress = false;
  final _soLuong = 0;
  final _tongTien = 0;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const Anh_Sp(),
            Container(
              width: media.width / 0.5,
              margin: const EdgeInsets.only(top: 350),
              child: Container(
                padding: const EdgeInsets.only(bottom: 22),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const QL_SoLuongSp(),
                    const MauSac_Sp(),
                    Container(
                      margin: const EdgeInsets.only(left: 25, top: 15),
                      child: const Text(
                        "Chi tiết",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 25, top: 5, right: 10),
                      child: const Text(
                        "",
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const Btn_Them_Mua()
                  ],
                ),
              ),
            ),
            const Appbar_ChiTiet_Sp()
          ],
        ),
      ),
    );
  }
}
