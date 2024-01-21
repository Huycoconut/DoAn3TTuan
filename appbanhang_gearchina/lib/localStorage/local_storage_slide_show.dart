import 'package:appbanhang_gearchina/localStorage/slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive/hive.dart';

class DB {
  final refSlider = FirebaseDatabase.instance.ref().child('Slider');
  late Query refSlider1 =
      refSlider.orderByChild("TrangThai").startAt(1).endAt(2);
  List<Sliderr> listSlider = [];

  final boxSlider = Hive.box('boxSlider');
  getListSlider() {
    boxSlider.clear();
    refSlider1.onValue.listen((event) {
      listSlider = event.snapshot.children.map((snapshot) {
        return Sliderr.fromSnapshot(snapshot);
      }).toList();
      DB().updateData(listSlider);
    });
  }

  updateData(List<Sliderr> listSlider) async {
    for (final (index, item) in listSlider.indexed) {
      boxSlider.put(index, item.Base64);
    }
  }

  String readData(int index) {
    return boxSlider.getAt(index).toString();
  }
}
