import 'package:appbanhang_gearchina/View/QuanLyTaiKhoan/doiMK.dart';
import 'package:appbanhang_gearchina/View/QuanLyTaiKhoan/doiTT.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:appbanhang_gearchina/View/DangNhap_DangKy/login.dart';
import 'package:appbanhang_gearchina/View/Trang_chu/botNav.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appbanhang_gearchina/View/HoaDon/HoaDon_Screen.dart';

class QuanLytaiKhoan extends StatefulWidget {
  const QuanLytaiKhoan({super.key});

  @override
  State<QuanLytaiKhoan> createState() => _QuanLytaiKhoanState();
}

class _QuanLytaiKhoanState extends State<QuanLytaiKhoan> {

  final dbref = FirebaseDatabase.instance.ref().child('TaiKhoan');
  @override
  Widget build(BuildContext context) {
    String? userId;
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser?.uid;
    }

    return Scaffold(
      body: Expanded(
        child: FirebaseAnimatedList(
          query: dbref,
          itemBuilder: (context, snapshot, animation, index) {
            if (snapshot.child('userID').value.toString() == userId){ 
              Map newtt = snapshot.value as Map;
              newtt['key'] = snapshot.key;
              return Container(
                margin: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start  ,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Quản Lý Tài Khoản",
                            style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: 100,
                          )
                        ],
                      ),
                      //khung dk_email
                      const Text(
                        "Email",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: snapshot.child('email').value.toString(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                            )),
                      ),
                      //khung dk_hoten
                      const Text(
                        "Họ Tên",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            enabled: false,
                            prefixIcon: Icon(Icons.person),
                            hintText: snapshot.child('Hoten').value.toString(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                            )),
                      ),
                      //khung dk_sdt
                      const Text(
                        "Số Điện Thoại",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            enabled: false,
                            prefixIcon: Icon(Icons.phone),
                            hintText: snapshot.child('SĐT').value.toString(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                            )),
                      ),
                      //khung dk_nhaplaimatkhau
                      const Text(
                        "Địa chỉ",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            enabled: false,
                            prefixIcon: Icon(Icons.location_on),
                            hintText: snapshot.child('DiaChi').value.toString(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                            )),
                      ),
                      Padding(padding: EdgeInsets.only(top: 30)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // đường dẫn đổi form mật khẩu
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => DoiMK()));
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size((MediaQuery.of(context).size.width) / 2.3, 60),
                              backgroundColor: const Color.fromRGBO(56, 60, 160, 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'Đổi Mật Khẩu',
                              style: TextStyle(fontSize: 20.0, color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              //xu ly chuc nang luu thong tin
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => DoiTT()));
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size((MediaQuery.of(context).size.width) / 2.3, 60),
                              backgroundColor: const Color.fromRGBO(56, 60, 160, 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'Đổi Thông Tin',
                              style: TextStyle(fontSize: 20.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      //quan ly don hang
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      ElevatedButton(
                        onPressed: () {
                          //Đường dẫn form quan lý đơn hàng
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
                          'Quản Lý Đơn Hàng',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      //dangxuat
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return LogoutDialog();
                            },
                          );
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
                          'Đăng Xuất',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            else{
              return  Container(
              );
            }
          })
      )
    );
  }
}

//popup thông báo
class LogoutDialog extends StatelessWidget {
  LogoutDialog({super.key});
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _SignOut(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Đăng Xuất",
        style: TextStyle(color: Color.fromRGBO(56, 60, 160, 20)),
      ),
      content: const Text("Bạn có chắc chắn muốn đăng xuất?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Thoát",
              style: TextStyle(
                  fontSize: 15.0, color: Color.fromRGBO(56, 60, 160, 20)),
            )),
        TextButton(
          onPressed: () async {
            await _SignOut(context);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Đăng xuất thành công"),
              ),
            );
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
          child: const Text(
            "Đăng xuất",
            style: TextStyle(
                fontSize: 15.0, color: Color.fromRGBO(56, 60, 160, 20)),
          ),
        ),
      ],
    );
  }
}
