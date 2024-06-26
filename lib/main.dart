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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: AppTheme.currentTheme,
      builder: (context, theme, child) {
        return MaterialApp(
          title: 'Sehatyaab',
          theme: theme,
          debugShowCheckedModeBanner: false,
          routes: AppRoutes.routes,
          initialRoute: AppRoutes.welcome,
          builder: (context, child) {
            return Scaffold(
              body: child,
            );
          },
        );
      },
    );
  }
}
