
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCkiciuhOuR43T3GxWVrGmLH9XA1cqV_WY',
    appId: '1:899771568734:web:043d9c71ef2c3a80a61acf',
    messagingSenderId: '899771568734',
    projectId: 'yolo-c6728',
    authDomain: 'yolo-c6728.firebaseapp.com',
    databaseURL: 'https://yolo-c6728-default-rtdb.firebaseio.com',
    storageBucket: 'yolo-c6728.appspot.com',
    measurementId: 'G-EWNJPMEYM9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDe4qBskwZnwdn_n56fLSHDySBIQreWW7s',
    appId: '1:899771568734:android:7a5091eb654d4195a61acf',
    messagingSenderId: '899771568734',
    projectId: 'yolo-c6728',
    databaseURL: 'https://yolo-c6728-default-rtdb.firebaseio.com',
    storageBucket: 'yolo-c6728.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB7NJp2b1EJkDFaW5qcIDdMSTXFrKBVAts',
    appId: '1:899771568734:ios:69c069edb5f5cb2da61acf',
    messagingSenderId: '899771568734',
    projectId: 'yolo-c6728',
    databaseURL: 'https://yolo-c6728-default-rtdb.firebaseio.com',
    storageBucket: 'yolo-c6728.appspot.com',
    iosClientId: '899771568734-hfdsvvpvmrul05hog4mg12e4d2ua6e98.apps.googleusercontent.com',
    iosBundleId: 'com.example.eyeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB7NJp2b1EJkDFaW5qcIDdMSTXFrKBVAts',
    appId: '1:899771568734:ios:69c069edb5f5cb2da61acf',
    messagingSenderId: '899771568734',
    projectId: 'yolo-c6728',
    databaseURL: 'https://yolo-c6728-default-rtdb.firebaseio.com',
    storageBucket: 'yolo-c6728.appspot.com',
    iosClientId: '899771568734-hfdsvvpvmrul05hog4mg12e4d2ua6e98.apps.googleusercontent.com',
    iosBundleId: 'com.example.eyeApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCkiciuhOuR43T3GxWVrGmLH9XA1cqV_WY',
    appId: '1:899771568734:web:043d9c71ef2c3a80a61acf',
    messagingSenderId: '899771568734',
    projectId: 'yolo-c6728',
    authDomain: 'yolo-c6728.firebaseapp.com',
    databaseURL: 'https://yolo-c6728-default-rtdb.firebaseio.com',
    storageBucket: 'yolo-c6728.appspot.com',
    measurementId: 'G-EWNJPMEYM9',
  );

}