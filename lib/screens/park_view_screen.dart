import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// ganti ke false = production/pakai di hp, ganti ke true = development/pakai di web
const bool isDevMode = true;

class ParkViewScreen extends StatefulWidget {
  const ParkViewScreen({super.key});

  @override
  State<ParkViewScreen> createState() => _ParkViewScreenState();
}

class _ParkViewScreenState extends State<ParkViewScreen> {
  double studentLeft = 30;
  double studentTop = 55;
  double studentMiddle = 85;
  double lecturer = 95;

  String? userParkedAt; // Menyimpan nama tempat parkir yang dipakai user

  String getStatus(double percent) {
    if (percent > 90) return 'Penuh';
    if (percent > 50) return 'Hampir Penuh';
    return 'Parkir Tersedia';
  }

  // Mengecek user berada di area Fasilkom
  Future<bool> isInsideFasilkomArea() async {
    if (isDevMode) return true;

    Position position = await Geolocator.getCurrentPosition();
    double lat = position.latitude;
    double lon = position.longitude;

    // Koordinat sekitar Fasilkom UI
    const double fasilkomLat = -6.3628;
    const double fasilkomLon = 106.8246;
    const double maxDistanceInMeters = 100;

    double distance = Geolocator.distanceBetween(lat, lon, fasilkomLat, fasilkomLon);
    return distance <= maxDistanceInMeters;
  }

  Color getColorDashboard(double percent) {
    if (percent > 90) return Colors.red;
    if (percent > 50) return Colors.orange;
    return Colors.green;
  }

  Color getColor(String name, double percent) {
    if (userParkedAt == name) return Colors.blue; // denah only
    if (percent > 90) return Colors.red;
    if (percent > 50) return Colors.orange;
    return Colors.green;
  }

  void handleTap(String name) async {
    if (userParkedAt == name) {
      // Sudah parkir di sini, konfirmasi keluar
      final keluar = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text("Mau keluar dari parkiran ini?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Tidak")),
            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Iya")),
          ],
        ),
      );

      if (keluar == true) {
        setState(() => userParkedAt = null);
      }
    } else {
      // Belum parkir di sini, konfirmasi parkir
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Konfirmasi"),
          content: Text("Parkir di $name?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Tidak")),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Tutup dialog dulu
                bool isAllowed = await isInsideFasilkomArea();
                if (isAllowed) {
                  setState(() => userParkedAt = name);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Kamu tidak berada di area Fasilkom!")),
                  );
                }
              },
              child: const Text("Iya"),
            ),
          ],
        ),
      );
    }
  }

  Widget parkingBlock({
    required String name,
    required double percent,
    required Widget child,
  }) {
    return Material(
      color: getColor(name, percent),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () => handleTap(name),
        borderRadius: BorderRadius.circular(8),
        child: Center(child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1D6),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text("Denah Parkir Fasilkom", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            const Text("3 Tempat Parkir Mahasiswa & 1 Tempat Parkir Dosen", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),

            // DASHBOARD RINGKAS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildParkingCard("Mahasiswa 1", studentLeft),
                  buildParkingCard("Mahasiswa 2", studentTop),
                  buildParkingCard("Mahasiswa 3", studentMiddle),
                  buildParkingCard("Dosen", lecturer),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // DENAH PARKIR
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
                        child: SizedBox(
                          height: 30,
                          child: parkingBlock(
                            name: "Mahasiswa 2",
                            percent: studentTop,
                            child: const Text("Mahasiswa 2", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),

                      // Student Parking Left
                      Positioned(
                        left: 10,
                        top: 80,
                        bottom: 20,
                        width: 80,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: parkingBlock(
                            name: "Mahasiswa 1",
                            percent: studentLeft,
                            child: const Text("Mahasiswa 1", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),

                      // Student Parking Tengah
                      Positioned(
                        right: 75,
                        top: 110,
                        width: 80,
                        height: 130,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: parkingBlock(
                            name: "Mahasiswa 3",
                            percent: studentMiddle,
                            child: const Text("Mahasiswa 3", style: TextStyle(color: Colors.white, fontSize: 10)),
                          ),
                        ),
                      ),

                      // Lecturer Parking
                      Positioned(
                        right: 10,
                        top: 100,
                        width: 50,
                        height: 300,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: parkingBlock(
                            name: "Dosen & Staff",
                            percent: lecturer,
                            child: const Text("Dosen & Staff", style: TextStyle(color: Colors.white, fontSize: 10)),
                          ),
                        ),
                      ),
                      // Security Post
                      const Positioned(
                        right: 80,
                        bottom: 10,
                        child: Text("SECURITY POST", style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ),
                      // Lingkaran
                      const Positioned(
                        top: 60,
                        left: 145,
                        child: CircleAvatar(radius: 15, backgroundColor: Colors.grey),
                      ),
                      // Pintu Masuk
                      const Positioned(
                        right: 5,
                        top: 40,
                        child: const RotatedBox(
                          quarterTurns: 3,
                          child: Center(
                            child: Text("ENTRANCE", style: TextStyle(fontSize: 10, color: Colors.grey)),
                          ),
                        ),
                      ),
                      // Genset
                      const Positioned(
                        right: 100,
                        bottom: 135,
                        child: Text("GENSET", style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (userParkedAt != null)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text("Anda parkir di $userParkedAt", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildParkingCard(String title, double percent) {
    return SizedBox(
      width: 90,
      height: 90,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: getColorDashboard(percent),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text("${percent.toInt()}%", style: const TextStyle(color: Colors.white)),
            Text(
              getStatus(percent),
              style: const TextStyle(color: Colors.white, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
