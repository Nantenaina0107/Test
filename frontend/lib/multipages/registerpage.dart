import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ApiService _apiService = ApiService();
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Champs de l'utilisateur
  String _email = '';
  String _nom = '';
  String _prenom = '';
  int _cin = 0;
  String _sexe = '';
  String _situation = '';
  String _password = '';
  String _tel = '';
  String _datenaiss = '';
  String _lieunaiss = '';

  // Champs d'activité
  List<Activite> _activites = [
    Activite(secteur: '', description: '', isInvestisseur: false, secteurInv: '')
  ];

  // Champs de siège
  List<Siege> _sieges = [
    Siege(adresse: '', fokontany: '', commune: '', region: '')
  ];

  // Méthode pour afficher le message de succès ou d'erreur
  void _showMessage(String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(isSuccess ? Icons.check_circle : Icons.error,
                  color: isSuccess ? Colors.green : Colors.red),
              SizedBox(width: 8),
              Text(isSuccess ? 'Succès' : 'Erreur'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isSuccess) {
                  Navigator.of(context).pop(); // Retourne à la page précédente si inscription réussie
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Méthode d'inscription avec affichage de message de confirmation
  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      User user = User(
        email: _email,
        nom: _nom,
        prenom: _prenom,
        cin: _cin,
        sexe: _sexe,
        situation: _situation,
        password: _password,
        tel: _tel,
        datenaiss: _datenaiss,
        lieunaiss: _lieunaiss,
        activites: _activites,
        sieges: _sieges,
      );

      bool success = await _apiService.register(user);
      if (success) {
        _showMessage(
            'Inscription réussie ! Votre NIF a été envoyé à votre adresse email.',
            true);
      } else {
        _showMessage('Erreur lors de l\'inscription. Veuillez réessayer.', false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inscription')),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() => _currentStep += 1);
            } else {
              _register();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep -= 1);
            }
          },
          steps: [
            Step(
              title: Text('Détails Personnels'),
              content: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    onSaved: (value) => _email = value!,
                    validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nom'),
                    onSaved: (value) => _nom = value!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Prénom'),
                    onSaved: (value) => _prenom = value!,
                  ),
                  // Ajoute les autres champs de détails personnels ici
                ],
              ),
            ),
            Step(
              title: Text('Activités'),
              content: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Secteur'),
                    onSaved: (value) => _activites[0].secteur = value!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description'),
                    onSaved: (value) => _activites[0].description = value!,
                  ),
                  // Ajoute d’autres champs d’activité si nécessaire
                ],
              ),
            ),
            Step(
              title: Text('Siège'),
              content: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Adresse'),
                    onSaved: (value) => _sieges[0].adresse = value!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Fokontany'),
                    onSaved: (value) => _sieges[0].fokontany = value!,
                  ),
                  // Ajoute les autres champs de siège ici
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
