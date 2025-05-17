import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

// Import Providers
import 'providers/report_provider.dart';
import 'providers/record_provider.dart';

// Screens Petugas
import 'screens/auth/login_petugas.dart';
import 'screens/report/form_report.dart';
import 'screens/record/record_screen.dart';

// Screens Mahasiswa & Dosen
import 'screens/splash_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/role_selection_screen.dart';
import 'screens/info_screen.dart';
import 'screens/location_permission_screen.dart';
import 'screens/main_screen.dart';
import 'screens/home_screen.dart';
import 'screens/park_view_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ReportProvider()),
          ChangeNotifierProvider(create: (_) => RecordProvider()),
        ],
        child: const FasParkApp(),
      ),
    ),
  );
}


class FasParkApp extends StatelessWidget {
  const FasParkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      debugShowCheckedModeBanner: false,
      title: 'FasPark',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: const Color(0xFFF3EFCB),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash':
            return MaterialPageRoute(builder: (_) => SplashScreen());
          case '/info':
            return MaterialPageRoute(builder: (_) => InfoScreen());
          case '/location':
            return MaterialPageRoute(builder: (_) => LocationPermissionScreen());
          case '/role':
            return MaterialPageRoute(builder: (_) => RoleSelectionScreen());
          case '/login-petugas':
            return MaterialPageRoute(builder: (_) => LoginPetugas());
          case '/main':
            return MaterialPageRoute(builder: (_) => MainScreen());
          case '/profile':
            return MaterialPageRoute(builder: (_) => ProfileScreen());
          case '/record':
            final args = settings.arguments;
            if (args != null) {
              return MaterialPageRoute(builder: (_) => RecordScreen(id: args.toString()));
            }
            return _errorRoute("ID tidak valid");
          default:
            return _errorRoute("Halaman tidak ditemukan");
        }
      }
    );
  }

  MaterialPageRoute _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: Center(child: Text(message)),
      ),
    );
  }
}

