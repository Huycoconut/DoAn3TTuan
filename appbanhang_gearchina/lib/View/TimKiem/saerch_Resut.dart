import 'package:appbanhang_gearchina/View/GioHang/GioHang_Screen.dart';
import 'package:appbanhang_gearchina/View/GioHang/class_LuuTruSp_TrongGio.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:appbanhang_gearchina/View/TimKiem/SoSanh.dart';
import 'package:appbanhang_gearchina/View/TimKiem/TimKiem_screen.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResultSearch extends StatefulWidget {
  const ResultSearch({super.key, required this.fres});
  final String fres;

  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  List<SanPham> cartItems = [];
  //Load sản phẩm
  void _loadCartItems() {
    Cart cart = Cart();
    setState(() {
      cartItems = cart.cartItems;
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
                              cartItems: cartItems,
                            )));
              },
              icon: const Icon(Icons.shopping_bag),
              color: Colors.white),
        ],
      ),
      body: SoSanh(chuoi: widget.fres),
    );
  }
}