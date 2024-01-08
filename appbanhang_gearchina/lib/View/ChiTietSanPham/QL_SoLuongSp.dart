import 'package:flutter/material.dart';

class QL_SoLuongSp extends StatefulWidget {
  const QL_SoLuongSp({super.key});

  @override
  State<QL_SoLuongSp> createState() => _QL_SoLuongSpState();
}

class _QL_SoLuongSpState extends State<QL_SoLuongSp> {
  final bool _isPress = false;
  var _soLuong = 0;
  var _tongTien = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          "Macbook Air M1",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          children: [
            Container(
              height: 35,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (_soLuong <= 0) {
                            _soLuong = 0;
                          } else {
                            _soLuong--;
                          }
                          _tongTien = _tongTien - 1400000;
                          if (_tongTien <= 0) {
                            _tongTien = 0;
                          }
                        });
                      },
                      icon: const Icon(Icons.remove_circle_outline)),
                  Text('$_soLuong'),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _soLuong++;
                      });
                      _tongTien = _tongTien + 1400000;
                    },
                    icon: const Icon(Icons.add_circle_outline,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            const Text(
              "Số lượng",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
            )
          ],
        ),
      ],
    );
  }
}
