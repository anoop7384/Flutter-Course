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
    apiKey: 'AIzaSyD4W3LyWIHfU61aAIs3aPnpGxWFWpycAI0',
    appId: '1:114577427887:web:110071e9db770b1112335a',
    messagingSenderId: '114577427887',
    projectId: 'chatrooms-b63cc',
    authDomain: 'chatrooms-b63cc.firebaseapp.com',
    storageBucket: 'chatrooms-b63cc.appspot.com',
    measurementId: 'G-1NB8053ERN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVfnWrJ3f6l2BZTN4fZVOrp-ozz8PpTd0',
    appId: '1:114577427887:android:12ae617523f471e812335a',
    messagingSenderId: '114577427887',
    projectId: 'chatrooms-b63cc',
    storageBucket: 'chatrooms-b63cc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOXGFjCMfwR89RLUAVwMoUp5MA9gEBy7A',
    appId: '1:114577427887:ios:40a91ae56af5300712335a',
    messagingSenderId: '114577427887',
    projectId: 'chatrooms-b63cc',
    storageBucket: 'chatrooms-b63cc.appspot.com',
    iosClientId: '114577427887-38idj96jo89hnjkebhjpt1qu5qtf4h6q.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatrooms',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBOXGFjCMfwR89RLUAVwMoUp5MA9gEBy7A',
    appId: '1:114577427887:ios:40a91ae56af5300712335a',
    messagingSenderId: '114577427887',
    projectId: 'chatrooms-b63cc',
    storageBucket: 'chatrooms-b63cc.appspot.com',
    iosClientId: '114577427887-38idj96jo89hnjkebhjpt1qu5qtf4h6q.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatrooms',
  );
}