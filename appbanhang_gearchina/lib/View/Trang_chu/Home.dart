import 'package:appbanhang_gearchina/View/SanPham/load_SanPham.dart';
import 'package:appbanhang_gearchina/View/Trang_chu/botNav.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Load_SanPham();

    // return Scaffold(

    //   bottomNavigationBar: bottomNav(),

    //   body:  Column(children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //             // IconButton(onPressed: (){}, icon: Icon(Icons.laptop)),
    //             // IconButton(onPressed: (){}, icon: Icon(Icons.keyboard)),
    //             // IconButton(onPressed: (){}, icon: Icon(Icons.mouse)),
    //             // IconButton(onPressed: (){}, icon: Icon(Icons.headphones)),
    //             // IconButton(onPressed: (){}, icon: Icon(Icons.phone_android)),
    //       ],
    //     ),

    //       ],
    //     ),

    // );
  }
}
