import 'package:firebase_database/firebase_database.dart';

class Sliderr {
  final TrangThai;
  final Base64;
  const Sliderr({required this.TrangThai, required this.Base64});
  factory Sliderr.fromSnapshot(DataSnapshot snapshot) {
    return Sliderr(
        TrangThai: snapshot.child("TrangThai").value,
        Base64: snapshot.child("Base64").value);
  }
  factory Sliderr.fromMap(Map<dynamic, dynamic> map) {
    return Sliderr(
      TrangThai: map['TrangThai'] ?? '',
      Base64: map['Base64'] ?? '',
    );
  }
}
