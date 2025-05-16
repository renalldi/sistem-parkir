import 'package:flutter/material.dart';

class ParkViewScreen extends StatelessWidget {
  const ParkViewScreen({super.key});

  String getStatus(double percent) {
    if (percent > 90) return 'Penuh';
    if (percent > 50) return 'Hampir Penuh';
    return 'Parkir Tersedia';
  }

  Color getColor(double percent) {
    if (percent > 90) return Colors.red;
    if (percent > 50) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    double studentLeft = 30;
    double studentTop = 55;
    double studentMiddle = 85;
    double lecturer = 95;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F1D6),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text("View Spot", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            const Text("Total 60% Available", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      // Student Parking Top
                      Positioned(
                        top: 10,
                        left: 60,
                        right: 60,
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: getColor(studentTop),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text("Student Parking", style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text("${studentTop.toInt()}%\n${getStatus(studentTop)}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 10)),
                          ],
                        ),
                      ),
                      // Student Parking Left (besar)
                      Positioned(
                        left: 10,
                        top: 80,
                        bottom: 20,
                        width: 80,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: getColor(studentLeft),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const RotatedBox(
                                  quarterTurns: 3,
                                  child: Center(
                                    child: Text("Student Parking", style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text("${studentLeft.toInt()}%\n${getStatus(studentLeft)}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 10)),
                          ],
                        ),
                      ),

                      // Student Parking Tengah (kecil)
                      Positioned(
                        right: 75,
                        top: 110,
                        width: 80,
                        height: 130,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: getColor(studentMiddle),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const RotatedBox(
                                  quarterTurns: 3,
                                  child: Center(
                                    child: Text("Student Parking", style: TextStyle(color: Colors.white, fontSize: 10)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text("${studentMiddle.toInt()}%\n${getStatus(studentMiddle)}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 10)),
                          ],
                        ),
                      ),

                      // Lecturer Parking
                      Positioned(
                        right: 10,
                        top: 100,
                        width: 50,
                        height: 300,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: getColor(lecturer),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const RotatedBox(
                                  quarterTurns: 3,
                                  child: Center(
                                    child: Text("Lecturer & Staff", style: TextStyle(color: Colors.white, fontSize: 10)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text("${lecturer.toInt()}%\n${getStatus(lecturer)}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 10)),
                          ],
                        ),
                      ),

                      // Security Post
                      const Positioned(
                        right: 10,
                        bottom: 10,
                        child: Text("SECURITY POST", style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ),

                      // Lingkaran
                      const Positioned(
                        top: 85,
                        left: 145,
                        child: CircleAvatar(radius: 8, backgroundColor: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
