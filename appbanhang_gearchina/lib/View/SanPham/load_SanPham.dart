import 'package:appbanhang_gearchina/View/ChiTietSanPham/ChiTietSp_Screen.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'dart:convert';
import 'package:appbanhang_gearchina/localStorage/slider.dart';
import 'package:appbanhang_gearchina/localStorage/local_storage_slide_show.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Load_SanPham extends StatefulWidget {
  const Load_SanPham({Key? key}) : super(key: key);

  @override
  State<Load_SanPham> createState() => _Load_SanPhamState();
}

class _Load_SanPhamState extends State<Load_SanPham> {
  final dbref = FirebaseDatabase.instance.ref().child('SanPham');
  final refSlider = FirebaseDatabase.instance.ref().child('Slider');
  late Query refSlider1 =
      refSlider.orderByChild("TrangThai").startAt(1).endAt(2);
  List<SanPham> _listSanPham = [];
  List<Sliderr> listSlider = [];

  @override
  void initState() {
    // TODO: implement initState
    dbref.onValue.listen((event) {
      //Khoa : them kiem tra mounted de khong bi xung dot khi dang nhap
      if (mounted) {
        setState(() {
          _listSanPham = event.snapshot.children.map((snapshot) {
            return SanPham.fromSnapshot(snapshot);
          }).toList();
        });
      }
    });
  }

  //
  void _updateData_SoLuong_BanDau(int index) {
    User? user = FirebaseAuth.instance.currentUser;
    String userID = user!.uid;
    final DatabaseReference ref = dbref.child('$index');

    // Cập nhật giá trị số lượng thành 1
    ref.update({
      'SoLuong': 1,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 4,
          child: CarouselSlider.builder(
            itemCount: DB().boxSlider.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Container(
              child: imageFromBase64String(DB().readData(itemIndex).toString()),
            ),
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              initialPage: 2,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
            ),
            itemCount: _listSanPham.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _updateData_SoLuong_BanDau(index);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => chiTietSp_Screen(
                                sanPham: _listSanPham[index],
                              )),
                    );
                    _updateData_SoLuong_BanDau(index);
                  });
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        _listSanPham[index].Hinh,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width / 1,
                        height: MediaQuery.of(context).size.width / 4,
                      ),
                      Container(
                        child: Text(
                          _listSanPham[index].Ten,
                          softWrap: true,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        _listSanPham[index].ThongSo,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(_listSanPham[index].Gia.toString())
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }
}
