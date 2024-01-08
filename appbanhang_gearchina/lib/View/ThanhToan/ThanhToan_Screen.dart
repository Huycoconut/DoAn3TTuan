import 'package:appbanhang_gearchina/View/ThanhToan/SpThanhToan.dart';
import 'package:appbanhang_gearchina/View/GioHang/SpTrongGio.dart';
import 'package:flutter/material.dart';

class thanhToan_Screen extends StatefulWidget {
  const thanhToan_Screen({super.key});

  @override
  State<thanhToan_Screen> createState() => _thanhToan_ScreenState();
}

class _thanhToan_ScreenState extends State<thanhToan_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                  onPressed: () {},
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      TextButton(
                        onPressed: () {},
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
            Container(
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    SpThanhToan(),
                    SizedBox(height: 5),
                    SpThanhToan(),
                    SizedBox(height: 5),
                    SpThanhToan(),
                    SizedBox(height: 5),
                    SpThanhToan(),
                    SizedBox(height: 5),
                    SpThanhToan(),
                    SizedBox(height: 5),
                    SpThanhToan(),
                    SizedBox(height: 5),
                  ],
                ),
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
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.payments_outlined,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Thanh toán khi nhận hàng"),
                          SizedBox(
                            width: 70,
                          ),
                          Icon(
                            Icons.check_circle,
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
                          Text("Thanh toán qua thẻ ngân hàng"),
                          SizedBox(
                            width: 40,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.red,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 20, top: 15),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng thanh toán',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  Text(
                    '14.000.000',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
      ),
    );
  }
}
