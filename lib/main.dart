import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'package:sistem_parkir/screens/auth/login_user_screen.dart';
import 'package:sistem_parkir/screens/auth/register_user_screen.dart';

// Import Providers
import 'providers/report_provider.dart';
import 'providers/record_provider.dart';
import 'providers/auth_provider.dart';

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
import 'screens/edit_profile_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ReportProvider()),
          ChangeNotifierProvider(create: (_) => RecordProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
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
          case '/profile-user':
            return MaterialPageRoute(builder: (_) => ProfileScreen());
          case '/register-user':
            return MaterialPageRoute(builder: (_) => RegisterUserScreen());
          case '/login-user':
            return MaterialPageRoute(builder: (_) => LoginUserScreen());
          case '/edit-profile':
            return MaterialPageRoute(builder: (_) => EditProfileScreen());
          case '/form':
            return MaterialPageRoute(builder: (_) => FormReportPage());
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
