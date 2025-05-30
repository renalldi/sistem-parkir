import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = 'https://localhost:7211'; // Sesuaikan backendmu

  // Register
  static Future<Map<String, dynamic>> register(String username, String password, String role) async {
    final url = Uri.parse('$baseUrl/api/user/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'role': role,
        }),
      );

        // DEBUGGING
      print('UserService Login Status Code: ${response.statusCode}');
      print('Login Response Headers: ${response.headers}');
      print('UserService Login Response Body: ${response.body}');

      if (response.statusCode == 307) { // Secara eksplisit tangani 307
        String? newLocation = response.headers['location']; // atau 'Location' (case-insensitive)
        print('Server mengarahkan ke: $newLocation');
        return {
          'success': false,
          'message': 'Server meminta redirect ke $newLocation (Status: 307). Perlu penyesuaian URL atau server.',
        };
      }
      if (response.body.isEmpty) {
        return {
          'success': false,
          'message': 'Error: Respons dari server kosong (Status: ${response.statusCode})',
        };
      }

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'Registrasi sukses',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Registrasi gagal',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  // Login
  static Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/api/user/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'user': data['user'], // misal user info { id, username, role }
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Login gagal',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  // update profil
  static Future<Map<String, dynamic>> updateProfile(String id, String username, String password) async {
    try {
      final url = Uri.parse('$baseUrl/api/user/update-profile/$id');
      final body = <String, dynamic>{
        'username': username,
      };

      if (password.isNotEmpty) {
        body['password'] = password;
      }
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          if (password.isNotEmpty) 'password': password,
        }),
      );

      if (response.body.isEmpty) {
        return {
          'success': false,
          'message': 'Respons kosong dari server (status ${response.statusCode})',
        };
      }

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {'success': true, 'message': data['message'] ?? 'Berhasil'};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Gagal update'};
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan jaringan: $e',
      };
    }
  }

  // hapus profil
  // static Future<Map<String, dynamic>> deleteUser(String id) async {
  //   final url = Uri.parse('$baseUrl/api/user/$id');
  //   final response = await http.delete(url);

  //   final data = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     return {'success': true, 'message': data['message']};
  //   } else {
  //     return {'success': false, 'message': data['message'] ?? 'Gagal hapus akun'};
  //   }
  // }

}
