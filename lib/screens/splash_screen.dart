import 'package:flutter/material.dart';
import 'dart:async';
import 'info_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => InfoScreen()),
      );
    });
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1d16a),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('FasPark', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            Text('Fasilkom Smart Parking', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}