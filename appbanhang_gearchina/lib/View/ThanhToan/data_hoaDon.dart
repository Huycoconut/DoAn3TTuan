import 'package:firebase_database/firebase_database.dart';

class HoaDon {
  final MaHD;
  final MaKH;
  final ThanhTien;
  final TrangThai;

  HoaDon({
    required this.MaHD,
    required this.MaKH,
    required this.ThanhTien,
    required this.TrangThai,
  });

  factory HoaDon.fromSnashot(DataSnapshot snapshot) {
    return HoaDon(
      MaHD: snapshot.child('MaHD').value,
      MaKH: snapshot.child('MaKH').value,
      ThanhTien: snapshot.child('ThanhTien').value,
      TrangThai: snapshot.child('TrangThai').value,
    );
  }
}
