import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PaiementService {
  final storage = FlutterSecureStorage();

  Future<List<dynamic>> fetchHistorique() async {
    final nif = await storage.read(key: 'nif');
    final token = await storage.read(key: 'token');

    final response = await http.get(
      Uri.parse('http://192.168.159.236:3000/api/historique?nif=$nif'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception("Erreur lors de la récupération de l'Historiqu");
    }
  }
}