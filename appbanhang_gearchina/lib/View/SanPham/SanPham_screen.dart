import 'package:appbanhang_gearchina/View/SanPham/load_SanPham.dart';
import 'package:flutter/material.dart';

class sanPham_screen extends StatefulWidget {
  const sanPham_screen({super.key});

  @override
  State<sanPham_screen> createState() => _sanPham_screenState();
}

class _sanPham_screenState extends State<sanPham_screen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios_rounded),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black45,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.search),
                  const Text(
                    "Laptop...",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.display_settings_sharp),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {},
                child: const Text(
                  "Tất cả",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              OutlinedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {},
                child: const Text(
                  "Cao nhất",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              OutlinedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {},
                child: const Text(
                  "Thấp nhất",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        const Expanded(
          child: Load_SanPham(),
        )
      ],
    );
  }
}
