import 'package:flutter/material.dart';
import 'services/firebase_connection.dart';
import 'theme/AppTheme.dart';
import 'routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConnection.initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sehatyaab',
      theme: _isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.welcome,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Sehatyaab'),
            actions: [
              IconButton(
                icon: Icon(_isDarkTheme ? Icons.light_mode : Icons.dark_mode),
                onPressed: _toggleTheme,
              ),
            ],
          ),
          body: child,
        );
      },
    );
  }
}
