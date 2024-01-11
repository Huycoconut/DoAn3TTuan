import 'package:flutter/material.dart';
import 'package:appbanhang_gearchina/View/DangNhap_DangKy/login.dart';

class QuanLytaiKhoan extends StatefulWidget {
  const QuanLytaiKhoan({super.key});

  @override
  State<QuanLytaiKhoan> createState() => _QuanLytaiKhoanState();
}

class _QuanLytaiKhoanState extends State<QuanLytaiKhoan> {
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
              // back ve trang chu
            }, icon: Icon(Icons.arrow_back_ios)),
            Text("Quản Lý Tài Khoản",style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_circle,size: 100,)
              ],
            ),
            Text("Tên Tài Khoản",style: TextStyle(fontSize: 20.0),),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                hintText: "Tên đăng nhập",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(56,60,160,20)),  
                )
              ),
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
            ),
            //khung dk_nhaplaimatkhau
            Text("Địa chỉ",style: TextStyle(fontSize: 20.0),),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on),
                hintText: "Địa chỉ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(56,60,160,20)),  
                )
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
                minimumSize: Size(500, 60),
                primary: Color.fromRGBO(56,60,160,20),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Đăng Xuất',style: TextStyle(fontSize: 20.0,color: Colors.white),),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

//popup thông báo
class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Đăng Xuất",style: TextStyle(color: Color.fromRGBO(56,60,160,20)),),
      content: Text("Bạn có chắc chắn muốn đăng xuất?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Thoát",style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(56,60,160,20)),)
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Đăng xuất thành công"),
              ),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
          },
          child: Text("Đăng xuất",style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(56,60,160,20)),),
        ),
      ],
      
    );
  }
}