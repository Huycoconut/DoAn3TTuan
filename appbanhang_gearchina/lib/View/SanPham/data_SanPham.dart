import 'package:firebase_database/firebase_database.dart';

class SanPham {
  final Ten;
  final Loai;
  final MoTa;
  final Hinh;
  int SoLuong = 0;
  final ThongSo;
  String TrangThai;
  var Id;
  final Mau;
 int Gia=0;
  final MauSac;
  final GiamGia;

  SanPham({
  
    required this.GiamGia,
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
      GiamGia: snapshot.child('GiamGia').value,
      MauSac: snapshot.child("MauSac").value,
      Gia:int.parse(snapshot.child('Gia').value.toString()),
      Hinh: snapshot.child('Hinh').value,
      Id: snapshot.child('Id').value,
      Loai: snapshot.child('Loai').value,
      Mau: snapshot.child('Mau').value,
      MoTa: snapshot.child('MoTa').value,
      SoLuong: int.parse(snapshot.child('SoLuong').value.toString()),
      Ten: snapshot.child('Ten').value,
      ThongSo: snapshot.child('ThongSo').value,
      TrangThai: snapshot.child('TrangThai').value.toString(),
    );
  }

  toJson() {}
}

class MauSac_SanPham {
  final TenMau;
  MauSac_SanPham({required this.TenMau});

  factory MauSac_SanPham.fromSnapshot(DataSnapshot snapshot) {
    return MauSac_SanPham(TenMau: snapshot.child('TenMau').value);
  }
}

/*       MauSac: (snapshot.child("MauSac").value as List).map((data) {
        return MauSac_SanPham.fromMap(data);
      }).toList(), */