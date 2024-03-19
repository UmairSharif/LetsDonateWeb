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
    apiKey: 'AIzaSyBUVryELKXAZ-AOnO66C74UtMRJCp_b4JY',
    appId: '1:144227294206:web:b6aca0013e814aff943eaf',
    messagingSenderId: '144227294206',
    projectId: 'letsdonate-9d525',
    authDomain: 'letsdonate-9d525.firebaseapp.com',
    storageBucket: 'letsdonate-9d525.appspot.com',
    measurementId: 'G-LF0J18WMLT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEDgyDg4nl6ctkz1j4YiKpTk8Vcik2jns',
    appId: '1:144227294206:android:fd91cedc96687a0c943eaf',
    messagingSenderId: '144227294206',
    projectId: 'letsdonate-9d525',
    storageBucket: 'letsdonate-9d525.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAPQoFrExSdUfYTD1UH-RmlkMFciQzoj-0',
    appId: '1:144227294206:ios:8e607f83b4bfa9e7943eaf',
    messagingSenderId: '144227294206',
    projectId: 'letsdonate-9d525',
    storageBucket: 'letsdonate-9d525.appspot.com',
    androidClientId: '144227294206-cp86gl6h5q988iebh338ak3koq8m4ihi.apps.googleusercontent.com',
    iosClientId: '144227294206-p4mvqd121vdfeg1q3ftas73fug3vkbjo.apps.googleusercontent.com',
    iosBundleId: 'com.example.letsDonateWeb',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAPQoFrExSdUfYTD1UH-RmlkMFciQzoj-0',
    appId: '1:144227294206:ios:86a792b43bed729a943eaf',
    messagingSenderId: '144227294206',
    projectId: 'letsdonate-9d525',
    storageBucket: 'letsdonate-9d525.appspot.com',
    androidClientId: '144227294206-cp86gl6h5q988iebh338ak3koq8m4ihi.apps.googleusercontent.com',
    iosClientId: '144227294206-5jofmtqrtt0kjuc0ctmd24h0v6eegpur.apps.googleusercontent.com',
    iosBundleId: 'com.example.letsDonateWeb.RunnerTests',
  );
}
