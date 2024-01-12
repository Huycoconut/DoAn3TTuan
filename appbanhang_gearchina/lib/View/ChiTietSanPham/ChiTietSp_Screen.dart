import 'package:appbanhang_gearchina/View/ChiTietSanPham/Anh_Sp.dart';
import 'package:appbanhang_gearchina/View/ChiTietSanPham/Appbar_ChiTiet_Sp.dart';
import 'package:appbanhang_gearchina/View/ChiTietSanPham/Btn_Them&Mua.dart';
import 'package:appbanhang_gearchina/View/ChiTietSanPham/MauSac_Sp.dart';
import 'package:appbanhang_gearchina/View/ChiTietSanPham/QL_SoLuongSp.dart';
import 'package:appbanhang_gearchina/View/GioHang/GioHang_Screen.dart';
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
    super.initState();
    _chiTietSp = widget.sanPham;
  }

  void _ThemVaMua() {
    SanPham currentProduct = SanPham(
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
    cartItems.add(currentProduct);
    payItems.add(currentProduct);
  }

//Thêm sản phẩm vào giỏ hàng
  List<SanPham> cartItems = [];
//Mua sản phẩm
  List<SanPham> payItems = [];
//Cập nhật số lượng sản phẩm
  void _updateData(int index, int newSoLuong) async {
    final DatabaseReference ref = dbref.child(index.toString());
    await ref.update({
      'SoLuong': newSoLuong,
    });
  }

//Cập nhật màu được chọn
  bool _isFirstSelected = false;
  bool _isSecondSelected = true;
  bool _isThirdSelected = true;

  int currentTrangThai = 0;

  void updateTrangThai(int index, int trangThai) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    DatabaseReference sanPhamReference = databaseReference
        .child('SanPham')
        .child(index.toString())
        .child('MauSac/$index');
    int newTrangThai = (trangThai == 0) ? 1 : 0;

    sanPhamReference.update({'TrangThai': newTrangThai}).then((value) {
      print('Cập nhật giá trị thành công cho index $index.');
    }).catchError((error) {
      print('Có lỗi xảy ra khi cập nhật giá trị cho index $index: $error');
    });
  }

  List<Map<String, dynamic>> indexList = [
    {'index': 0, 'TrangThai': 0},
    {'index': 1, 'TrangThai': 0},
    {'index': 2, 'TrangThai': 0},
  ];

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
                                                  _chiTietSp!.SoLuong--;
                                                  _updateData(_chiTietSp!.Id,
                                                      _chiTietSp!.SoLuong);
                                                });
                                              },
                                              icon: const Icon(
                                                  Icons.remove_circle_outline)),
                                          Text((_chiTietSp?.SoLuong ?? 0)
                                              .toString()),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _chiTietSp!.SoLuong++;
                                                _updateData(_chiTietSp!.Id,
                                                    _chiTietSp!.SoLuong);
                                              });
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
                            //Màu sắc sản phẩm
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 25, top: 15),
                                  child: const Text(
                                    "Màu sắc",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        _isFirstSelected
                                            ? Icons.circle
                                            : Icons.check_circle_rounded,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isFirstSelected = !_isFirstSelected;
                                          _isSecondSelected = true;
                                          _isThirdSelected = true;

                                          indexList[0]['TrangThai'] =
                                              (indexList[0]['TrangThai'] == 0)
                                                  ? 1
                                                  : 0;
                                          updateTrangThai(indexList[0]['index'],
                                              indexList[0]['TrangThai']);
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 16),
                                    IconButton(
                                      icon: Icon(
                                        _isSecondSelected
                                            ? Icons.circle
                                            : Icons.check_circle_rounded,
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isFirstSelected = true;
                                          _isSecondSelected =
                                              !_isSecondSelected;
                                          _isThirdSelected = true;
                                          currentTrangThai =
                                              (currentTrangThai == 0) ? 1 : 0;

                                          indexList[1]['TrangThai'] =
                                              (indexList[1]['TrangThai'] == 0)
                                                  ? 1
                                                  : 0;
                                          updateTrangThai(indexList[0]['index'],
                                              indexList[1]['TrangThai']);
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 16),
                                    IconButton(
                                      icon: Icon(
                                        _isThirdSelected
                                            ? Icons.circle
                                            : Icons.check_circle_rounded,
                                        size: 40,
                                        color: Colors.pinkAccent,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isThirdSelected = !_isThirdSelected;
                                          _isFirstSelected = true;
                                          _isSecondSelected = true;
                                          currentTrangThai =
                                              (currentTrangThai == 0) ? 1 : 0;

                                          indexList[2]['TrangThai'] =
                                              (indexList[2]['TrangThai'] == 0)
                                                  ? 1
                                                  : 0;
                                          updateTrangThai(indexList[0]['index'],
                                              indexList[2]['TrangThai']);
                                        });
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
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
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            //Giỏ hàng
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
                                      _ThemVaMua();
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
                                      _ThemVaMua();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                thanhToan_Screen(
                                                  payItems: payItems,
                                                )),
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
                    Row(
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => gioHang_Screen(
                                          cartItems: cartItems,
                                        )));
                          },
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
