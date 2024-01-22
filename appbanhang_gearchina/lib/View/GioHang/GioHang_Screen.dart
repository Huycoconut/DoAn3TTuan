import 'package:appbanhang_gearchina/View/GioHang/data_Giohang.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/SpThanhToan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:appbanhang_gearchina/View/GioHang/class_LuuTruSp_TrongGio.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/ThanhToan_Screen.dart';

int dem = 0;

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
  bool isCheck = false;

  List<bool> isCheckedList = [];

  //Xóa sản phẩm
  void _capNhatTrangThaiSp(String productId, String newStatus) {
    final productRef =
        FirebaseDatabase.instance.ref("GioHang/$productId/TrangThai");
    productRef.set(newStatus);
  }

//
  void _chuyenTrangThai_Mau(String productId, String newMau) {
    final productRef = FirebaseDatabase.instance.ref("GioHang/$productId/Mau");
    productRef.set(newMau);
  }

  //
  bool kiemTraGiohang() {
    final productRef = FirebaseDatabase.instance.ref("GioHang");
    productRef.once().then((DatabaseEvent snapshot) {
      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic> gioHang =
            snapshot.snapshot.value as Map<dynamic, dynamic>;
        gioHang.forEach((key, value) {
          setState(() {
            if (value['Mau'] == '1') {
              isCheck = false;
            } else {
              isCheck = true;
            }
          });
        });
      }
    });
    return isCheck;
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
                  if (snapshot.child('userID').value.toString() == userId &&
                      snapshot.child('TrangThai').value.toString() == '1') {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          snapshot
                                                      .child('Mau')
                                                      .value
                                                      .toString() ==
                                                  '1'
                                              ? isSelected == false
                                              : true;
                                          print(isSelected);
                                          final productID = snapshot.key;
                                          final TrangThaiHienTai = snapshot
                                              .child('Mau')
                                              .value
                                              .toString();
                                          TrangThaiHienTai == '1'
                                              ? (dem++)
                                              : (dem--);
                                          final newMau = TrangThaiHienTai == '1'
                                              ? '0'
                                              : '1';
                                          _chuyenTrangThai_Mau(
                                              productID!, newMau);
                                          kiemTraGiohang();
                                        });
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 15),
                                        padding: const EdgeInsets.only(
                                            bottom: 15, left: 20, right: 30),
                                        decoration: snapshot
                                                    .child('Mau')
                                                    .value
                                                    .toString() ==
                                                '1'
                                            ? BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.green,
                                                  width: 2.0,
                                                ),
                                              )
                                            : null,
                                        child: Row(
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
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.grey,
                                                        )),
                                                    Text(
                                                      snapshot
                                                          .child('Gia')
                                                          .value
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.redAccent),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: isSelected == false
                                            ? () {
                                                setState(() {
                                                  isSelected = !isSelected;
                                                  final productID =
                                                      snapshot.key;
                                                  final TrangThaiHienTai =
                                                      snapshot
                                                          .child('TrangThai')
                                                          .value
                                                          .toString();

                                                  final newTrangThai =
                                                      TrangThaiHienTai == '1'
                                                          ? '0'
                                                          : '1';
                                                  _capNhatTrangThaiSp(
                                                      productID!, newTrangThai);
                                                  print(isSelected);
                                                });
                                                kiemTraGiohang();
                                              }
                                            : null,
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
            onPressed: isCheck == false
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SpThanhToan(),
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
