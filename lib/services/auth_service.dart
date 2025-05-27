import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://localhost:7211';


  static Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/api/Auth/login');

    // lowercase login

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

        // DEBUGGING
      print('AuthService Login Status Code: ${response.statusCode}');
      print('Login Response Headers: ${response.headers}');
      print('AuthService Login Response Body: ${response.body}');

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
          'token': data['token'], // kalau response token-nya ini
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
}
