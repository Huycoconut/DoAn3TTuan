import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
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
    _loadCartItems_TrongGio();
  }

  void _loadCartItems() {
    setState(() {
      cartItems = GioHang_CRUD.HienSpTrongGio();
    });
  }

  //Load sản phẩm
  void _loadCartItems_TrongGio() {
    Cart cart = Cart();
    setState(() {
      cartItems = Cartlocal.cartItems;
    });
  }

  //Xóa sản phẩm
  void _capNhatTrangThaiSp(String productId, String newStatus) {
    final productRef =
        FirebaseDatabase.instance.ref("GioHang/$productId/sanPham/TrangThai");
    productRef.set(newStatus);
  }

//

  @override
  Widget build(BuildContext context) {

    var media = MediaQuery.of(context).size;
    _isButtonEnabled = selectedItems.isNotEmpty;

    String? userId;
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser?.uid;
    }
    final ref = FirebaseDatabase.instance.ref("GioHang");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.child('userID').value.toString() == userId &&
                      snapshot
                              .child('sanPham')
                              .child('TrangThai')
                              .value
                              .toString() ==
                          '1') {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.only(bottom: 15),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                width: 1,
                                color: Colors.grey,
                              )),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    
                                    Checkbox(
                                      value: _isButtonEnabled,
                                      onChanged: (value) {
                                        //Kiểm tra nếu check sản phẩm
                                        setState(() {
                                         
                                        });
                                      
                                      },
                                    ),
                                    Column(
                                      children: [
                                        Image.network(
                                          snapshot
                                              .child('sanPham')
                                              .child('Hinh')
                                              .value
                                              .toString(),
                                          width: media.width / 4.23,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot
                                              .child('sanPham')
                                              .child('Ten')
                                              .value
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "Số lượng: ${snapshot.child('sanPham').child('SoLuong').value.toString()}"),
                                        const Text(
                                            "Màu: ${/* sanPham.MauSac == 0 ? "Xám" : sanPham.MauSac == 1 ? "Đen" : */ "Bạc"}"),
                                        Row(
                                          children: [
                                            const Text(
                                              "₫2000000 ",
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              snapshot
                                                  .child('sanPham')
                                                  .child('Gia')
                                                  .value
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            final productID = snapshot.key;
                                            final TrangThaiHienTai = snapshot
                                                .child('sanPham')
                                                .child('TrangThai')
                                                .value
                                                .toString();

                                            final newTrangThai =
                                                TrangThaiHienTai == '1'
                                                    ? '0'
                                                    : '1';
                                            _capNhatTrangThaiSp(
                                                productID!, newTrangThai);
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.restore_from_trash,
                                          color: Colors.redAccent,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
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
