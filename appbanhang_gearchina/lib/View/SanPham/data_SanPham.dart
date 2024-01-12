import 'package:firebase_database/firebase_database.dart';

class SanPham {
  final Ten;
  final Loai;
  final MoTa;
  final Hinh;
  int SoLuong = 0;
  final ThongSo;
  final TrangThai;
  var Id;
  final Mau;
  final Gia;
  final MauSac;

  SanPham({
    required this.MauSac,
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
      MauSac: snapshot.child("MauSac").value,
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

  toJson() {}
}

class MauSac_SanPham {
  final Id;
  final TrangThai;

  MauSac_SanPham({required this.Id, required this.TrangThai});

  factory MauSac_SanPham.fromMap(Map<String, dynamic> map) {
    return MauSac_SanPham(Id: map['id'], TrangThai: map['TrangThai']);
  }
}

/*       MauSac: (snapshot.child("MauSac").value as List).map((data) {
        return MauSac_SanPham.fromMap(data);
      }).toList(), */