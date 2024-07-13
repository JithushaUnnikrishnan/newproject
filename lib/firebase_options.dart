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
    apiKey: 'AIzaSyD-u8zwqGsKoG78Vk_6S4BXqRvGUYsLCVo',
    appId: '1:1031326292203:web:fa50bba84cec39b73406ae',
    messagingSenderId: '1031326292203',
    projectId: 'tiny-87900',
    authDomain: 'tiny-87900.firebaseapp.com',
    storageBucket: 'tiny-87900.appspot.com',
    measurementId: 'G-87BRPYML1N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCN3kiqHgqqSovwhqTTT5sU7EPLlBA3Q6Q',
    appId: '1:1031326292203:android:6ad111689034b5653406ae',
    messagingSenderId: '1031326292203',
    projectId: 'tiny-87900',
    storageBucket: 'tiny-87900.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUWSlADtYhRv5nsFt-K7ZPE0hHuURHVQc',
    appId: '1:1031326292203:ios:0fb121a805bb03393406ae',
    messagingSenderId: '1031326292203',
    projectId: 'tiny-87900',
    storageBucket: 'tiny-87900.appspot.com',
    iosBundleId: 'com.example.tiny',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCUWSlADtYhRv5nsFt-K7ZPE0hHuURHVQc',
    appId: '1:1031326292203:ios:0fb121a805bb03393406ae',
    messagingSenderId: '1031326292203',
    projectId: 'tiny-87900',
    storageBucket: 'tiny-87900.appspot.com',
    iosBundleId: 'com.example.tiny',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD-u8zwqGsKoG78Vk_6S4BXqRvGUYsLCVo',
    appId: '1:1031326292203:web:dff412f4b45db0a33406ae',
    messagingSenderId: '1031326292203',
    projectId: 'tiny-87900',
    authDomain: 'tiny-87900.firebaseapp.com',
    storageBucket: 'tiny-87900.appspot.com',
    measurementId: 'G-0Z20DV3R89',
  );
}
