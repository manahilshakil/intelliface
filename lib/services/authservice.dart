import 'dart:convert'; 
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'https://intelliface-production.up.railway.app/login';

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final url = Uri.parse(baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final accessToken = responseData['access'];

        // Decode JWT payload (middle part of token)
        final parts = accessToken.split('.');
        if (parts.length != 3) {
          return {
            'success': false,
            'message': 'Invalid access token format',
          };
        }

        final payload = utf8.decode(base64Url.normalize(parts[1]) == null
            ? base64.decode(parts[1])
            : base64Url.decode(base64Url.normalize(parts[1])));

        final payloadMap = jsonDecode(payload);

        // Print whether isTeacher is true or false
        print('isTeacher: ${payloadMap['is_teacher']}');
        print('Decoded JWT payload: $payloadMap');

        if (payloadMap['is_teacher'] == false) {
          return {
            'success': false,
            'message': 'Student accounts are not allowed to log in here.',
          };
        }

        return {
          'success': true,
          'data': responseData,
        };
      } else {
        return {
          'success': false,
          'message': jsonDecode(response.body)['detail'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: $e',
      };
    }
  }
}
