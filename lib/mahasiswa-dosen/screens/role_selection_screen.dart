import 'package:flutter/material.dart';
import 'package:sistem_parkir/mahasiswa-dosen/screens/main_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  void _selectRole(BuildContext context,String role) {
    // Mengarahkan ke halaman sesuai role
    if (role == 'User') {
      Navigator.pushReplacement(context, 
      MaterialPageRoute(
        builder: (_) => MainScreen(username: 'User')));
    } 
    // DIBUAT SAMA ANGGITA
    // else if (role == 'Petugas') {
    //   Navigator.pushReplacementNamed(context, 'role_selection_screen');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1D16A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_alt_sharp, size: 100,),
            Text("Who are u?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _selectRole(context, 'User'),
              child: Text("Dosen, Tendik, Mahasiswa"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectRole(context, 'Petugas'),
              child: Text("Petugas Parkir"),
            ),
          ],
        ),
      ),
    );
  }
}