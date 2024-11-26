import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthentificationService {
  final String _baseUrl = 'http://192.168.159.236:3000/api/users/login';
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Méthode pour enregistrer le token dans le stockage sécurisé
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  // Méthode pour récupérer le token
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }

  // Méthode pour supprimer le token (déconnexion)
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'token');
  }

  // Méthode de connexion
Future<String> login(String nif, String password) async {
  final response = await http.post(
    Uri.parse(_baseUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'nif': int.parse(nif),  // Assurez-vous que le NIF est un entier
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final token = data['token'];
    await saveToken(token);  // Stocke le token en toute sécurité
    return data['message'] ?? 'Connexion réussie';  // Retourne le message de succès
  } else if (response.statusCode == 201) {
    // Si le code 201 est utilisé, traitez-le ici
    final data = jsonDecode(response.body);
    return data['message'] ?? 'Utilisateur créé avec succès, veuillez vous connecter.'; // Fournir un message par défaut
  } else {
    // Gérer les erreurs
    final data = jsonDecode(response.body);
    String errorMessage;
    
    // Vérifiez le message d'erreur dans la réponse
    if (data.containsKey('error')) {
      errorMessage = data['error'];  // Récupérez le message d'erreur si disponible
    } else {
      errorMessage = 'Erreur lors de la connexion : ${response.statusCode}';
    }
    
    // Vérifiez si c'est un mot de passe incorrect
    if (response.statusCode == 400) {
      errorMessage = 'Mot de passe incorrect. Veuillez réessayer.';  // Message spécifique pour mot de passe incorrect
    }

    throw Exception(errorMessage);
  }
}

}
