import 'package:flutter/material.dart';

class Appbar_ChiTiet_Sp extends StatefulWidget {
  const Appbar_ChiTiet_Sp({super.key});

  @override
  State<Appbar_ChiTiet_Sp> createState() => _Appbar_ChiTiet_SpState();
}

class _Appbar_ChiTiet_SpState extends State<Appbar_ChiTiet_Sp> {
  @override
  Widget build(BuildContext context) {
    return   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                  ),
                ),
                const Text(
                  "Chi tiết sản phẩm",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                  ),
                ),
              ],
            ) ;
  }
}