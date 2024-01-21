import 'package:appbanhang_gearchina/View/GioHang/GioHang_Screen.dart';
import 'package:appbanhang_gearchina/View/GioHang/class_LuuTruSp_TrongGio.dart';
import 'package:appbanhang_gearchina/View/HoaDon/HoaDon.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:appbanhang_gearchina/View/TimKiem/TimKiem_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Screen_HoaDon extends StatefulWidget {
  const Screen_HoaDon({Key? key}) : super(key: key);

  @override
  State<Screen_HoaDon> createState() => _Screen_HoaDonState();
}

class _Screen_HoaDonState extends State<Screen_HoaDon> {
  @override
  List<SanPham> cartItems = [];
  //Load sản phẩm
  void _loadCartItems() {
    Cart cart = Cart();
    setState(() {
      cartItems = Cartlocal.cartItems;
    });
  }
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCartItems();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
           Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back), color: Colors.white,),
        backgroundColor: const Color.fromRGBO(56, 60, 160, 20),
        // automaticallyImplyLeading: true,
        actions: [
          
          IconButton(onPressed: (){
            // showSearch(
            //   context: context, 
            //   delegate: CustomSearch()
            // );
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Search()));
          }, icon: const Icon(Icons.search), color: Colors.white,),
            
          
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => gioHang_Screen(
                            )));
              },
              icon: const Icon(Icons.shopping_bag),
              color: Colors.white),
        ],
      ),
      body: load_HoaDon()
           
            
            
            // TextButton(onPressed: () {
              
            // }, child: Icon(Icons.search))
          
      );
  }
}