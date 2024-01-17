import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:firebase_database/firebase_database.dart';

class ChitietHD {
  final DonGia;
  final MaHD;
  final MaSP;
  final SoLuong;
  final TrangThai;

  ChitietHD({
    required this.DonGia,
    required this.MaHD,
    required this.MaSP,
    required this.SoLuong,
    required this.TrangThai,
  });

  factory ChitietHD.fromSnapshot(DataSnapshot snapshot) {
    return ChitietHD(
        DonGia: snapshot.child('DonGia').value,
        MaHD: snapshot.child('MaHD').value,
        MaSP: snapshot.child('MaSP').value,
        SoLuong: snapshot.child('SoLuong').value,
        TrangThai: snapshot.child('TrangThai').value);
  }
}
