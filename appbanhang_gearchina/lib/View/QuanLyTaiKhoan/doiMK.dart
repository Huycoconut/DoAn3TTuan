import 'package:appbanhang_gearchina/View/DangNhap_DangKy/login.dart';
import 'package:appbanhang_gearchina/View/QuanLyTaiKhoan/account_st.dart';
import 'package:appbanhang_gearchina/View/Trang_chu/botNav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoiMK extends StatefulWidget {
  const DoiMK({super.key});

  @override
  State<DoiMK> createState() => _DoiMKState();
}

class _DoiMKState extends State<DoiMK> {
  TextEditingController mkcu = TextEditingController();
  TextEditingController mkmoi = TextEditingController();
  TextEditingController conf_mk = TextEditingController();

  String _errorMessage = '';
  Future<void> _doiMK() async{
    String Password = mkcu.text;
    String newPassword = mkmoi.text;
    String confirmPassword = conf_mk.text;
    try{
      if(Password == newPassword){
      setState(() {
        _errorMessage = "Mật khẩu cũ trùng với mật khẩu mới";
      });
      showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text(_errorMessage),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: Text("Quay lại"))
            ],
          );
        });
      return;
      }
      if(newPassword != confirmPassword){
      setState(() {
        _errorMessage = "Mật khẩu mới và xác nhận mật khẩu không khớp";
      });
      showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text(_errorMessage),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: Text("Quay lại"))
            ],
          );
        });
        return;
      }
      User? user = FirebaseAuth.instance.currentUser;
      await user?.updatePassword(newPassword);
      setState(() {
          _errorMessage = 'Đổi mật khẩu thành công.';
        });
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text(_errorMessage),
            actions: [
              TextButton(onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
              }, child: Text("Quay lại trang đăng nhập"))
            ],
          );}
        );
    }
    catch (e){}
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
                "Đổi Mật Khẩu",
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Mật khẩu cũ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                        )),
                      controller: mkcu,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),

                  TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Mật khẩu mới",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                        )),
                        controller: mkmoi,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),

                  TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Xác nhận mật khẩu",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                        )),
                        controller: conf_mk,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  ElevatedButton(
                    onPressed: () {
                      _doiMK();
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
                      'Đổi',
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