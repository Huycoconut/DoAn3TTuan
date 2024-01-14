import 'package:appbanhang_gearchina/View/ChiTietSanPham/ChiTietSp_Screen.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:appbanhang_gearchina/View/SanPham/load_SanPham.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class sanPham_screen extends StatefulWidget {
  const sanPham_screen({super.key});

  @override
  State<sanPham_screen> createState() => _sanPham_screenState();
}

class _sanPham_screenState extends State<sanPham_screen> {
  SortType _currentSortType = SortType.All;
  final dbref = FirebaseDatabase.instance.ref().child('SanPham');

  List<SanPham> _listSanPham = [];

  @override
  void initState() {
    // TODO: implement initState
    dbref.onValue.listen((event) {
      setState(() {
        _listSanPham = event.snapshot.children.map((snapshot) {
          return SanPham.fromSnapshot(snapshot);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_rounded),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black45,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.search),
                    const Text(
                      "Laptop...",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.display_settings_sharp),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    setState(() {
                      _currentSortType = SortType.All;
                      // Sắp xếp danh sách sản phẩm theo thứ tự ban đầu
                      _listSanPham.sort((a, b) => a.Id.compareTo(b.Id));
                    });
                  },
                  child: const Text(
                    "Tất cả",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    setState(() {
                      _currentSortType = SortType.Highest;
                      // Sắp xếp danh sách sản phẩm theo giá cao nhất
                      _listSanPham.sort((a, b) => b.Gia.compareTo(a.Gia));
                    });
                  },
                  child: const Text(
                    "Cao nhất",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    setState(() {
                      _currentSortType = SortType.Lowest;
                      // Sắp xếp danh sách sản phẩm theo giá thấp nhất
                      _listSanPham.sort((a, b) => a.Gia.compareTo(b.Gia));
                    });
                  },
                  child: const Text(
                    "Thấp nhất",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
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
            ),
          )
        ],
      ),
    );
  }
}

enum SortType {
  All,
  Highest,
  Lowest,
}
