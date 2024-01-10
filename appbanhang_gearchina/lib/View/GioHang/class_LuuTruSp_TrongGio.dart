import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';

class GioHang {
  static List<SanPham> items = [];
  static void ThemSpVaoGio(SanPham sanPham) {
    items.add(sanPham);
  }

  static List<SanPham> HienSpTrongGio() {
    return items; 
  }
}
