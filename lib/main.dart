// import 'package:flutter/material.dart';
// import 'package:sehatyaab/routes/AppRoutes.dart';
// import 'services/FirebaseConnection.dart';
// import 'theme/AppTheme.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await FirebaseConnection.initializeFirebase();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<ThemeData>(
//       valueListenable: AppTheme.currentTheme,
//       builder: (context, theme, child) {
//         return MaterialApp(
//           title: 'Sehatyaab',
//           theme: theme,
//           debugShowCheckedModeBanner: false,
//           routes: AppRoutes.routes,
//           initialRoute: AppRoutes.welcome,
//           builder: (context, child) {
//             return Scaffold(
//               body: child,
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:sehatyaab/Providers/appointment_provider.dart';
import 'routes/AppRoutes.dart';
import 'services/FirebaseConnection.dart';
import 'theme/AppTheme.dart';
import 'services/ZegoConnection.dart';


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

        ],
    child:  ValueListenableBuilder<ThemeData>(
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
    ),
    );
  }
}
