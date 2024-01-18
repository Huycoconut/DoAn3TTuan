import 'package:appbanhang_gearchina/View/GioHang/GioHang_Screen.dart';
import 'package:appbanhang_gearchina/View/GioHang/class_LuuTruSp_TrongGio.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:appbanhang_gearchina/View/SanPham/load_SanPham.dart';
import 'package:appbanhang_gearchina/View/Timkiem/load_ds.dart';
import 'package:appbanhang_gearchina/View/Timkiem/saerch_Resut.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
    final dbref = FirebaseDatabase.instance.ref().child('SanPham');

  List<DStenSanPham> _listTenSanPham = [];
  
  String TextVL = "";
  

   @override
  void initState() {
    // TODO: implement initState
    dbref.onValue.listen((event) {
      //Khoa : them kiem tra mounted de khong bi xung dot khi dang nhap
      if(this.mounted){
        setState(() {
          _listTenSanPham = event.snapshot.children.map((snapshot) {
            return DStenSanPham.fromSnapshot(snapshot);
          }).toList();
        });
      }
    });
  }
  @override
   List<SanPham> cartItems = [];
  //Load sản phẩm
  void _loadCartItems() {
    Cart cart = Cart();
    setState(() {
      cartItems = cart.cartItems;
    });
  }

  @override
  void initState1() {
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
      body: Column(
        children: [
             TextField(
              onChanged:  (value) {
                TextVL = value.toString();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập tên sản phẩm cần tìm kiếm",
              ),
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultSearch(fres: TextVL)),
              );
            }, child: Text('search')),
            
        ],
      )
           
            
            
            // TextButton(onPressed: () {
              
            // }, child: Icon(Icons.search))
          
      );
} 
          // suggestionsBuilder:
          //         (BuildContext context, SearchController controller) {
          //   return List<ListTile>.generate(5, (int index) {
          //     final String item = 'item $index';
          //     return ListTile(
          //       title: Text(item),
          //       onTap: () {
          //         setState(() {
          //           controller.closeView(item);
          //         });
          //       },
          //     );
          //   });}
          
  }
