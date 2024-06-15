import 'package:flutter/material.dart';
import 'package:sehatyaab/routes/AppRoutes.dart';
import 'package:sehatyaab/widgets/CustomAppBar.dart';
import 'services/FirebaseConnection.dart';
import 'theme/AppTheme.dart';

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
          appBar: CustomAppBar(
            isDarkTheme: _isDarkTheme,
            toggleTheme: _toggleTheme,
          ),
          body: child,
        );
      },
    );
  }
}
