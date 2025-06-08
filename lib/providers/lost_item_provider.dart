import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/lost_item_model.dart';

class LostItemService {
  static const String baseUrl = 'https://localhost:7211';

  static Future<bool> submitLostItemReport(LostItemReport report, String token) async {
    final url = Uri.parse('$baseUrl/api/LostItemReports');

    var request = http.MultipartRequest('POST', url);

    // Header Authorization JWT
    request.headers['Authorization'] = 'Bearer $token';

    // Tambah field data
    request.fields.addAll(report.toJson());

    // Upload foto jika ada
    if (report.foto != null) {
      request.files.add(
        await http.MultipartFile.fromPath('foto', report.foto!.path),
      );
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        print("✅ Berhasil kirim laporan kehilangan.");
        return true;
      } else {
        print("❌ Gagal kirim laporan: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("🔥 Error saat mengirim laporan: $e");
      return false;
    }
  }

  // ✅ Method untuk digunakan di UI/Provider
  Future<bool> submitLostItem({
    required String nama,
    required String noHp,
    String? deskripsi,
    required String jenisBarang,
    required String area,
    File? image,
    required String token,
  }) async {
    final report = LostItemReport(
      namaPelapor: nama,
      noHpPelapor: noHp,
      deskripsi: deskripsi,
      jenisBarang: jenisBarang,
      area: area,
      foto: image,
    );

    return await submitLostItemReport(report, token);
  }
}
