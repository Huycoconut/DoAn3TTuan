import 'package:appbanhang_gearchina/View/HoaDon/loadHoaDon.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class load_HoaDon extends StatefulWidget {
  const load_HoaDon({Key? key}) : super(key: key);


  
  @override
  State<load_HoaDon> createState() => _load_HoaDonState();
}

class _load_HoaDonState extends State<load_HoaDon> {
  final dbref = FirebaseDatabase.instance.ref().child('ChiTietHD');
  String Status = "" ;

  List<DStenHoaDon> _listHD = [];

  @override
  void initState() {
    // TODO: implement initState
    dbref.onValue.listen((event) {
      if(this.mounted){
        setState(() {
          _listHD = event.snapshot.children.map((snapshot) {
            return DStenHoaDon.fromSnapshot(snapshot);
          }).toList();
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(itemCount: _listHD.length,itemBuilder:(context, index) {
      if (_listHD[index].SoLuong == 1) {
        Status = "Đã Hoàn Thành";
      }
      else{
        Status = "Đang Giao Hàng";
      }
      return Container(

        margin: EdgeInsets.all(10.0),
        width: (MediaQuery.of(context).size.width / 4) * 3,
        
        decoration: BoxDecoration(
          
          border: const Border(
            top: BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
            left: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            Text(_listHD[index].TenSanPham),
            Text('Số Lượng: '+ _listHD[index].SoLuong.toString()),
            Text('Đơn Giá:' + _listHD[index].DonGia.toString()),
            Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [   
              // TextButton(onPressed: (){
              //   Status = 'Đã Hoàn Thành';
              // }, child: Text('Đã nhận hàng')),
              Text(Status, style: TextStyle(color: Colors.redAccent),)
            ],
          )
          
        ]),
      );
    }, );
  }
}