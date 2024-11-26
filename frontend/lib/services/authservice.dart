import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secure_storage_service.dart';

class AuthService {
  final SecureStorageService _secureStorageService = SecureStorageService();

  Future<String?> login(String nif, String password) async {
    final response = await http.post(
      Uri.parse('http://votre_api_url/api/login'), // Remplacez par votre URL d'API
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'nif': nif, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      // Enregistrer le token dans SecureStorageService
      await _secureStorageService.saveToken(token);
      // Vérifier si le token a été bien stocké
      await testToken();
      return token;
    } else {
      print("Échec de la connexion");
      return null; // Connexion échouée
    }
  }

  Future<void> logout() async {
    await _secureStorageService.deleteToken();
  }
  /// Test pour vérifier si le token est bien stocké
  Future<void> testToken() async {
    final token = await _secureStorageService.getToken();
    print('Token récupéré : $token');
  }
}
