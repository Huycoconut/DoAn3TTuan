import 'package:appbanhang_gearchina/View/GioHang/class_LuuTruSp_TrongGio.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/SpThanhToan.dart';
import 'package:appbanhang_gearchina/View/GioHang/SpTrongGio.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/SuaDiaChi_Screen.dart';
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
      cartItems = cart.cartItems;
      cartItems = GioHang.HienSpTrongGio();
    });
  }
// Xóa danh sách sản phẩm khi thoát khỏi màn hình sau khi quay về 
  @override
  void dispose() {
    cartItems.clear();
    super.dispose();
  }
//load sản phẩm trong lên màn hình
/*   void _loadCartItems() {
    setState(() {
      cartItems = GioHang.HienSpTrongGio();
    });
  } */

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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

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
          Container(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                const Text(
                  "Vũ Hoàng Huy | 0335343714",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                ),
                const Text(
                  "128/25 Nguyễn Lâm, phường 3, Bình Thạnh, HCM",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
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
                                const Text("Màu: xanh"),
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
            height: 20,
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
            onPressed: () {},
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
