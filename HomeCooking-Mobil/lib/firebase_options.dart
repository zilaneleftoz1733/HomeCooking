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
    apiKey: 'AIzaSyCiYKMxngFtteT4QIkNA_OIUSxyZikWwQg',
    appId: '1:234327680916:android:95e4e13548f2d7b6a29181',
    messagingSenderId: '234327680916',
    projectId: 'project-management-22705',
    storageBucket: 'project-management-22705.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCU1MXfA2SQxNbH2JeOraJiA5ysTC40_ko',
    appId: '1:234327680916:ios:da4778a8427cf609a29181',
    messagingSenderId: '234327680916',
    projectId: 'project-management-22705',
    storageBucket: 'project-management-22705.appspot.com',
    androidClientId: '234327680916-t914ev8ngjq5fbcknok8n4pkl5a3nchm.apps.googleusercontent.com',
    iosClientId: '234327680916-9gd5cq9pfgfrldf4oftc5ncddhgl4i4v.apps.googleusercontent.com',
    iosBundleId: 'com.alicelikbag.projectmanagement',
  );
}
