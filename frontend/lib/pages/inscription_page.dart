import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageInscription(),
    );
  }
}

class PageInscription extends StatefulWidget {
  @override
  _PageInscriptionState createState() => _PageInscriptionState();
}

class _PageInscriptionState extends State<PageInscription> {
  //final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // Form data
  String email = '';
  String name = '';
  String surname = '';
  String maritalStatus = '';
  String gender = '';
  String cin = '';
  String phone = '';
  String password = '';
  String birthPlace = '';
  DateTime? dateOfBirth;

  // Step 2: Activités
  String currentSector = '';
  String investmentDescription = '';
  bool isInvestor = false;
  String investmentSector = '';
  String activityDescription = '';

  // Step 3: Adresse
  String currentAddress = '';
  String fokontany = '';
  String commune = '';
  String district = '';
  String region = '';

  List<String> maritalStatusOptions = ['Célibataire', 'Marié', 'Divorcé', 'Veuf'];

  List<Step> _steps() => [
        Step(
          title: const Text('Informations personnelles'),
          content: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) => email = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nom'),
                onChanged: (value) => name = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Prénom'),
                onChanged: (value) => surname = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Lieu de naissance'),
                onChanged: (value) => birthPlace = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Date de naissance'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: dateOfBirth ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      dateOfBirth = pickedDate;
                    });
                  }
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Situation matrimoniale'),
                items: maritalStatusOptions.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    maritalStatus = value!;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Sexe'),
                onChanged: (value) => gender = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'CIN (12 chiffres)'),
                keyboardType: TextInputType.number,
                maxLength: 12,
                onChanged: (value) => cin = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Téléphone'),
                keyboardType: TextInputType.phone,
                onChanged: (value) => phone = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                onChanged: (value) => password = value,
              ),
            ],
          ),
        ),
        Step(
          title: const Text('Activités'),
          content: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Secteur actuel'),
                onChanged: (value) => currentSector = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) => activityDescription = value,
              ),
              SwitchListTile(
                title: const Text('Investisseur'),
                value: isInvestor,
                onChanged: (value) {
                  setState(() {
                    isInvestor = value;
                  });
                },
              ),
              if (isInvestor) ...[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Secteur d\'investissement'),
                  onChanged: (value) => investmentSector = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description de l\'investissement'),
                  onChanged: (value) => investmentDescription = value,
                ),
              ],
            ],
          ),
        ),
        Step(
          title: const Text('Adresse actuelle'),
          content: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Adresse actuelle'),
                onChanged: (value) => currentAddress = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fokontany'),
                onChanged: (value) => fokontany = value,
              ),
              TextFormField(
                decoration:const InputDecoration(labelText: 'Commune'),
                onChanged: (value) => commune = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'District'),
                onChanged: (value) => district = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Région'),
                onChanged: (value) => region = value,
              ),
            ],
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulaire d\'Inscription')),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < _steps().length - 1) {
            setState(() {
              _currentStep++;
            });
          } else {
            // Envoyer les données au backend
            _submitForm();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
        steps: _steps(),
      ),
    );
  }

  void _submitForm() async {
    // Créez un objet de données d'inscription
    final Map<String, dynamic> data = {
      'email': email,
      'name': name,
      'surname': surname,
      'birthPlace': birthPlace,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'maritalStatus': maritalStatus,
      'gender': gender,
      'cin': cin,
      'phone': phone,
      'password': password,
      'currentSector': currentSector,
      'activityDescription': activityDescription,
      'isInvestor': isInvestor,
      'investmentSector': investmentSector,
      'investmentDescription': investmentDescription,
      'currentAddress': currentAddress,
      'fokontany': fokontany,
      'commune': commune,
      'district': district,
      'region': region,
    };

    // Envoie la requête au backend
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/register'), // Remplacez par l'URL de votre backend
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      // Gérer le succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Inscription réussie!')),
      );
    } else {
      // Gérer l'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur d\'inscription!')),
      );
    }
  }
}
