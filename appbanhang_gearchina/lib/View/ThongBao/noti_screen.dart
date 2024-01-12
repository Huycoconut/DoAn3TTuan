import 'package:appbanhang_gearchina/View/ThongBao/order.dart';
import 'package:appbanhang_gearchina/View/ThongBao/promotion.dart';
import 'package:flutter/material.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({super.key});

  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Card(
              color: const Color.fromRGBO(56, 60, 160, 20),
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Khuyến mãi",
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                child: const Expanded(child: Promotion())),
            const Divider(),
            const Row(
              children: [
                Text(
                  "Trạng thái đơn hàng",
                ),
              ],
            ),
            const Expanded(
              child: Order(),
            )
          ],
        ),
      ),
    );
  }
}
