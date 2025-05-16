import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'mahasiswa-dosen/screens/home_screen.dart';
import 'mahasiswa-dosen/screens/profile_screen.dart';
import 'mahasiswa-dosen/screens/role_selection_screen.dart';
import 'mahasiswa-dosen/screens/splash_screen.dart';  

void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => FasParkApp(), // Wrap your app
  ),
);

class FasParkApp extends StatelessWidget {
  const FasParkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'FasPark App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/role': (context) => RoleSelectionScreen(), // ← tambahkan ini
      },
    );
  }
}
