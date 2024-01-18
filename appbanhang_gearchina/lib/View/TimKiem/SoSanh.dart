import 'package:appbanhang_gearchina/View/ChiTietSanPham/ChiTietSp_Screen.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SoSanh extends StatefulWidget {
  const SoSanh({super.key, required this.chuoi});
  final String chuoi;
  @override
  State<SoSanh> createState() => _SoSanhState();
}

class _SoSanhState extends State<SoSanh> {
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
    List<SanPham> _lstResult = [];
    for (var item in _listSanPham) {
      if (item.Ten.toLowerCase().contains(widget.chuoi.toLowerCase())) {
        _lstResult.add(item);
      }
    }
    return  GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
      ),
      itemCount: _lstResult.length,
      itemBuilder: (context, index) {
        // // if (widget.chuoi == _listSanPham[index].Ten) {
        // if (_listSanPham[index].Ten.toLowerCase().contains(widget.chuoi.toLowerCase())) {
          return GestureDetector(
          onTap: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => chiTietSp_Screen(
                          sanPham: _lstResult[index],
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
                  _lstResult[index].Hinh,
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width / 1,
                  height: MediaQuery.of(context).size.width / 4,
                ),
                Container(
                  child: Text(
                    _lstResult[index].Ten,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  _lstResult[index].ThongSo,
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ), 
                  // style: const TextStyle(
                  //   color: Colors.grey,
                  // ),
                ),
                Text(_lstResult[index].Gia.toString(),
                softWrap: true,
                  style: const TextStyle(
                      fontSize: 15,
                    ),)
              ],
            ),
          ),
        );
        }
        // else{
        //   return null;
        // }
      // },
    );
  }
}