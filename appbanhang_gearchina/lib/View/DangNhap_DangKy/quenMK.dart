import 'package:appbanhang_gearchina/View/DangNhap_DangKy/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuenMK extends StatefulWidget {
  const QuenMK({super.key});

  @override
  State<QuenMK> createState() => _QuenMKState();
}

class _QuenMKState extends State<QuenMK> {
  TextEditingController email = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  //quen mk
  Future guima() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Link reset mật khẩu đã được gửi vui lòng kiểm tra email"),
        ),
      );
    }
    on FirebaseAuthException catch (e)
    {
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text("Gửi thất bại vui lòng kiểm tra email"),
          actions: [
            TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Quay lại"))
          ],
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(30, 80, 30, 30),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  icon: Icon(Icons.arrow_back_ios)
              ),
              Text(
                "Quên Mật Khẩu",
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              //Khung nhập email và nút reset pass
              Column(
                children: [
                  Text("Nhập vào email cần lấy lại mật khẩu",style: TextStyle(fontSize: 20.0,color: Color.fromRGBO(56, 60, 160, 20)),),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                        )),
                     controller: email,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  ElevatedButton(
                    onPressed: () {
                      guima();
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
                      'Gửi mã',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}