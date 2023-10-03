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
    apiKey: 'AIzaSyCC7eD0mJ5Jolifyw9iJ327eRqNchHqiPc',
    appId: '1:105788726998:web:d6238de55792f28f657377',
    messagingSenderId: '105788726998',
    projectId: 'emagz-wo',
    authDomain: 'emagz-wo.firebaseapp.com',
    storageBucket: 'emagz-wo.appspot.com',
    measurementId: 'G-HYZ1Z4244P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCc_cChiEFJf6PqXOa6xmVstGrk7-qcC90',
    appId: '1:105788726998:android:a33659ba08d8b211657377',
    messagingSenderId: '105788726998',
    projectId: 'emagz-wo',
    storageBucket: 'emagz-wo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDtrgBgGBkCL3Fn6VBKBwB0UuoT4o_dUUk',
    appId: '1:105788726998:ios:33a3019396db3c65657377',
    messagingSenderId: '105788726998',
    projectId: 'emagz-wo',
    storageBucket: 'emagz-wo.appspot.com',
    androidClientId: '105788726998-oqdqrjt0coivgftt33kaefvd2oio95r5.apps.googleusercontent.com',
    iosClientId: '105788726998-k18uij98q32mdj9o7s36gtd4341o4ptc.apps.googleusercontent.com',
    iosBundleId: 'app.vendor.emagzVendor',
  );
}