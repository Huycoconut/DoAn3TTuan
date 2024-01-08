import 'package:appbanhang_gearchina/View/ThanhToan/ThanhToan_Screen.dart';
import 'package:appbanhang_gearchina/View/GioHang/SpTrongGio.dart';
import 'package:flutter/material.dart';

class gioHang_Screen extends StatefulWidget {
  const gioHang_Screen({super.key});

  @override
  State<gioHang_Screen> createState() => _gioHang_ScreenState();
}

class _gioHang_ScreenState extends State<gioHang_Screen> {
  final bool _isPress = false;
  final _soLuong = 0;
  final _tongTien = 0;
  bool check = false;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                ),
              ),
              const SizedBox(
                width: 85,
              ),
              const Text(
                "Giỏ hàng",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
              return const SingleChildScrollView(
                child: SpTrongGio(),
              );
            }),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                    left: 90, right: 90, top: 10, bottom: 10),
                backgroundColor: const Color.fromRGBO(56, 60, 160, 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const thanhToan_Screen()),
                );
              });
            },
            child: const Text(
              "Thanh toán",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
