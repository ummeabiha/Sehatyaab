import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseConnection {
  static Future<void> initializeFirebase() async {
    try {
      if (kIsWeb) {
        await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: dotenv.env['FIREBASE_API_KEY']!,
            authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN']!,
            projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
            storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
            messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
            appId: dotenv.env['FIREBASE_APP_ID']!,
            measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID']!,
          ),
        );
      } else {
        await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: dotenv.env['FIREBASE_ANDROID_API_KEY']!,
            appId: dotenv.env['FIREBASE_ANDROID_APP_ID']!,
            messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
            projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
          ),
        );
      }
      debugPrint('Firebase connection established successfully.');
    } catch (e) {
      debugPrint('Error initializing Firebase: $e');
    }
  }
}
