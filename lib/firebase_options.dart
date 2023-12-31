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
        return macos;
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
    apiKey: 'AIzaSyClvMlBt22CSp0WtxXxFnS2-iGOZ7n9V5E',
    appId: '1:192690528297:web:08cad7e2d6eded5b1d7c38',
    messagingSenderId: '192690528297',
    projectId: 'clone-460fd',
    authDomain: 'clone-460fd.firebaseapp.com',
    storageBucket: 'clone-460fd.appspot.com',
    measurementId: 'G-H3KJH4W3MV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB36wX4CJKT8h6xYYTfeQk2RAcGXEHkXHo',
    appId: '1:192690528297:android:4fa3dc04e78384df1d7c38',
    messagingSenderId: '192690528297',
    projectId: 'clone-460fd',
    storageBucket: 'clone-460fd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqMPJtPpo_TU21gjjeU_t3Q7LBY8TwppU',
    appId: '1:192690528297:ios:9bbb0b967edba9cb1d7c38',
    messagingSenderId: '192690528297',
    projectId: 'clone-460fd',
    storageBucket: 'clone-460fd.appspot.com',
    iosClientId: '192690528297-qom3upm9ip7hi8f8k2bdgaj7k4qu8dh0.apps.googleusercontent.com',
    iosBundleId: 'com.example.amazoncloneapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAqMPJtPpo_TU21gjjeU_t3Q7LBY8TwppU',
    appId: '1:192690528297:ios:6174bb05a648b4f01d7c38',
    messagingSenderId: '192690528297',
    projectId: 'clone-460fd',
    storageBucket: 'clone-460fd.appspot.com',
    iosClientId: '192690528297-2i33k6jocn69q92r9nhfql98dlg06s8e.apps.googleusercontent.com',
    iosBundleId: 'com.example.amazoncloneapp.RunnerTests',
  );
}
