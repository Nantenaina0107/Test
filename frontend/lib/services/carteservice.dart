import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cartefiscal.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String baseUrl = 'http://192.168.159.236:3000/api/cartesFiscales'; // Remplacez par votre URL API
  final storage = FlutterSecureStorage();

  Future<List<CarteFiscale>> fetchCartesFiscales() async {
    final nif = await storage.read(key: 'nif');
    final token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl?nif=$nif'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => CarteFiscale.fromJson(data)).toList();
    } else {
      throw Exception('Erreur lors de la récupération des cartes fiscales');
    }
  }
}
