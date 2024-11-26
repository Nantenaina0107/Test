import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PageInscription extends StatefulWidget {
  const PageInscription({super.key});
  @override
  _PageInscriptionState createState() => _PageInscriptionState();
}

class _PageInscriptionState extends State<PageInscription> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Informations personnelles
  String email = '';
  String nom = '';
  String password = '';

  // Activité (secteur unique avec investisseur optionnel)
  Map<String, dynamic> activite = {
    'secteur': '',
    'description': '',
    'isInvestisseur': false,
    'secteurInv': '',
    'descInv': ''
  };

  // Siège (adresse actuelle, fokontany, district, région)
  Map<String, dynamic> siege = {
    'adresse': '',
    'fokontany': '',
    'district': '',
    'region': ''
  };

  Future<void> _register() async {
    final url = Uri.parse('http://localhost:3000/api/register'); // API Node.js
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'nom': nom,
        'password': password,
        'activite': activite,  // Champ activité en JSON
        'siege': siege,        // Champ siège en JSON
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Inscription réussie : ${data['token']}');
    } else {
      print('Erreur : ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscription en étapes')),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() {
                _currentStep++;
              });
            } else if (_formKey.currentState!.validate()) {
              _register();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep--;
              });
            }
          },
          steps: [
            // Etape 1 : Informations personnelles
            Step(
              title: const Text('Informations personnelles'),
              content: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    onChanged: (value) => email = value,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer un email' : null,
                  ),
                  TextFormField(
                    decoration:const InputDecoration(labelText: 'Nom'),
                    onChanged: (value) => nom = value,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer un nom' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Mot de passe'),
                    obscureText: true,
                    onChanged: (value) => password = value,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer un mot de passe' : null,
                  ),
                ],
              ),
              isActive: _currentStep >= 0,
            ),
            // Etape 2 : Activité
            Step(
              title: const Text('Activité'),
              content: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Secteur'),
                    onChanged: (value) => activite['secteur'] = value,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer un secteur' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Description'),
                    onChanged: (value) => activite['description'] = value,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer une description' : null,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Investisseur'),
                      Switch(
                        value: activite['isInvestisseur'],
                        onChanged: (value) {
                          setState(() {
                            activite['isInvestisseur'] = value;
                          });
                        },
                      ),
                    ],
                  ),
                  if (activite['isInvestisseur']) ...[
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Secteur d\'investissement'),
                      onChanged: (value) => activite['secteurInv'] = value,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Description de l\'investissement'),
                      onChanged: (value) => activite['descInv'] = value,
                    ),
                  ],
                ],
              ),
              isActive: _currentStep >= 1,
            ),
            // Etape 3 : Siège (adresse actuelle, fokontany, district, région)
            Step(
              title: const Text('Siège'),
              content: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Adresse actuelle'),
                    onChanged: (value) => siege['adresse'] = value,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer une adresse' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Fokontany'),
                    onChanged: (value) => siege['fokontany'] = value,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer un fokontany' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'District'),
                    onChanged: (value) => siege['district'] = value,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer un district' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Région'),
                    onChanged: (value) => siege['region'] = value,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer une région' : null,
                  ),
                ],
              ),
              isActive: _currentStep >= 2,
            ),
          ],
        ),
      ),
    );
  }
}
