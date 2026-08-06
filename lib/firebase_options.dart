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
    apiKey: 'AIzaSyCGyy7ORe8k55EQn5m2P7VujkAV1bu7ago',
    appId: '1:586591187065:web:44287333795b9bfa5864a8',
    messagingSenderId: '586591187065',
    projectId: 'blinkit-clone-33aa8',
    authDomain: 'blinkit-clone-33aa8.firebaseapp.com',
    storageBucket: 'blinkit-clone-33aa8.firebasestorage.app',
    measurementId: 'G-C2DM8QR79Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADl3OjZwvMjmP8fnAdrL9LB5hNBsGInDs',
    appId: '1:586591187065:android:494e30e76b63afe85864a8',
    messagingSenderId: '586591187065',
    projectId: 'blinkit-clone-33aa8',
    storageBucket: 'blinkit-clone-33aa8.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCygjbU01HWJWieoz1pqHxlYteVmPbtUE4',
    appId: '1:586591187065:ios:2907769ea751bc6d5864a8',
    messagingSenderId: '586591187065',
    projectId: 'blinkit-clone-33aa8',
    storageBucket: 'blinkit-clone-33aa8.firebasestorage.app',
    iosBundleId: 'com.example.blinkitApp',
  );
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCygjbU01HWJWieoz1pqHxlYteVmPbtUE4',
    appId: '1:586591187065:ios:2907769ea751bc6d5864a8',
    messagingSenderId: '586591187065',
    projectId: 'blinkit-clone-33aa8',
    storageBucket: 'blinkit-clone-33aa8.firebasestorage.app',
    iosBundleId: 'com.example.blinkitApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCGyy7ORe8k55EQn5m2P7VujkAV1bu7ago',
    appId: '1:586591187065:web:c2e489c40ee6b4385864a8',
    messagingSenderId: '586591187065',
    projectId: 'blinkit-clone-33aa8',
    authDomain: 'blinkit-clone-33aa8.firebaseapp.com',
    storageBucket: 'blinkit-clone-33aa8.firebasestorage.app',
    measurementId: 'G-2WZBZ3MDLS',
  );
}
