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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3I61NOhKA322CdrnBUho64Jc1nuW2gmc',
    appId: '1:504209927148:android:1cd3cc1a338687de332ec9',
    messagingSenderId: '504209927148',
    projectId: 'essam-vocabe',
    storageBucket: 'essam-vocabe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCt3L5wzOaWFD5d2cNNGa1wlaH0DxCWQto',
    appId: '1:504209927148:ios:f2571ffc7911c0f9332ec9',
    messagingSenderId: '504209927148',
    projectId: 'essam-vocabe',
    storageBucket: 'essam-vocabe.appspot.com',
    androidClientId: '504209927148-nkk0uph5aepb2om6qn732u3cij9f85e0.apps.googleusercontent.com',
    iosClientId: '504209927148-f96nr433k06fsddqr32dmd2koefov8j1.apps.googleusercontent.com',
    iosBundleId: 'com.example.esaamVocab',
  );
}
