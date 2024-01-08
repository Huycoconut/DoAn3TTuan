import 'package:flutter/material.dart';

class SpTrongGio extends StatefulWidget {
  const SpTrongGio({super.key});

  @override
  State<SpTrongGio> createState() => _SpTrongGioState();
}

class _SpTrongGioState extends State<SpTrongGio> {
  final bool _isPress = false;
  var _soLuong = 0;
  var _tongTien = 0;
  bool check = false;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Checkbox(
                value: check,
                onChanged: (bool? check) => setState(() {
                  this.check = check!;
                }),
              ),
              Image.asset(
                "assets/h2.jpg",
                fit: BoxFit.contain,
                width: media.width / 4.5,
                height: media.height / 7,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  //padding: const EdgeInsets.only(right: 85),
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "MacBook Air M1",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              "Màu sắc: ",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.only(right: 45),
                              child: const Text(
                                "Bạc",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      ),
                      Row(
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
                                    icon: const Icon(
                                        Icons.remove_circle_outline)),
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
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '$_tongTien',
                            softWrap: true,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
