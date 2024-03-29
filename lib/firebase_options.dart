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
    apiKey: 'AIzaSyCOlyEtinBp0Rjmcs4osrrGdaXbmmIf3bk',
    appId: '1:82436170302:web:4c1a7a32c2caa1f261676f',
    messagingSenderId: '82436170302',
    projectId: 'dan-energy-inventory-app',
    authDomain: 'dan-energy-inventory-app.firebaseapp.com',
    storageBucket: 'dan-energy-inventory-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3nFpbqJrndvsUPoEJ_Zzp4qKQT9xSV1E',
    appId: '1:82436170302:android:baccf298b0d2017761676f',
    messagingSenderId: '82436170302',
    projectId: 'dan-energy-inventory-app',
    storageBucket: 'dan-energy-inventory-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB7FuW9UOqzKTwXVrm8qtqaqjcMRAVkx6M',
    appId: '1:82436170302:ios:2e61b7ce34dc3c0d61676f',
    messagingSenderId: '82436170302',
    projectId: 'dan-energy-inventory-app',
    storageBucket: 'dan-energy-inventory-app.appspot.com',
    iosClientId:
        '82436170302-shahh6k3kni3eom4kft8nkfavqkm0645.apps.googleusercontent.com',
    iosBundleId: 'com.example.inventory',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB7FuW9UOqzKTwXVrm8qtqaqjcMRAVkx6M',
    appId: '1:82436170302:ios:c132d0b12014b0f461676f',
    messagingSenderId: '82436170302',
    projectId: 'dan-energy-inventory-app',
    storageBucket: 'dan-energy-inventory-app.appspot.com',
    iosClientId:
        '82436170302-vcf2s41itf3kc80l6agp7tjvo4phtspj.apps.googleusercontent.com',
    iosBundleId: 'com.example.inventory.RunnerTests',
  );
}
