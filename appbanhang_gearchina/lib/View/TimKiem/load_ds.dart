import 'package:firebase_database/firebase_database.dart';

class DStenSanPham {
  final Ten;
 

  DStenSanPham({
    
    required this.Ten,
  
  });

  factory DStenSanPham.fromSnapshot(DataSnapshot snapshot) {
    return DStenSanPham(
      
      Ten: snapshot.child('Ten').value,
      
    );
  }

  toJson() {}
}


/*       MauSac: (snapshot.child("MauSac").value as List).map((data) {
        return MauSac_SanPham.fromMap(data);
      }).toList(), */