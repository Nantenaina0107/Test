import 'package:flutter/material.dart';

class Registrationform extends StatefulWidget {
  const Registrationform({super.key});

  @override
  State<Registrationform> createState() => _RegistrationformState();
}

class _RegistrationformState extends State<Registrationform> {
final _formkey = GlobalKey<FormState>();
int _currentStep = 0;

//Step 1 
String nom = "";
String prenom = "";
String email = "";
String situation = "";
String genre = "";
String cin = "";
String tel = "";
String motpass = "";

//Step 2
String secteur = "";
String description = "";
bool isInvest = false;
String secteurInvest = "";
String decriptionsecteurInvest = "";

//Step 3
String adresse = "";
String fokontany = "";
String commune = "";
String district = "";
String region = "";

// List for marital status options
  List<String> situationoptions = ['Célibataire', 'Marié', 'Divorcé', 'Veuf'];

List<Step> _steps() => [
        Step(
          title: const Text('Informations personnelles'),
          content: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Veuillez entrer un email' : null,
                onChanged: (value) => email = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) => value!.isEmpty ? 'Veuillez entrer votre nom' : null,
                onChanged: (value) => nom = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Prénom'),
                validator: (value) => value!.isEmpty ? 'Veuillez entrer votre prénom' : null,
                onChanged: (value) => prenom = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'CIN (12 chiffres)'),
                keyboardType: TextInputType.number,
                maxLength: 12,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le CIN';
                  } else if (value.length != 12) {
                    return 'Le CIN doit contenir 12 chiffres';
                  }
                  return null;
                },
                onChanged: (value) => cin = value,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Situation matrimoniale'),
                items: situationoptions.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    situation = value!;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Sexe'),
                onChanged: (value) => genre = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Téléphone'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Veuillez entrer votre numéro de téléphone' : null,
                onChanged: (value) => tel = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Veuillez entrer un mot de passe' : null,
                onChanged: (value) => motpass = value,
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
                validator: (value) => value!.isEmpty ? 'Veuillez entrer le secteur actuel' : null,
                onChanged: (value) => secteur = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Veuillez entrer une description' : null,
                onChanged: (value) => description= value,
              ),
              SwitchListTile(
                title: const Text('Investisseur'),
                value: isInvest,
                onChanged: (value) {
                  setState(() {
                    isInvest = value;
                  });
                },
              ),
              if (isInvest) ...[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Secteur d\'investissement'),
                  onChanged: (value) => secteurInvest = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description de l\'investissement'),
                  onChanged: (value) => decriptionsecteurInvest = value,
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
                validator: (value) => value!.isEmpty ? 'Veuillez entrer votre adresse actuelle' : null,
                onChanged: (value) => adresse = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fokontany'),
                onChanged: (value) => fokontany = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Commune'),
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
      appBar: AppBar(title:const Text('Inscription')),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_formkey.currentState!.validate()) {
            if (_currentStep < _steps().length - 1) {
              setState(() {
                _currentStep++;
              });
            } else {
              // Soumettre le formulaire
              print('Email: $email');
              print('Nom: $nom');
              print('Prénom: $prenom');
              print('Situation matrimoniale: $situation');
              print('Sexe: $genre');
              print('CIN: $cin');
              print('Téléphone: $tel');
              print('Mot de passe: $motpass');
              print('Secteur actuel: $secteur');
              print('Description d\'activité: $description');
              print('Investisseur: $isInvest');
              print('Secteur d\'investissement: $secteurInvest');
              print('Description d\'investissement: $decriptionsecteurInvest');
              print('Adresse actuelle: $adresse');
              print('Fokontany: $fokontany');
              print('Commune: $commune');
              print('District: $district');
              print('Région: $region');
            }
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
}