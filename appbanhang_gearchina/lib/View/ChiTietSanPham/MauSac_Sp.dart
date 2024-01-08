import 'package:flutter/material.dart';

class MauSac_Sp extends StatefulWidget {
  const MauSac_Sp({super.key});

  @override
  State<MauSac_Sp> createState() => _MauSac_SpState();
}

class _MauSac_SpState extends State<MauSac_Sp> {
    bool _isPress = false;
  var _soLuong = 0;
  var _tongTien = 0;
  @override
  Widget build(BuildContext context) {
    return  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 25, top: 15),
                        child: const Text(
                          "Màu sắc",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.circle,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.circle,
                              size: 40,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isPress = !_isPress;
                              });
                            },
                            icon: Icon(
                              Icons.circle,
                              size: 40,
                              color: _isPress
                                  ? Colors.orangeAccent
                                  : Colors.indigoAccent[400],
                            ),
                          )
                        ],
                      )
                    ],
                  );
  }
}