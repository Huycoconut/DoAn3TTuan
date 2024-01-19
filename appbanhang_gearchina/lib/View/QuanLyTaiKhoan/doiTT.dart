import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:appbanhang_gearchina/View/Trang_chu/botNav.dart';

class DoiTT extends StatefulWidget {
  const DoiTT({super.key});
  @override
  State<DoiTT> createState() => _DoiTTState();
}

class _DoiTTState extends State<DoiTT> {
  TextEditingController hotenmoi = TextEditingController();
  TextEditingController sdtmoi = TextEditingController();
  TextEditingController diachimoi = TextEditingController();
  @override
  Future<void> updateUser() async {
    String? userId;
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser?.uid;
    }
    final dbref = FirebaseDatabase.instance.ref().child('TaiKhoan');
    DatabaseReference updateUser_ = dbref.child("$userId");

    updateUser_.update({
      'DiaChi': diachimoi.text,
      'SĐT': sdtmoi.text,
      'Hoten': hotenmoi.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(30, 80, 30, 30),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Đổi Thông Tin",
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Họ tên",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(56, 60, 160, 20)),
                        )),
                    controller: hotenmoi,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: "Số Điện Thoại",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(56, 60, 160, 20)),
                        )),
                    controller: sdtmoi,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        hintText: "Địa chỉ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(56, 60, 160, 20)),
                        )),
                    controller: diachimoi,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  ElevatedButton(
                    onPressed: () {
                      updateUser();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Chỉnh sửa thông tin thành công"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => bottomNav()));
                                    },
                                    child: Text("Quay lại"))
                              ],
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(500, 60),
                      backgroundColor: const Color.fromRGBO(56, 60, 160, 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Lưu',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
