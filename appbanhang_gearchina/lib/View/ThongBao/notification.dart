import 'package:firebase_messaging/firebase_messaging.dart';

class Notification {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      return token;
    });
  }
}
