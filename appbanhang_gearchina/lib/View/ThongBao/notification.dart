import 'package:firebase_messaging/firebase_messaging.dart';

void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true);
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("User granted permisstion");
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print("User granted provisinal permisstion");
  } else {
    print("User declined or has not accepted permisstion");
  }
}

void getToken() async {
  await FirebaseMessaging.instance.getToken().then((token) {
    print("My token: $token");
  });
}
