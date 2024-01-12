
import 'package:appbanhang_gearchina/View/GioHang/GioHang_Screen.dart';
import 'package:appbanhang_gearchina/View/SanPham/SanPham_screen.dart';
import 'package:appbanhang_gearchina/View/Trang_chu/Home.dart';
import 'package:flutter/material.dart';

class bottomNav extends StatefulWidget {
  const bottomNav({super.key});

  @override
  State<bottomNav> createState() => _bottomNavState();
}

class _bottomNavState extends State<bottomNav> {
  int _currentIndex = 0;
  // thêm trang thông báo và cá nhân vào danh sách tabs để chuyển trang
  final tabs = [HomeScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: const Color.fromRGBO(56,60,160,20),  
        actions: [
          IconButton(onPressed: (){
            // showSearch(
            //   context: context, 
            //   delegate: CustomSearch()
            // );
             Navigator.push(context, MaterialPageRoute(builder: (context) => sanPham_screen()));

          }, icon: const Icon(Icons.search), color: Colors.white,),
         
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => gioHang_Screen()));
            
          }, icon: const Icon(Icons.shopping_bag),color: Colors.white),
          
          
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Thông báo'),
              BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Cá nhân'),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
class CustomSearch extends SearchDelegate {
  List<String> alldata = ['laptop ABC','Iphone 15 pro-max','bàn phím','chuột gaming','tai nghe bluetooth','pad chuột'];


  @override
  List<Widget> buildActions(BuildContext context){

    return[
      IconButton(onPressed: (){
        query = '';
      }, icon: const Icon(Icons.clear))
    ];
  }
  
  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(onPressed: (){
       close(context, null);
      }, icon: const Icon(Icons.arrow_back))
    ;
  }
  
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in alldata){
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    }
    return ListView.builder(itemCount: matchQuery.length,itemBuilder:(context, index) {
      var result = matchQuery[index];
      return ListTile(
        title: Text(result),
      );
    }, );
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in alldata){
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    }
    return ListView.builder(itemCount: matchQuery.length,itemBuilder:(context, index) {
      var result = matchQuery[index];
      return ListTile(
        title: Text(result),
      );
    }, );
  }
}