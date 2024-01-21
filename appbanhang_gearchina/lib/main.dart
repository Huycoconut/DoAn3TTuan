import 'package:appbanhang_gearchina/View/ChiTietSanPham/ChiTietSp_Screen.dart';
import 'package:appbanhang_gearchina/View/ChiTietSanPham/MauSac_Sp.dart';
import 'package:appbanhang_gearchina/View/ChiTietSanPham/QL_SoLuongSp.dart';
import 'package:appbanhang_gearchina/View/DangNhap_DangKy/firebase_auth.dart';
import 'package:appbanhang_gearchina/View/DangNhap_DangKy/login.dart';
import 'package:appbanhang_gearchina/View/SanPham/data_SanPham.dart';
import 'package:appbanhang_gearchina/View/SanPham/load_SanPham.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/SuaDiaChi_Screen.dart';
import 'package:appbanhang_gearchina/View/ThanhToan/ThanhToan_Screen.dart';
import 'package:appbanhang_gearchina/View/GioHang/GioHang_Screen.dart';
import 'package:appbanhang_gearchina/View/SanPham/SanPham_screen.dart';
import 'package:appbanhang_gearchina/View/ThongBao/local_notification.dart';
import 'package:appbanhang_gearchina/View/Trang_chu/Home.dart';
import 'package:appbanhang_gearchina/View/Trang_chu/botNav.dart';
import 'package:appbanhang_gearchina/firebase_options.dart';
import 'package:appbanhang_gearchina/localStorage/local_storage_slide_show.dart';
import 'package:appbanhang_gearchina/test.dart';
import 'package:appbanhang_gearchina/test2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Tạo hive (LocalDatabase)
  await Hive.initFlutter('hiveusersfolder');
  await Hive.openBox("boxSlider");
  await Hive.openBox("boxTongTien");
  await Hive.openBox("boxTrangThai");
  // Lấy dữ liệu SlideShow về LocalDatabase
  await DB().getListSlider();
  // Tạo Thông báo Local
  await LocalNotifications.init();
  // Yêu cầu quyền thông báo
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  //Thông báo trạng thái đơn hàng
  ThongBaoDonHang();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthScreen(),
      routes: {'/home_screen': (context) => const AuthScreen()},
      debugShowCheckedModeBanner: false,
    );
  }
}

String? userIDMain;
var refMain;
void ThongBaoDonHang() {
  userIDMain = FirebaseAuth.instance.currentUser?.uid;
  refMain = FirebaseDatabase.instance
      .ref("/HoaDon")
      .orderByChild('userID')
      .equalTo(userIDMain);
  refMain.onValue.listen((event) {
    LocalNotifications.showSimpleNotification(
        title: "Thông báo về đơn hàng của bạn",
        body: "Có sự thay đổi trạng thái đơn hàng của bạn. Hãy vào kiểm tra",
        payload: "");
  });
}
