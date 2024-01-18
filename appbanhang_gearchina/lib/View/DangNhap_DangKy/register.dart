import 'package:appbanhang_gearchina/View/DangNhap_DangKy/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:appbanhang_gearchina/View/DangNhap_DangKy/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController matkhau = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController re_pass = TextEditingController();
  TextEditingController hoten = TextEditingController();
  TextEditingController sdt = TextEditingController();
  TextEditingController diachi = TextEditingController();
  String _errorMessage = '';

  //them user
  Future<void> newUser() async {
    String? userId;
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser?.uid;
    }
    final dbref = FirebaseDatabase.instance.ref().child('TaiKhoan');
    DatabaseReference newUser_ = dbref.push();

    newUser_.set({
      'userID': userId,
      'email': email.text,
      'Password': matkhau.text,
      'DiaChi': diachi.text,
      'SĐT': sdt.text,
      'Hoten': hoten.text,
    });
  }

  // kiem tra ki tu dac biet
  bool kiemtra(String input) {
    RegExp specialCharRegex = RegExp(r'[!@#%^&*(),.?":{}|<>]');
    return specialCharRegex.hasMatch(input);
  }

  Future<void> SignUp() async {
    try {
      // kiem tra mat khau co ki tu dac biet hay ko
      if (kiemtra(matkhau.text) == false) {
        setState(() {
          _errorMessage = 'Mật khẩu chứa ít nhất 1 kí tự đặc biệt';
        });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(_errorMessage),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Quay lại"))
                ],
              );
            });
        return;
      }

      // kiem tra pass < 6 ki tu
      if (matkhau.text.length < 6) {
        setState(() {
          _errorMessage = 'Mật khẩu chứa ít nhất 6 kí tự';
        });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(_errorMessage),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Quay lại"))
                ],
              );
            });
        return;
      }

      // kiem tra pass va repass
      if (matkhau.text != re_pass.text) {
        setState(() {
          _errorMessage = 'Mật khẩu và Repassword không giống nhau.';
        });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(_errorMessage),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Quay lại"))
                ],
              );
            });
        // dung lai neu pass != repass
        return;
      }

      User? user = await FirebaseAuthService()
          .signUpWithEmailAndPassword(email.text, matkhau.text);
      if (user != null) {
        setState(() {
          _errorMessage = 'Đăng ký thành công.';
        });
        newUser();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(_errorMessage),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: const Text("Quay lại trang đăng nhập"))
                ],
              );
            });
      } else {
        setState(() {
          _errorMessage = 'Email đã tồn tại';
        });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(_errorMessage),
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
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30),
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
                  icon: const Icon(Icons.arrow_back_ios)),
              const Text(
                "Đăng Ký Tài Khoản",
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              //khung dk_email
              const Text(
                "Email",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                    )),
                controller: email,
              ),
              //khung dk_matkhau
              const Text(
                "Mật Khẩu",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Mật Khẩu",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                    )),
                controller: matkhau,
              ),

              //khung dk_nhaplaimatkhau
              const Text(
                "Nhập Lại Mật Khẩu",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Nhập Lại Mật Khẩu",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                    )),
                controller: re_pass,
              ),
              //khung dk_hoten
              const Text(
                "Họ Tên",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Họ Tên",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                    )),
                controller: hoten,
              ),
              //khung dk_sdt
              const Text(
                "Số Điện Thoại",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: "Số Điện Thoại",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                    )),
                controller: sdt,
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              const Text(
                "Địa chỉ",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    hintText: "Địa chỉ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                    )),
                controller: diachi,
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              //btn dangky
              ElevatedButton(
                onPressed: () {
                  // Xử lý sự kiện khi nút được nhấn
                  SignUp();
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
                  'Đăng Ký',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
