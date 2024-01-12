import 'package:appbanhang_gearchina/View/GioHang/class_LuuTruSp_TrongGio.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:flutter/material.dart';

class SpThanhToan extends StatefulWidget {
  const SpThanhToan({super.key});

  @override
  State<SpThanhToan> createState() => _SpThanhToanState();
}

class _SpThanhToanState extends State<SpThanhToan> {
  final _tongTien = 0;

    List<SanPham> cartItems = [];


    @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() {
    setState(() {
      cartItems = GioHang.HienSpTrongGio();
    });
  }

  void _addToCart(SanPham sanPham) {
    GioHang.ThemSpVaoGio(sanPham);
    // Hiển thị thông báo thành công hoặc cập nhật giao diện
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
  
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Image.asset(
                "assets/h2.jpg",
                fit: BoxFit.contain,
                width: media.width / 5,
                height: media.height / 9,
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "MacBook Air M1",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          child: const Text(
                            "Màu sắc: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(right: 45),
                            child: const Text(
                              "Bạc",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '$_tongTien',
                          softWrap: true,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const SizedBox(
                          width: 150,
                        ),
                        const Text(
                          "x1",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
