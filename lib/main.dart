import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Providers/appointment_provider.dart';
import 'routes/AppRoutes.dart';
import 'services/FirebaseConnection.dart';
import 'theme/AppTheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConnection.initializeFirebase();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppointmentProvider(),
      child: const MyApp(),
    ),
  );
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
            title: const Text('Sehatyaab'),
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
