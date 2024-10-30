import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'notification/firebase_api/firebase_api.dart';
import 'notification/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Firebase Notifications
  await FirebaseApi().initNotifications();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String notificationTitle = 'No title';
  String notificationBody = 'No body';
  String notificationData = 'No data';

  final FCM firebaseMessaging = FCM(); // Initialize an instance of FCM

  @override
  void initState() {
    super.initState();
    firebaseMessaging.setUpNotification();

    // Listen to FCM streams and update UI accordingly
    firebaseMessaging.titleCtrl.stream.listen((title) {
      setState(() {
        notificationTitle = title;
      });
    });

    firebaseMessaging.bodyCtrl.stream.listen((body) {
      setState(() {
        notificationBody = body;
      });
    });

    firebaseMessaging.streamCtrl.stream.listen((data) {
      setState(() {
        notificationData = data;
      });
    });
  }

  @override
  void dispose() {
    // Ensure resources are freed when the screen is closed
    firebaseMessaging.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notification Title:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(notificationTitle),
            SizedBox(height: 20),
            Text('Notification Body:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(notificationBody),
            SizedBox(height: 20),
            Text('Notification Data:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(notificationData),
          ],
        ),
      ),
    );
  }
}
