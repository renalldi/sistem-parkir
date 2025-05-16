import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final LatLng lokasifasilkom = const LatLng(-8.165942440434762, 113.71687656035348);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Hi, Mina!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Need to find a spot at Fasilkom?"),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey[700]),
                SizedBox(height: 8),
                Expanded(
                  child: Text(
                    "Fakultas Ilmu Komputer",
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ),
                Icon(Icons.settings, color: Colors.grey[700]),
              ],
            ),
          ),
        ),
        Expanded(
          child: FlutterMap(
            mapController: MapController(),
            options: MapOptions(
              initialCenter: lokasifasilkom,
              initialZoom: 17.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                userAgentPackageName: 'com.mahasiswa_dosen.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: lokasifasilkom,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// Expanded(
            //   child: GoogleMap(
            //     initialCameraPosition: CameraPosition(
            //       target: lokasifasilkom, 
            //       zoom: 17,
            //     ),
            //     markers: {
            //       Marker(
            //         markerId: MarkerId('fasilkom'),
            //         position: lokasifasilkom,
            //         infoWindow: InfoWindow(title: "Fakultas Ilmu Komputer"),
            //       ),
            //     },
            //   ),
            // ),