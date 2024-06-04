import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyDXU1f-LF8SYtzjbAFn-f0-HgP4DBdRLto",
          authDomain: "sehatyaab-ec484.firebaseapp.com",
          projectId: "sehatyaab-ec484",
          storageBucket: "sehatyaab-ec484.appspot.com",
          messagingSenderId: "640899746109",
          appId: "1:640899746109:web:f421fde5a5ae5e37551d54",
          measurementId: "G-H4DXYV6SDN",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
    print('Firebase connection established successfully.');
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sehatyaab',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sehatyaab Home Page'),
      ),
      body: const Center(
        child: Text('Welcome to Sehatyaab!'),
      ),
    );
  }
}
