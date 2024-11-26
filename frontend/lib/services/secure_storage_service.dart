import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Méthode pour enregistrer le token
  Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: 'token', value: token);
    } catch (e) {
      print("Erreur lors de l'enregistrement du token : $e");
    }
  }

  /// Méthode pour récupérer le token
  Future<String?> getToken() async {
    try {
      return await _storage.read(key: 'token');
    } catch (e) {
      print("Erreur lors de la récupération du token : $e");
      return null;
    }
  }

  /// Méthode pour supprimer le token
  Future<void> deleteToken() async {
    try {
      await _storage.delete(key: 'token');
    } catch (e) {
      print("Erreur lors de la suppression du token : $e");
    }
  }
}
