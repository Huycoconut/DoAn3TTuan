

import 'package:appbanhang_gearchina/firebase_options.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Realtime Database Example'),
        ),
        body: const MyGridView(),
      ),
    );
  }
}

class MyGridView extends StatefulWidget {
  const MyGridView({super.key});

  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
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
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: _listSanPham.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(_listSanPham[index].Ten),
            subtitle: Text(_listSanPham[index].ThongSo),
          ),
        );
      },
    );
  }
}

class SanPham {
  final Ten;
  final Loai;
  final Mota;
  final Hinh;
  final SoLuong;
  final ThongSo;
  final TrangThai;
  final Id;
  final Mau;

  SanPham(
      {required this.Hinh,
      required this.Id,
      required this.Loai,
      required this.Mau,
      required this.Mota,
      required this.SoLuong,
      required this.Ten,
      required this.ThongSo,
      required this.TrangThai});

  factory SanPham.fromSnapshot(DataSnapshot snapshot) {
    return SanPham(
      Hinh: snapshot.child('Hinh').value,
      Id: snapshot.child('Id').value,
      Loai: snapshot.child('Loai').value,
      Mau: snapshot.child('Mau').value,
      Mota: snapshot.child('Mota').value,
      SoLuong: snapshot.child('SoLuong').value,
      Ten: snapshot.child('Ten').value,
      ThongSo: snapshot.child('ThongSo').value,
      TrangThai: snapshot.child('TrangThai').value,
    );
  }
}
