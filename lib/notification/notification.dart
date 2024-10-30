import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCM {
  final streamCtrl = StreamController<String>.broadcast();
  final titleCtrl = StreamController<String>.broadcast();
  final bodyCtrl = StreamController<String>.broadcast();

  void setUpNotification() {
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

    // Thiết lập xử lý thông báo ở các trạng thái khác nhau
    foregroundNotification();
    backgroundNotification();
    terminateNotification();
  }

  void foregroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Kiểm tra và phát dữ liệu nếu có
      if (message.data.containsKey('data')) {
        streamCtrl.sink.add(message.data['data']);
      }

      // Kiểm tra và phát thông tin tiêu đề và nội dung nếu có
      titleCtrl.sink.add(message.notification?.title ?? 'No Title');
      bodyCtrl.sink.add(message.notification?.body ?? 'No Body');
    });
  }

  void backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Xử lý dữ liệu khi ứng dụng được mở từ trạng thái nền
      if (message.data.containsKey('data')) {
        streamCtrl.sink.add(message.data['data']);
      }

      titleCtrl.sink.add(message.notification?.title ?? 'No Title');
      bodyCtrl.sink.add(message.notification?.body ?? 'No Body');
    });
  }

  Future<void> _onBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();

    // Phát dữ liệu và kiểm tra xem có dữ liệu 'data' hoặc 'notification' không
    if (message.data.containsKey('data')) {
      streamCtrl.sink.add(message.data['data']);
    }

    titleCtrl.sink.add(message.notification?.title ?? 'No Title');
    bodyCtrl.sink.add(message.notification?.body ?? 'No Body');
  }

  void terminateNotification() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      // Kiểm tra và phát dữ liệu nếu có
      if (initialMessage.data.containsKey('data')) {
        streamCtrl.sink.add(initialMessage.data['data']);
      }

      titleCtrl.sink.add(initialMessage.notification?.title ?? 'No Title');
      bodyCtrl.sink.add(initialMessage.notification?.body ?? 'No Body');
    }
  }

  void dispose() {
    // Đóng tất cả các StreamController để tránh rò rỉ bộ nhớ
    streamCtrl.close();
    titleCtrl.close();
    bodyCtrl.close();
  }
}
