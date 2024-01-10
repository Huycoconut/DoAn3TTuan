import 'package:appbanhang_gearchina/View/GioHang/class_LuuTruSp_TrongGio.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/ThanhToan_Screen.dart';
import 'package:appbanhang_gearchina/View/GioHang/SpTrongGio.dart';
import 'package:flutter/material.dart';

class gioHang_Screen extends StatefulWidget {
  const gioHang_Screen({Key? key}) : super(key: key);

  @override
  State<gioHang_Screen> createState() => _gioHang_ScreenState();
}

class _gioHang_ScreenState extends State<gioHang_Screen> {
  //SanPham? _sanPhamTrongGio;
  final sp_trongGio = GioHang.HienSpTrongGio();

  void addProduct(SanPham sanPhamDuocThem) {
    sp_trongGio.add(sanPhamDuocThem);
  }
  final bool _isPress = false;
  var _soLuong = 0;
  var _tongTien = 0;
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
                itemCount: sp_trongGio.length,
                itemBuilder: (context, index) {
                  final item = sp_trongGio[index];
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Checkbox(
                                value: check,
                                onChanged: (bool? check) => setState(() {
                                  this.check = check!;
                                }),
                              ),
                              Image.asset(
                                "assets/h2.jpg",
                                fit: BoxFit.contain,
                                width: media.width / 4.5,
                                height: media.height / 7,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Container(
                                  //padding: const EdgeInsets.only(right: 85),
                                  child: Column(
                                    //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.Ten,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: const Text(
                                              "Màu sắc: ",
                                              textAlign: TextAlign.start,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  right: 45),
                                              child: const Text(
                                                "Bạc",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 35,
                                            alignment: Alignment.topCenter,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                                    icon: const Icon(Icons
                                                        .remove_circle_outline)),
                                                Text('$_soLuong'),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _soLuong++;
                                                    });
                                                    _tongTien =
                                                        _tongTien + 1400000;
                                                  },
                                                  icon: const Icon(
                                                      Icons.add_circle_outline,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '$_tongTien',
                                            softWrap: true,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
