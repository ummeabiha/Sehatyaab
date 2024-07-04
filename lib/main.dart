import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'Providers/AppointmentProvider.dart';
import 'routes/AppRoutes.dart';
import 'services/FirebaseConnection.dart';
import 'theme/AppTheme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await dotenv.load();
  await FirebaseConnection.initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
      //   ChangeNotifierProvider(
      // create: (context) => AppState()),
      ],
      child: ValueListenableBuilder<ThemeData>(
        valueListenable: AppTheme.currentTheme,
        builder: (context, theme, child) {
          return MaterialApp(
            title: 'Sehatyaab',
            theme: theme,
            debugShowCheckedModeBanner: false,
            routes: AppRoutes.routes,
            initialRoute: AppRoutes.splash,
            builder: (context, child) {
              return Scaffold(
                body: child,
              );
            },
          );
        },
      ),
    );
  }
}
