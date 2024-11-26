// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  final String _baseUrl = 'http://192.168.159.236:3000/api/users';

  Future<bool> register(User user) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    return response.statusCode == 201;
  }
}
