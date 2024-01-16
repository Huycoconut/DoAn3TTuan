import 'package:appbanhang_gearchina/View/DangNhap_DangKy/firebase_auth.dart';
import 'package:appbanhang_gearchina/View/DangNhap_DangKy/quenMK.dart';
import 'package:appbanhang_gearchina/View/Trang_chu/Home.dart';
import 'package:appbanhang_gearchina/View/Trang_chu/botNav.dart';
import 'package:flutter/material.dart';
import 'package:appbanhang_gearchina/View/QuanLyTaiKhoan/account_st.dart';
import 'package:appbanhang_gearchina/View/DangNhap_DangKy/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  Login({super.key});
  bool an = true;
  Color color_iconbtn = Colors.black;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController taikhoan = TextEditingController();
  TextEditingController matkhau = TextEditingController();

  //dang nhap email & pass
  String _errorMessage = '';
  Future<void> SignIn() async {
    try {
      User? user = await FirebaseAuthService()
          .signInWithEmailAndPassword(taikhoan.text, matkhau.text);
      if (user != null) {
        setState(() {
          _errorMessage = 'Đăng nhập thành công.';
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const bottomNav()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'Đăng nhập thất bại. Vui lòng thử lại.';
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

  //dang nhap voi google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const bottomNav()));
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {}
    return null;
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
              const Text(
                "Đăng Nhập",
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
              ),
              const Padding(padding: EdgeInsets.only(top: 15)),

              const Text(
                "Email",
                style: TextStyle(fontSize: 20.0),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              //khung dn_taikhoan
              TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_circle),
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                    )),
                controller: taikhoan,
              ),

              const Padding(padding: EdgeInsets.only(top: 5)),
              const Text(
                "Mật Khẩu",
                style: TextStyle(fontSize: 20.0),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              //khung dn_matkhau
              TextField(
                obscureText: widget.an,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: "Mật Khẩu",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                    ),
                    // an/hien mat khau
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (widget.an == true) {
                            setState(() {
                              widget.an = false;
                              widget.color_iconbtn =
                                  const Color.fromRGBO(56, 60, 160, 20);
                            });
                          } else {
                            setState(() {
                              widget.an = true;
                              widget.color_iconbtn = Colors.black;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.remove_red_eye_sharp,
                          color: widget.color_iconbtn,
                        ))),
                controller: matkhau,
              ),

              //quenmatkhau
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {return QuenMK();}));
                      },
                      child: const Text(
                        "Quên mật khẩu?",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromRGBO(56, 60, 160, 20)),
                      ))
                ],
              ),

              //btn dang nhap
              const Padding(padding: EdgeInsets.only(top: 20)),
              ElevatedButton(
                onPressed: () {
                  SignIn();
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
                  'Đăng Nhập',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              //btn dang ky
              const Padding(padding: EdgeInsets.only(top: 20)),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Register()));
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

              // txt đăng nhập khác
              const Padding(
                  padding: EdgeInsets.only(
                top: 30,
              )),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Đăng nhập khác",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  )
                ],
              ),

              const Padding(
                  padding: EdgeInsets.only(
                top: 30,
              )),
              ElevatedButton.icon(
                onPressed: () {
                  signInWithGoogle();
                },
                icon: const Icon(
                  Icons.mail,
                  color: Colors.white,
                ),
                label: const Text(
                  'Đăng nhập với Google',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(56, 60, 160, 20),
                  minimumSize: const Size(500, 60),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
