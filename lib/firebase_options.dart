// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAm9iduSE2eL5u2d1HCurjYHeyK_MCY6Bk',
    appId: '1:956085840540:web:cefe8b1cfdd5e4edbb9b59',
    messagingSenderId: '956085840540',
    projectId: 'library-zehra',
    authDomain: 'library-zehra.firebaseapp.com',
    storageBucket: 'library-zehra.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhLnSbyWSFUKVGMRJWRZXz_TPsYxUne7o',
    appId: '1:956085840540:android:b74fb6f8d5940538bb9b59',
    messagingSenderId: '956085840540',
    projectId: 'library-zehra',
    storageBucket: 'library-zehra.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB23C9d54OmWvtNxbfBw76BrDSbIWJ-pEo',
    appId: '1:956085840540:ios:41d66d5e96c77313bb9b59',
    messagingSenderId: '956085840540',
    projectId: 'library-zehra',
    storageBucket: 'library-zehra.appspot.com',
    iosClientId: '956085840540-ojkj6rtd2nsj6eqg4q2fo2ipqe9u5n29.apps.googleusercontent.com',
    iosBundleId: 'libraryzehra',
  );
}
