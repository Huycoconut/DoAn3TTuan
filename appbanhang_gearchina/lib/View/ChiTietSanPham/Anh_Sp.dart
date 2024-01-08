import 'package:flutter/material.dart';

class Anh_Sp extends StatefulWidget {
  const Anh_Sp({super.key});

  @override
  State<Anh_Sp> createState() => _Anh_SpState();
}

class _Anh_SpState extends State<Anh_Sp> {
  @override
  Widget build(BuildContext context) {
        var media = MediaQuery.of(context).size;

    return   Expanded(
              flex: 1,
              child: Image.asset(
                "assets/h4.jpg",
                fit: BoxFit.cover,
                width: media.width / 1,
                height: media.height / 2,
              ),
            );
  }
}