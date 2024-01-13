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
  TextEditingController taikhoan=TextEditingController();
  TextEditingController matkhau=TextEditingController();

  void login() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: taikhoan.text, password: matkhau.text);
          // sửa đường dẫn về trang chủ
      Navigator.push(context, MaterialPageRoute(builder: (context) => bottomNav()));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      wrongLogin(e.code);
    }
  }

  void wrongLogin(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text("Tài Khoản Hoặc Mật Khẩu Không Chính Xác"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Thoát",style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(56,60,160,20)),)
              ),
            ],
          );
        });
  }
  
  
  Future<UserCredential?> signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      Navigator.push(context, MaterialPageRoute(builder: (context) => bottomNav()));
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
    );  
    
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    catch(e){}
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 80, 30, 30),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Đăng Nhập",style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold ),),
            const Padding(padding: EdgeInsets.only(top:15)),

            Text("Tên Tài Khoản",style: TextStyle(fontSize: 20.0),),
            const Padding(padding: EdgeInsets.only(top:5)),
            //khung dn_taikhoan
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                hintText: "Tên đăng nhập",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(56,60,160,20)),  
                )
              ),
              controller: taikhoan,
            ),

            const Padding(padding: EdgeInsets.only(top:5)),
            Text("Mật Khẩu",style: TextStyle(fontSize: 20.0),),
            const Padding(padding: EdgeInsets.only(top:5)),
            //khung dn_matkhau
            TextField(
              obscureText: widget.an,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: "Mật Khẩu",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(56,60,160,20)),  
                ),
                // an/hien mat khau
                suffixIcon: IconButton(
                      onPressed: () {
                        if (widget.an == true) {
                          setState(() {
                            widget.an = false;
                            widget.color_iconbtn = Color.fromRGBO(56,60,160,20);
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
                      ))
              ),
              controller: matkhau,
              
            ),

            //quenmatkhau
            const Padding(padding: EdgeInsets.only(top:10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: Text("Quên mật khẩu?",style: TextStyle(fontSize: 16.0,color: Color.fromRGBO(56, 60, 160, 20)),))
              ],
            ),
            
            //btn dang nhap
            const Padding(padding: EdgeInsets.only(top:20)),
            ElevatedButton(
              onPressed: () {
                login();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(500, 60),
                primary: Color.fromRGBO(56,60,160,20),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Đăng Nhập',style: TextStyle(fontSize: 20.0,color: Colors.white),),
            ),
            //btn dang ky
            const Padding(padding: EdgeInsets.only(top:20)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(500, 60),
                primary: Color.fromRGBO(56,60,160,20),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Đăng Ký',style: TextStyle(fontSize: 20.0,color: Colors.white),),
            ),

            // txt đăng nhập khác
            const Padding(padding: EdgeInsets.only(top:30,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Đăng nhập khác",style: TextStyle(fontSize: 16.0,color: Colors.black),)
              ],
            ),

            const Padding(padding: EdgeInsets.only(top:30,)),
            ElevatedButton.icon(
              onPressed: () {
                signInWithGoogle();
              },
              icon: Icon(Icons.mail,color: Colors.white,),
              label: Text('Đăng nhập với Google',style: TextStyle(fontSize: 20.0,color: Colors.white),),
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(56,60,160,20),
                minimumSize: Size(500, 60),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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