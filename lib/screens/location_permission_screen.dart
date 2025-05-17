import 'package:flutter/material.dart';
import 'role_selection_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionScreen extends StatelessWidget {
  Future<void> _requestLocation(BuildContext context) async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      Navigator.pushReplacementNamed(context, '/role');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Izin Lokasi diperlukan untuk lanjut ke halaman selanjutnya')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1D16A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 100, color: Colors.red),
            Text("Where do you wanna park", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _requestLocation(context),
              child: Text('Enable Location'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/role');
              },
              child: Text('Not Now'),
            )
          ],
        ),
      ),
    );
  }
}