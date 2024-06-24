// import 'package:flutter/foundation.dart';
// import 'package:firebase_core/firebase_core.dart';

// class FirebaseConnection {
//   static Future<void> initializeFirebase() async {
//     try {
//       if (kIsWeb) {
//         await Firebase.initializeApp(
//           options: const FirebaseOptions(
//             apiKey: "AIzaSyDXU1f-LF8SYtzjbAFn-f0-HgP4DBdRLto",
//             authDomain: "sehatyaab-ec484.firebaseapp.com",
//             projectId: "sehatyaab-ec484",
//             storageBucket: "sehatyaab-ec484.appspot.com",
//             messagingSenderId: "640899746109",
//             appId: "1:640899746109:web:f421fde5a5ae5e37551d54",
//             measurementId: "G-H4DXYV6SDN",
//           ),
//         );
//       } else {
//           await Firebase.initializeApp(
//           // Replace with actual values
//           options: const FirebaseOptions(
//             apiKey: "AIzaSyDKQEmF7OTnhz1qMTWmsPylZNtp9TDYLQ4",
//             appId: "1:640899746109:android:f879c776abfd5fbe551d54",
//             messagingSenderId: "640899746109",
//             projectId: "sehatyaab-ec484",
//           ),
//         );
//       }
//       debugPrint('Firebase connection established successfully.');
//     } catch (e) {
//       debugPrint('Error initializing Firebase: $e');
//     }
//   }
// }

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
