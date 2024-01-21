import 'package:firebase_database/firebase_database.dart';

class DStenHoaDon {
  final MaHD;
  final DonGia;
  int SoLuong;
  final TenSanPham;
  DStenHoaDon({
    required this.MaHD,
    required this.DonGia,
    required this.SoLuong,
    required this.TenSanPham,
  
  });
  factory DStenHoaDon.fromSnapshot(DataSnapshot snapshot) {
    
    return DStenHoaDon(
      
      MaHD: snapshot.child('MaHD').value,
      DonGia: snapshot.child('DonGia').value,
      SoLuong: int.parse(snapshot.child('SoLuong').value.toString()),
      TenSanPham: snapshot.child('TenSanPham').value,
      
    );
  }
  toJson() {}
}
