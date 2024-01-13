import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class MauSac_Sp extends StatefulWidget {
  const MauSac_Sp({super.key,required this.sanPham});
final MauSac_SanPham sanPham;
  @override
  State<MauSac_Sp> createState() => _MauSac_SpState();
}

class _MauSac_SpState extends State<MauSac_Sp> {
 final dbref = FirebaseDatabase.instance.ref().child('MauSac');
   List<Map<dynamic, dynamic>> mauSacData = [];

  MauSac_SanPham? _chiTietSp;
  @override
  void initState() {
    super.initState();
    _chiTietSp = widget.sanPham;

  }

void _hienMauSac(){
  
}

    bool _isFirstSelected = true;
  bool _isSecondSelected = false;
  bool _isThirdSelected = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(_chiTietSp?.TenMau),
          Container(
            margin: const EdgeInsets.only(left: 25, top: 15),
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
                  _isFirstSelected ? Icons.circle : Icons.check_circle_rounded,
                  size: 40,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isFirstSelected = !_isFirstSelected;
                    _isSecondSelected = true;
                    _isThirdSelected = true;
              });
                },
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(
                  _isSecondSelected ? Icons.circle : Icons.check_circle_rounded,
                  size: 40,
                ),
                onPressed: () {
                  setState(() {
                    _isFirstSelected = true;
                    _isSecondSelected = !_isSecondSelected;
                    _isThirdSelected = true;
                  });
                },
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(
                  _isThirdSelected ? Icons.circle : Icons.check_circle_rounded,
                  size: 40,
                  color: Colors.pinkAccent,
                ),
                onPressed: () {
                  setState(() {
                    _isThirdSelected = !_isThirdSelected;
                    _isFirstSelected = true;
                    _isSecondSelected = true;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
