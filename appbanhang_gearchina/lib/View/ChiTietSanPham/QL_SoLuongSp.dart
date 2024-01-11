import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _sanPhamRef = FirebaseDatabase.instance.ref('SanPham');

  List<SanPham> _listSanPham = [];

  @override
  void initState() {
    super.initState();

    _sanPhamRef.onValue.listen((event) {
      setState(() {
        _listSanPham = event.snapshot.children.map((snapshot) {
          return SanPham.fromSnapshot(snapshot);
        }).toList();
      });
    });
  }

  void _updateData(SanPham sanPham) async {
    final DatabaseReference ref = _sanPhamRef.child(sanPham.Id.toString());
    await ref.update({
      'SoLuong': sanPham.SoLuong,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realtime Database Demo'),
      ),
      body: ListView(
        children: _listSanPham.map((sanPham) {
          return ListTile(
            title: Text(sanPham.Ten),
            subtitle: Text(sanPham.Gia.toString()),
            trailing: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    sanPham.SoLuong++;
                    _updateData(sanPham);
                  },
                ),
                Text(sanPham.SoLuong.toString()),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (sanPham.SoLuong > 0) {
                      sanPham.SoLuong--;
                      _updateData(sanPham);
                    }
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
