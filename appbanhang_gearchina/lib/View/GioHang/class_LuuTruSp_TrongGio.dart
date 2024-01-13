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
class CRUD_GioHang {
  static List<SanPham> _cartItems = [];

  static List<SanPham> HienSpTrongGio() {
    return _cartItems;
  }

  static void ThemSpVaoGio(SanPham sanPham) {
    _cartItems.add(sanPham);
  }

  static void XoaSpKhoiGio(SanPham sanPham) {
    _cartItems.remove(sanPham);
  }

  static void XoaTatCaSp() {
    _cartItems.clear();
  }
}
class CartItems {
  static List<SanPham> cartItems = [];
}