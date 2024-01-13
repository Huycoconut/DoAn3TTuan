import 'package:flutter/material.dart';
import 'package:appbanhang_gearchina/View/GioHang/class_LuuTruSp_TrongGio.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/ThanhToan_Screen.dart';

class gioHang_Screen extends StatefulWidget {
  final List<SanPham> cartItems;

  const gioHang_Screen({super.key, required this.cartItems});

  @override
  State<gioHang_Screen> createState() => _gioHang_ScreenState();
}

class _gioHang_ScreenState extends State<gioHang_Screen> {
  //List<SanPham> cartItems = [];
  List<SanPham> selectedItems = [];
  List<SanPham> cartItems = CartItems.cartItems;
  bool _isButtonEnabled = false;

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

  final bool _check = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    _isButtonEnabled = selectedItems.isNotEmpty;

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
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final sanPham = widget.cartItems[index];
                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: selectedItems.contains(sanPham),
                              onChanged: (value) {
                                setState(() {
                                  if (value!) {
                                    selectedItems.add(sanPham);
                                  } else {
                                    selectedItems.remove(sanPham);
                                  }
                                });
                              },
                            ),
                            Column(
                              children: [
                                Image.network(
                                  sanPham.Hinh,
                                  width: media.width / 3.5,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sanPham.Ten,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Số lượng: ${sanPham.SoLuong}"),
                                const Text("Màu: xanh"),
                                Row(
                                  children: [
                                    const Text(
                                      "₫2000000 ",
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      sanPham.Gia.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(
                  left: 90, right: 90, top: 10, bottom: 10),
              backgroundColor: const Color.fromRGBO(56, 60, 160, 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: _isButtonEnabled
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            thanhToan_Screen(payItems: selectedItems),
                      ),
                    );
                  }
                : null,
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
