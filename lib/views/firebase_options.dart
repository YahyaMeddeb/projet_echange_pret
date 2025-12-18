// File: lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
/*
Remplacer les valeurs par celles de ton google-services.json :
current_key → apiKey
mobilesdk_app_id → appId
project_id → projectId
storage_bucket → storageBucket
project_number → messagingSenderId*/

class DefaultFirebaseOptions {
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDlXkxZm6DFbOat89VOHSFU4G5xSi-WCxA',
    appId: '1:770271494246:android:7aa99559467aa8014aada7',
    messagingSenderId: '770271494246',
    projectId: 'echangepretbiens',
    storageBucket: 'echangepretbiens.firebasestorage.app',
  );

  static FirebaseOptions get currentPlatform {
    return android;
  }
}