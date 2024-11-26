import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PageDeclaration extends StatefulWidget {
  const PageDeclaration({super.key});
  @override
  _PageDeclarationState createState() => _PageDeclarationState();
}

class _PageDeclarationState extends State<PageDeclaration> {
  String _nif = '';
  String _secteur = '';
  bool _isInvestisseur = false;
  double _montantInvestissement = 0.0;
  double _chiffreAffaire = 0.0;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://<ton_backend_url>/api/user/details'), // URL de l'API pour récupérer les détails de l'utilisateur
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _nif = data['nif'];
          _secteur = data['activite']['secteur'];
          _isInvestisseur = data['activite']['isInvestisseur'];
        });
      }
    }
  }

  double _calculerImpot(double chiffreAffaire) {
    // Ici, tu peux ajouter ta logique pour calculer l'impôt
    return _chiffreAffaire * 0.15; // Exemple : 15% du chiffre d'affaires
  }

  Future<void> _soumettreDeclaration() async {
    // Calculer l'impôt avant de soumettre
    double _impot = _calculerImpot(_chiffreAffaire);
    final response = await http.post(
      Uri.parse('http://<ton_backend_url>/api/declarations'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nif': _nif,
        'montantInvestissement': _montantInvestissement,
        'chiffreAffaire': _chiffreAffaire,
        'statut': 'soumis', // Statut initial
      }),
    );

    if (response.statusCode == 201) {
      // Traitement réussi, redirection vers les détails de la déclaration
      Navigator.pushNamed(context, '/detailsDeclaration');
    } else {
      // Gérer les erreurs
      print('Erreur lors de la soumission : ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Déclaration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Secteur : $_secteur'),
            if (_isInvestisseur) ...[
              TextField(
                decoration: const InputDecoration(labelText: 'Montant d\'investissement'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _montantInvestissement = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
            ],
            TextField(
              decoration: const InputDecoration(labelText: 'Chiffre d\'affaire'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _chiffreAffaire = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _soumettreDeclaration,
              child: const Text('Soumettre la déclaration'),
            ),
          ],
        ),
      ),
    );
  }
}
