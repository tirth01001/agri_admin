// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCx9cEZ5Bv8UDIJg5hRLXQ865prB0MPnIU',
    appId: '1:642348732157:web:0d6fbe268d709533393894',
    messagingSenderId: '642348732157',
    projectId: 'college-project-56506',
    authDomain: 'college-project-56506.firebaseapp.com',
    databaseURL: 'https://college-project-56506-default-rtdb.firebaseio.com',
    storageBucket: 'college-project-56506.appspot.com',
    measurementId: 'G-V9489S7K0Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVjFrCCuIxm6p4cWdKc_Wbmd_rCZxQsK4',
    appId: '1:642348732157:android:98a7edd4425c4d35393894',
    messagingSenderId: '642348732157',
    projectId: 'college-project-56506',
    databaseURL: 'https://college-project-56506-default-rtdb.firebaseio.com',
    storageBucket: 'college-project-56506.appspot.com',
  );
}
