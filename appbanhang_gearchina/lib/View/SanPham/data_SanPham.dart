import 'package:firebase_database/firebase_database.dart';

class SanPham {
  final Ten;
  final Loai;
  final MoTa;
  final Hinh;
  int SoLuong=0;
  final ThongSo;
  final TrangThai;
  var Id;
  final Mau;
  final Gia;

  SanPham({
    required this.Hinh,
    required this.Id,
    required this.Loai,
    required this.Mau,
    required this.MoTa,
    required this.SoLuong,
    required this.Ten,
    required this.ThongSo,
    required this.TrangThai,
    required this.Gia,
  });

  factory SanPham.fromSnapshot(DataSnapshot snapshot) {
    return SanPham(
      Gia: snapshot.child('Gia').value,
      Hinh: snapshot.child('Hinh').value,
      Id: snapshot.child('Id').value,
      Loai: snapshot.child('Loai').value,
      Mau: snapshot.child('Mau').value,
      MoTa: snapshot.child('MoTa').value,
      SoLuong: int.parse(snapshot.child('SoLuong').value.toString()),
      Ten: snapshot.child('Ten').value,
      ThongSo: snapshot.child('ThongSo').value,
      TrangThai: snapshot.child('TrangThai').value,
    );
  }
}
