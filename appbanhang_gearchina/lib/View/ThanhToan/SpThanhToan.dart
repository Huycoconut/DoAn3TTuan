import 'package:appbanhang_gearchina/View/GioHang/class_LuuTruSp_TrongGio.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/SuaDiaChi_Screen.dart';
import 'package:appbanhang_gearchina/View/Trang_chu/botNav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class SpThanhToan extends StatefulWidget {
  SpThanhToan({super.key, required this.payItems});
  List<SanPham> payItems;
  @override
  State<SpThanhToan> createState() => _SpThanhToanState();
}

class _SpThanhToanState extends State<SpThanhToan> {
  // ignore: non_constant_identifier_names
  double _TongTien = 0;
  bool _isPress = true;

  List<SanPham> cartItems = [];
  @override
  void initState() {
    // TODO: implement initState
    //  _tingTongThanhToan();
  }

  void _createHoaDon() {
    User? user = FirebaseAuth.instance.currentUser;
    String userID = user!.uid;
    DatabaseReference cartRef =
        FirebaseDatabase.instance.ref().child('GioHang');
    DatabaseReference hoaDonRef =
        FirebaseDatabase.instance.ref().child('HoaDon');

    // Tạo một hóa đơn mới
    DatabaseReference newHoaDonRef = hoaDonRef.push();
    newHoaDonRef.set({
      'UserID': userID,
      'TongTien': _TongTien,
    }).then((_) {
      String? maHD = newHoaDonRef.key;
      //Duyệt các sản phẩm được đặt
      for (var sanPham in widget.payItems) {
        DatabaseReference chiTietHDRef =
            FirebaseDatabase.instance.ref('ChiTietHD');
        //Thêm thông tin các sản phẩm được đặt vào ChiTietHD
        DatabaseReference newChiTietHD = chiTietHDRef.push();
        newChiTietHD.set({
          'MaHD': maHD,
          'TenSanPham': sanPham.Ten,
          'GiaSanPham': sanPham.Gia,
          'SoLuong': sanPham.SoLuong,
          'TrangThai': sanPham.TrangThai
        });
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thành công'),
            content: const Text('Đơn hàng đã được tạo thành công.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Đóng'),
                onPressed: () {
                  Navigator.push(
                    context,
                    //Chuyển qua màn hình quản lý đơn hàng
                    MaterialPageRoute(builder: (context) => const bottomNav()),
                  );
                },
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Đặt hàng thành thất bại'),
          content: const Text('Vui lòng thử lại!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  void _tingTongThanhToan() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final gioHangRef = FirebaseDatabase.instance.reference().child("GioHang");

    gioHangRef.orderByChild("userID").equalTo(userId).onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final tongThanhToan = data.values
            .where((item) => item["sanPham"]["TrangThai"] == 1)
            .map<double>((item) {
          final soLuong = item["sanPham"]["SoLuong"];
          final gia = item["sanPham"]["Gia"];
          return soLuong * gia;
        }).reduce((value, element) => value + element);

        setState(() {
          _TongTien = tongThanhToan;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double totalPrice = 0;

    String? userId;
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser?.uid;
    }
    final ref = FirebaseDatabase.instance.ref("GioHang");
    final refTK = FirebaseDatabase.instance.ref("/TaiKhoan");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 22,
              ),
              const Text(
                "Địa chỉ nhận hàng",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(
                width: 100,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const suaDiaChi_Screen()));
                },
                child: const Text(
                  "Sửa",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: refTK,
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.child('userID').value.toString() == userId) {
                    return Container(
                      padding: const EdgeInsets.only(left: 23),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.child('Hoten').value.toString()} || ${snapshot.child('SĐT').value.toString()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 12),
                          ),
                          Text(
                            snapshot.child('DiaChi').value.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 20),
            // margin: const EdgeInsets.only(left: 20),
            child: const Text(
              "Sản phẩm",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.child('sanPham').exists &&
                      snapshot.child('sanPham').child('Gia').exists &&
                      snapshot.child('sanPham').child('SoLuong').exists) {
                    int price =
                        snapshot.child('sanPham').child('Gia').value as int;
                    int quantity =
                        snapshot.child('sanPham').child('SoLuong').value as int;
                    totalPrice += price * quantity;
                  }
                  if (snapshot.child('userID').value.toString() == userId &&
                      snapshot.child('sanPham').child('Mau').value.toString() ==
                          '1') {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Image.network(
                                  snapshot
                                      .child('sanPham')
                                      .child('Hinh')
                                      .value
                                      .toString(),
                                  width: media.width / 4.23,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot
                                      .child('sanPham')
                                      .child('Ten')
                                      .value
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Màu: ${snapshot.child('sanPham').child('MauSac').child('TenMau').child('TrangThai').value.toString() == '0' ? "Xám" : snapshot.child('sanPham').child('MauSac').child('TenMau').child('TrangThai').value.toString() == '1' ? "Đen" : "Trắng"}",
                                ),
                                Row(
                                  children: [
                                    Text(
                                      snapshot
                                          .child('sanPham')
                                          .child('Gia')
                                          .value
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent),
                                    ),
                                    const SizedBox(
                                      width: 150,
                                    ),
                                    Text(
                                        "x${snapshot.child('sanPham').child('SoLuong').value.toString()}"),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 20),
            child: const Text(
              "Phương thưc thanh toán",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPress = !_isPress;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.payments_outlined,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text("Thanh toán khi nhận hàng"),
                        const SizedBox(
                          width: 70,
                        ),
                        Icon(
                          _isPress == true ? Icons.check_circle : null,
                          color: Colors.red,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.payment,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Thanh toán qua ngân hàng"),
                        SizedBox(
                          width: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tổng thanh toán',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                Text(
                  '₫$totalPrice',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.redAccent),
                ),
              ],
            ),
          ),
          Text('$_TongTien'),
          Text("$totalPrice"),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                    left: 100, right: 100, top: 10, bottom: 10),
                backgroundColor: const Color.fromRGBO(56, 60, 160, 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              _createHoaDon();
              // _xoaSpSauKhiDat();
            },
            child: const Text(
              "Đặt hàng",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
