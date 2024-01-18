import 'package:appbanhang_gearchina/View/ChiTietSanPham/MauSac_Sp.dart';
import 'package:appbanhang_gearchina/View/GioHang/data_Giohang.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';

class GioHang_CRUD {
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

class Cartlocal {
  static List<SanPham> cartItems = [];

  static final Cartlocal _instance = Cartlocal._internal();

  factory Cartlocal() {
    return _instance;
  }
 
  Cartlocal._internal();
}
class Cart {
  List<GioHang> cartItems = [];

  static final Cart _instance = Cart._internal();

  factory Cart() {
    return _instance;
  }

  Cart._internal();
}