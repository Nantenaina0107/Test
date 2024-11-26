import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class DeclarationService {
  final storage = FlutterSecureStorage();

  Future<List<dynamic>> fetchDeclarations() async {
    final nif = await storage.read(key: 'nif');
    final token = await storage.read(key: 'token');

    final response = await http.get(
      Uri.parse('http://192.168.159.236:3000/api/listesDeclaration?nif=$nif'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception('Erreur lors de la récupération des déclarations');
    }
  }

  Future<void> createDeclaration(int anneFiscal, double chiffreAffaires, double montantInvestissement) async {
    final nif = await storage.read(key: 'nif');
    final token = await storage.read(key: 'token');

    final response = await http.post(
      Uri.parse('http://192.168.159.236:3000/api/declaration'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "nif": nif,
        "anneFiscal": anneFiscal,
        "chiffreAffaires": chiffreAffaires,
        "montantInvestissement": montantInvestissement,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Erreur lors de la création de la déclaration');
    }
  }
  Future<void> cancelDeclaration(int id) async {
    final token = await storage.read(key: 'token');
    
    final response = await http.delete(
      Uri.parse('http://192.168.159.236:3000/api/declaration/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de l\'annulation de la déclaration');
    }
  }

 Future<void> validateDeclaration(int id) async {
  final token = await storage.read(key: 'token');

  final response = await http.put(
    Uri.parse('http://192.168.159.236:3000/api/declaration/$id'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    final data = jsonDecode(response.body);
    print('Message: ${data['message']}');
   
  } else {
    final errorData = jsonDecode(response.body);
    throw Exception(errorData['message'] ?? 'Erreur lors de la validation de la déclaration');
  }
}

Future<void> payDeclaration(BuildContext context, int declarationId) async {
    final token = await storage.read(key: 'token');

    try {
      // 1. Créer l'intention de paiement et obtenir le clientSecret
      final response = await http.post(
        Uri.parse('http://192.168.159.236:3000/api/declaration/$declarationId/creer'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final clientSecret = data['clientSecret'];
        final paymentIntentId = data['paymentIntentId']; // Ajoutez cette ligne
        // 2. Configurer et afficher la modale Stripe
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            style: ThemeMode.light,
            merchantDisplayName: 'Votre Entreprise',
          ),
        );
        await Stripe.instance.presentPaymentSheet();

        // 3. Mise à jour du statut après le paiement
        final updateResponse = await http.put(
          Uri.parse('http://192.168.159.236:3000/api/declaration/$declarationId/confirmer'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
         //erreur body: jsonEncode({'status': 'payé'}),
         body: jsonEncode({'paymentIntentId': paymentIntentId}),
        );

        if (updateResponse.statusCode != 200) {
          // Affichage du corps de la réponse pour déboguer l'erreur
          print('Erreur de mise à jour : ${updateResponse.body}');
          throw Exception('Échec de la mise à jour de la déclaration après le paiement.');
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Paiement réussi et déclaration mise à jour.')),
        );
        Navigator.pop(context, true); 

      } else {
        throw Exception('Erreur lors de la création du paiement');
      }
    } catch (e) {
      // Affichage d'une erreur si le paiement échoue
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du paiement : $e')),
      );
    }
  }
}