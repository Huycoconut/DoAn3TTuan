import 'package:appbanhang_gearchina/View/GioHang/class_LuuTruSp_TrongGio.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/SpThanhToan.dart';
import 'package:appbanhang_gearchina/View/GioHang/SpTrongGio.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/SuaDiaChi_Screen.dart';
import 'package:appbanhang_gearchina/View/ThongBao/local_notification.dart';
import 'package:appbanhang_gearchina/View/Trang_chu/botNav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class thanhToan_Screen extends StatefulWidget {
  const thanhToan_Screen({super.key, required this.payItems});
  final List<SanPham> payItems;

  @override
  State<thanhToan_Screen> createState() => _thanhToan_ScreenState();
}

class _thanhToan_ScreenState extends State<thanhToan_Screen> {
  //tạo danh sách
  List<SanPham> cartItems = [];
  //Check thanh toán
  bool _isPress = true;
  //Giá tiền
  double _TongTien = 0;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
    _tinhTongTien();
  }

  //Load sản phẩm
  void _loadCartItems() {
    Cart cart = Cart();
    setState(() {
      cartItems = Cartlocal.cartItems;
      cartItems = GioHang_CRUD.HienSpTrongGio();
    });
  }

// Xóa danh sách sản phẩm khi thoát khỏi màn hình sau khi quay về
  @override
  void dispose() {
    cartItems.clear();
    super.dispose();
  }

//Tính tổng tiền
  void _tinhTongTien() {
    double TongTien = 0;
    for (var sanPham in widget.payItems) {
      TongTien +=
          sanPham.SoLuong == 1 ? sanPham.Gia : sanPham.Gia * sanPham.SoLuong;
    }
    setState(() {
      _TongTien = TongTien;
    });
  }

  //
  //Tạo hóa đơn
  void _createHoaDon() {
    User? user = FirebaseAuth.instance.currentUser;
    String userID = user!.uid;
    DatabaseReference cartRef =
        FirebaseDatabase.instance.ref().child('GioHang');
    DatabaseReference hoaDonRef =
        FirebaseDatabase.instance.ref().child('HoaDon');

    // Tạo một hóa đơn mới
    DatabaseReference newHoaDonRef = hoaDonRef.push();
    String? maHD = newHoaDonRef.key;
    newHoaDonRef.set({
      'userID': userID,
      'TongTien': _TongTien,
      'MaHD': maHD,
      'TrangThai': 1
    }).then((_) {
      //Duyệt các sản phẩm được đặt
      for (var sanPham in widget.payItems) {
        DatabaseReference chiTietHDRef =
            FirebaseDatabase.instance.ref('ChiTietHD');
        //Thêm thông tin các sản phẩm được đặt vào ChiTietHD
        DatabaseReference newChiTietHD = chiTietHDRef.push();
        newChiTietHD.set({
          'MaHD': maHD,
          'TenSanPham': sanPham.Ten,
          'DonGia': sanPham.Gia,
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
  //
  //Xóa sản phẩm trong giỏ sau khi đặt thành công

  void _xoaSpSauKhiDat() {
    Cart cart = Cart();
    List<SanPham> payItems = widget.payItems;

    // Lọc ra những sản phẩm đã được đặt thành công
    List<SanPham> datThanhCong =
        Cartlocal.cartItems.where((item) => payItems.contains(item)).toList();

    // Xóa những sản phẩm đã được đặt thành công
    for (var item in datThanhCong) {
      cart.cartItems.remove(item);
    }
  }
  //

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    String? userId;
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser?.uid;
    }
    final ref = FirebaseDatabase.instance.ref("/TaiKhoan");

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 22,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                ),
              ),
              const SizedBox(
                width: 90,
              ),
              const Text(
                "Thanh toán",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.child('userID').value.toString() == userId) {
                    return Container(
                      padding: const EdgeInsets.only(left: 23),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Địa chỉ nhận hàng",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const suaDiaChi_Screen()));
                                },
                                child: const Text(
                                  "Sửa",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${snapshot.child('Hoten').value.toString()}||${snapshot.child('SĐT').value.toString()}",
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
          Expanded(
            child: ListView.builder(
              itemCount: widget.payItems.length,
              itemBuilder: (context, index) {
                final sanPham = widget.payItems[index];
                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Image.network(
                                  sanPham.Hinh,
                                  width: media.width / 3.5,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  sanPham.Ten,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    "Màu:${sanPham.MauSac == 0 ? "Xám" : sanPham.MauSac == 1 ? "Đen" : "Bạc"}  "),
                                Row(
                                  children: [
                                    Text(
                                      "₫${sanPham.SoLuong == 1 ? sanPham.Gia : sanPham.Gia + sanPham.Gia}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent),
                                    ),
                                    const SizedBox(
                                      width: 150,
                                    ),
                                    Text("x${sanPham.SoLuong}")
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 200,
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
                  '₫$_TongTien',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.redAccent),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                    left: 100, right: 100, top: 10, bottom: 10),
                backgroundColor: const Color.fromRGBO(56, 60, 160, 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              _createHoaDon();
              _xoaSpSauKhiDat();
              LocalNotifications.showSimpleNotification(
                  title: "Đặt hàng thành công",
                  body: "Giá trị đơn hàng ${_TongTien}",
                  payload: "");
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
