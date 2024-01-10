import 'package:appbanhang_gearchina/View/ChiTietSanPham/Anh_Sp.dart';
import 'package:appbanhang_gearchina/View/ChiTietSanPham/Appbar_ChiTiet_Sp.dart';
import 'package:appbanhang_gearchina/View/ChiTietSanPham/MauSac_Sp.dart';
import 'package:appbanhang_gearchina/View/GioHang/class_LuuTruSp_TrongGio.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/ThanhToan_Screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class chiTietSp_Screen extends StatefulWidget {
  const chiTietSp_Screen({Key? key, required this.sanPham}) : super(key: key);

  final SanPham sanPham;
  @override
  State<chiTietSp_Screen> createState() => _chiTietSp_ScreenState();
}

class _chiTietSp_ScreenState extends State<chiTietSp_Screen> {
  final dbref = FirebaseDatabase.instance.ref().child('SanPham');

  SanPham? _chiTietSp;
  @override
  void initState() {
    // TODO: implement initState
    _chiTietSp = widget.sanPham;
  }

  void _ThemSpVaoGio() {
    GioHang.ThemSpVaoGio(widget.sanPham);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Đã thêm vào giỏ hàng")));
  }

  final bool _isPress = false;
  var _soLuong = 0;
  var _tongTien = 0;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          child: Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        _chiTietSp?.Hinh ?? "",
                        fit: BoxFit.cover,
                        width: media.width / 1,
                        height: media.height / 2,
                      ),
                    ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  _chiTietSp?.Ten ?? "",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 35,
                                      alignment: Alignment.topCenter,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (_soLuong <= 0) {
                                                    _soLuong = 0;
                                                  } else {
                                                    _soLuong--;
                                                  }
                                                  _tongTien =
                                                      _tongTien - 1400000;
                                                  if (_tongTien <= 0) {
                                                    _tongTien = 0;
                                                  }
                                                });
                                              },
                                              icon: const Icon(
                                                  Icons.remove_circle_outline)),
                                          Text('$_soLuong'),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _soLuong++;
                                              });
                                              _tongTien = _tongTien + 1400000;
                                            },
                                            icon: const Icon(
                                                Icons.add_circle_outline,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Text(
                                      "Số lượng",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                              ],
                            ),
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
                              margin: const EdgeInsets.only(
                                  left: 25, top: 5, right: 10),
                              child: Text(
                                _chiTietSp?.MoTa ?? "",
                                softWrap: true,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 22),
                              width: media.width / 0.1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        backgroundColor: const Color.fromRGBO(
                                            56, 60, 160, 20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    onPressed: () {
                                      _ThemSpVaoGio();
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
                                        padding: const EdgeInsets.only(
                                            left: 50, right: 50),
                                        backgroundColor: const Color.fromRGBO(
                                            56, 60, 160, 20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const thanhToan_Screen()),
                                      );
                                    },
                                    child: const Text(
                                      "Mua ngay",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Appbar_ChiTiet_Sp()
                  ],
                )
              ]),
        ),
      ),
    );
  }
}

class GioHang {
  static List<SanPham> items = [];
  static void ThemSpVaoGio(SanPham sanPham) {
    items.add(sanPham);
  }

  static List<SanPham> HienSpTrongGio() {
    return items;
  }
}
