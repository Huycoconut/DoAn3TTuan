import 'package:appbanhang_gearchina/View/QuanLyTaiKhoan/account_st.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class suaDiaChi_Screen extends StatefulWidget {
  const suaDiaChi_Screen({super.key});

  @override
  State<suaDiaChi_Screen> createState() => _suaDiaChi_ScreenState();
}

class _suaDiaChi_ScreenState extends State<suaDiaChi_Screen> {
  final hoTen = TextEditingController();
  final sDT = TextEditingController();
  final diaChi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? userId;
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser?.uid;
    }

    void updateData(final newSoLuong, final newSDT, final newDiaChi) async {
      DatabaseReference dbref = FirebaseDatabase.instance.ref('TaiKhoan');
      final DatabaseReference ref = dbref.child('$userId');
      await ref.update({
        'Hoten': newSoLuong,
        'SĐT': newSDT,
        'DiaChi': newDiaChi,
      });
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Sửa Địa chỉ",
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_rounded))),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Họ tên:",
              style: TextStyle(fontSize: 15),
            ),
            TextField(
              controller: hoTen,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Họ Tên",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                  )),
            ),

            //khung dk_sdt
            const Text(
              "Số Điện Thoại",
              style: TextStyle(fontSize: 15.0),
            ),
            TextField(
              controller: sDT,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: "Số Điện Thoại",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                  )),
            ),
            //khung dk_nhaplaimatkhau
            const Text(
              "Địa chỉ",
              style: TextStyle(fontSize: 15.0),
            ),
            TextField(
              controller: diaChi,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  hintText: "Địa chỉ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                  )),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  updateData(hoTen.text, sDT.text, diaChi.text);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Sửa địa chỉ thành công!"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Quay lại"))
                          ],
                        );
                      });
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(500, 60),
                backgroundColor: const Color.fromRGBO(56, 60, 160, 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'HOÀN THÀNH',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
