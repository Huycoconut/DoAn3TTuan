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
        margin: const EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    // back ve trang chu
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              const Text(
                "Quản Lý Tài Khoản",
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
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
              const Text(
                "Tên Tài Khoản",
                style: TextStyle(fontSize: 20.0),
              ),
              const TextField(
                enabled: false,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle),
                    hintText: "Tên đăng nhập",
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
              const TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Họ Tên",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                    )),
              ),
              //khung dk_email
              const Text(
                "Email",
                style: TextStyle(fontSize: 20.0),
              ),
              const TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email",
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
              const TextField(
                decoration: InputDecoration(
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
                style: TextStyle(fontSize: 20.0),
              ),
              const TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    hintText: "Địa chỉ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(56, 60, 160, 20)),
                    )),
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),

              //dangxuat
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const LogoutDialog();
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
          onPressed: () {
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
