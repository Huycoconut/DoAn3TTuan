import 'package:appbanhang_gearchina/View/ChiTietSanPham/ChiTietSp_Screen.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Load_SanPham extends StatefulWidget {
  const Load_SanPham({Key? key}) : super(key: key);

  @override
  State<Load_SanPham> createState() => _Load_SanPhamState();
}

class _Load_SanPhamState extends State<Load_SanPham> {
  final dbref = FirebaseDatabase.instance.ref().child('SanPham');

  List<SanPham> _listSanPham = [];

  @override
  void initState() {
    // TODO: implement initState
    dbref.onValue.listen((event) {
      //Khoa : them kiem tra mounted de khong bi xung dot khi dang nhap
      if(this.mounted){
        setState(() {
          _listSanPham = event.snapshot.children.map((snapshot) {
            return SanPham.fromSnapshot(snapshot);
          }).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
      ),
      itemCount: _listSanPham.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => chiTietSp_Screen(
                          sanPham: _listSanPham[index],
                        )),
              );
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
    );
  }
}
