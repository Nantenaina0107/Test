import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PageDetailsDeclaration extends StatefulWidget {
  final String declarationId;

  PageDetailsDeclaration({required this.declarationId});

  @override
  _PageDetailsDeclarationState createState() => _PageDetailsDeclarationState();
}

class _PageDetailsDeclarationState extends State<PageDetailsDeclaration> {
  late Map<String, dynamic> declaration;

  @override
  void initState() {
    super.initState();
    _getDeclarationDetails();
  }

  Future<void> _getDeclarationDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('http://<ton_backend_url>/api/declarations/${widget.declarationId}'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      setState(() {
        declaration = json.decode(response.body);
      });
    } else {
      print('Erreur lors de la récupération des détails : ${response.body}');
    }
  }

  Future<void> _annulerDeclaration() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse('http://<ton_backend_url>/api/declarations/${widget.declarationId}'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      Navigator.pop(context); // Retourne à la page précédente
    } else {
      print('Erreur lors de l\'annulation de la déclaration : ${response.body}');
    }
  }

  Future<void> _validerEtPayer() async {
    final montant = declaration['montantInvestissement']; // Récupère le montant d'investissement

    // Rediriger vers Stripe avec le montant
    final response = await http.post(
      Uri.parse('http://<ton_backend_url>/api/payments'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'montant': montant,
        'declarationId': declaration['id'],
      }),
    );

    if (response.statusCode == 200) {
     // final paymentUrl = json.decode(response.body)['url'];
      // Ouvrir le lien de paiement Stripe
      // Cela peut nécessiter l'utilisation d'un navigateur ou d'un WebView
      //launch(paymentUrl);
    } else {
      print('Erreur lors de la validation et du paiement : ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détails de la Déclaration')),
      body: declaration == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('ID Déclaration: ${declaration['id']}'),
                  Text('Montant d\'Investissement: ${declaration['montantInvestissement']}'),
                  Text('Statut: ${declaration['statut']}'),
                  const SizedBox(height: 20),
                  if (declaration['statut'] == 'soumis')
                    ElevatedButton(
                      onPressed: _annulerDeclaration,
                      child: const Text('Annuler la Déclaration'),
                    ),
                  if (declaration['statut'] == 'non payé' || declaration['statut'] == 'soumis')
                    ElevatedButton(
                      onPressed: _validerEtPayer,
                      child: const Text('Valider et Payer'),
                    ),
                ],
              ),
            ),
    );
  }
}
