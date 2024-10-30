import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessages(RemoteMessage message) async {
  // Initialize Firebase if not already initialized

  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("Payload: ${message.data}");
}



class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // Register the background message handler
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessages);

    // Request notification permissions
    await _firebaseMessaging.requestPermission();

    // Get the FCM token
    final fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token: $fcmToken");
  }
}
