import 'package:flutter/material.dart';
import 'package:appbanhang_gearchina/View/DangNhap_DangKy/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController tentaikhoan=TextEditingController();
  TextEditingController matkhau=TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController re_pass=TextEditingController();
  TextEditingController hoten=TextEditingController();
  TextEditingController sdt=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            }, icon: Icon(Icons.arrow_back_ios)),
            Text("Đăng Ký Tài Khoản",style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold ),),
            const Padding(padding: EdgeInsets.only(top:10)),
            //khung dk_taikhoan
            Text("Tên Tài Khoản",style: TextStyle(fontSize: 20.0),),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                hintText: "Tên đăng nhập",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(56,60,160,20)),  
                )
              ),
              controller: tentaikhoan,
            ),
            //khung dk_matkhau
            Text("Mật Khẩu",style: TextStyle(fontSize: 20.0),),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: "Mật Khẩu",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(56,60,160,20)),  
                )
              ),
              controller: matkhau,
            ),
            //khung dk_email
            Text("Email",style: TextStyle(fontSize: 20.0),),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(56,60,160,20)),  
                )
              ),
              controller: email,
            ),
            //khung dk_nhaplaimatkhau
            Text("Nhập Lại Mật Khẩu",style: TextStyle(fontSize: 20.0),),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: "Nhập Lại Mật Khẩu",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(56,60,160,20)),  
                )
              ),
              controller: re_pass,
            ),
            //khung dk_hoten
            Text("Họ Tên",style: TextStyle(fontSize: 20.0),),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Họ Tên",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(56,60,160,20)),  
                )
              ),
              controller: hoten,
            ),
            //khung dk_sdt
            Text("Số Điện Thoại",style: TextStyle(fontSize: 20.0),),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                hintText: "Số Điện Thoại",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(56,60,160,20)),  
                )
              ),
              controller: sdt,
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),

            //btn dangky
            ElevatedButton(
              onPressed: () {
                // Xử lý sự kiện khi nút được nhấn
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
          ],
        ),
        ),
      ),
    );
  }
}