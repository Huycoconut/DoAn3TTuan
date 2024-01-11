import 'package:appbanhang_gearchina/View/ThanhToan/ThanhToan_Screen.dart';
import 'package:appbanhang_gearchina/View/GioHang/GioHang_Screen.dart';
import 'package:flutter/material.dart';

class Btn_Them_Mua extends StatefulWidget {
  const Btn_Them_Mua({super.key});

  @override
  State<Btn_Them_Mua> createState() => _Btn_Them_MuaState();
}

class _Btn_Them_MuaState extends State<Btn_Them_Mua> {
  final bool _isFirstSelected = false;
  final bool _isSecondSelected = false;
  final bool _isThirdSelected = false;
  final _soLuong = 0;
  final _tongTien = 0;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 22),
      width: media.width / 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left: 10, right: 10),
                backgroundColor: const Color.fromRGBO(56, 60, 160, 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            onPressed: _isFirstSelected == true ||
                    _isSecondSelected == true ||
                    _isThirdSelected == true
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const gioHang_Screen()),
                    );
                  },
            child: const Text(
              "Thêm vào giỏ hàng",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left: 50, right: 50),
                backgroundColor: const Color.fromRGBO(56, 60, 160, 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const thanhToan_Screen()),
              );
            },
            child: const Text(
              "Mua ngay",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
