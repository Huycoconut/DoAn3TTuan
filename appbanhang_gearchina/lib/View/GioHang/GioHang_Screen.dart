import 'package:appbanhang_gearchina/View/GioHang/data_Giohang.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/SpThanhToan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:appbanhang_gearchina/View/GioHang/class_LuuTruSp_TrongGio.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/ThanhToan_Screen.dart';

class gioHang_Screen extends StatefulWidget {
  const gioHang_Screen({super.key});

  @override
  State<gioHang_Screen> createState() => _gioHang_ScreenState();
}

class _gioHang_ScreenState extends State<gioHang_Screen> {
  List<SanPham> selectedProducts = [];
  SanPham? _chiTietSp;
  @override
  void initState() {
    super.initState();
  }

  bool isSelected = false;

  List<bool> isCheckedList = [];

  //Xóa sản phẩm
  void _capNhatTrangThaiSp(String productId, String newStatus) {
    final productRef =
        FirebaseDatabase.instance.ref("GioHang/$productId/sanPham/TrangThai");
    productRef.set(newStatus);
  }

//
  void _chuyenTrangThai_Mau(String productId, String newMau) {
    final productRef =
        FirebaseDatabase.instance.ref("GioHang/$productId/sanPham/Mau");
    productRef.set(newMau);
  }

//
  void _thanhToanSp() {
    String? userId;
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser?.uid;
    }
    final ref = FirebaseDatabase.instance.ref("GioHang");

    final refg = FirebaseDatabase.instance.ref("GioHang");
    ref.orderByChild("userId").equalTo(userId).onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        data.forEach((key, value) {
          final productData = value as Map<dynamic, dynamic>;
          if (productData["sanPham"]["Mau"] == "1") {
            final product = SanPham(
              GiamGia: _chiTietSp!.GiamGia,
              Id: _chiTietSp!.Id,
              Ten: _chiTietSp!.Ten,
              SoLuong: _chiTietSp!.SoLuong,
              Gia: _chiTietSp!.Gia,
              Hinh: _chiTietSp!.Hinh,
              Loai: _chiTietSp!.Loai,
              Mau: _chiTietSp!.Mau,
              MauSac: _chiTietSp!.MauSac,
              MoTa: _chiTietSp!.MoTa,
              ThongSo: _chiTietSp!.ThongSo,
              TrangThai: _chiTietSp!.TrangThai,
            );
            selectedProducts.add(product);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

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
                  if (snapshot.child('userId').value.toString() == userId &&
                      snapshot.child('TrangThai').value.toString() == '1') {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                final productID = snapshot.key;
                                final TrangThaiHienTai =
                                    snapshot.child('Mau').value.toString();

                                final newMau =
                                    TrangThaiHienTai == '1' ? '0' : '1';
                                _chuyenTrangThai_Mau(productID!, newMau);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              padding: const EdgeInsets.only(bottom: 15),
                              decoration:
                                  snapshot.child('Mau').value.toString() == '1'
                                      ? BoxDecoration(
                                          border: Border.all(
                                            color: Colors.green,
                                            width: 2.0,
                                          ),
                                        )
                                      : null,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Image.network(
                                            snapshot
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
                                                .child('Ten')
                                                .value
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              "Số lượng: ${snapshot.child('SoLuong').value.toString()}"),
                                          Text(
                                            "Màu: ${snapshot.child('MauSac').child('TenMau').child('TrangThai').value.toString() == '0' ? "Xám" : snapshot.child('MauSac').child('TenMau').child('TrangThai').value.toString() == '1' ? "Đen" : "Trắng"}",
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  snapshot
                                                      .child('GiamGia')
                                                      .value
                                                      .toString(),
                                                  style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey,
                                                  )),
                                              Text(
                                                snapshot
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpThanhToan(payItems: selectedProducts),
                ),
              );
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
