import 'package:flutter/material.dart';


class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // Champs pour chaque étape
  String _name = '';
  String _email = '';
  String _cin = '';
  String _activity = '';
  String _description = '';
  String _address = '';
  String _fokontany = '';
  String _region = '';
  String _district = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire d\'Inscription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                _getStepTitle(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Expanded(child: _buildStepContent()),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep > 0)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentStep--;
                        });
                      },
                      child: Text('Précédent'),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentStep < 2) {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          setState(() {
                            _currentStep++;
                          });
                        }
                      } else {
                        // Logique de soumission des données
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Inscription réussie !')),
                          );
                        }
                      }
                    },
                    child: Text(_currentStep < 2 ? 'Suivant' : 'Soumettre'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fonction pour obtenir le titre de l'étape actuelle
  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Informations Personnelles';
      case 1:
        return 'Activités';
      case 2:
        return 'Siège';
      default:
        return '';
    }
  }

  // Contenu de l'étape actuelle
  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildPersonalInfoStep();
      case 1:
        return _buildActivityStep();
      case 2:
        return _buildHeadquartersStep();
      default:
        return Container();
    }
  }

  // Étape 1 : Informations personnelles
  Widget _buildPersonalInfoStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Nom'),
          onSaved: (value) => _name = value!,
          validator: (value) {
            if (value!.isEmpty) return 'Veuillez entrer votre nom';
            return null;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) => _email = value!,
          validator: (value) {
            if (value!.isEmpty) return 'Veuillez entrer votre email';
            return null;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'CIN'),
          keyboardType: TextInputType.number,
          onSaved: (value) => _cin = value!,
          validator: (value) {
            if (value!.isEmpty) return 'Veuillez entrer votre CIN';
            return null;
          },
        ),
      ],
    );
  }

  // Étape 2 : Activités
  Widget _buildActivityStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Activité'),
          onSaved: (value) => _activity = value!,
          validator: (value) {
            if (value!.isEmpty) return 'Veuillez entrer l\'activité';
            return null;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Description de l\'activité'),
          onSaved: (value) => _description = value!,
          validator: (value) {
            if (value!.isEmpty) return 'Veuillez entrer la description';
            return null;
          },
        ),
      ],
    );
  }

  // Étape 3 : Siège
  Widget _buildHeadquartersStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Adresse'),
          onSaved: (value) => _address = value!,
          validator: (value) {
            if (value!.isEmpty) return 'Veuillez entrer l\'adresse';
            return null;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Fokontany'),
          onSaved: (value) => _fokontany = value!,
          validator: (value) {
            if (value!.isEmpty) return 'Veuillez entrer le fokontany';
            return null;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Région'),
          onSaved: (value) => _region = value!,
          validator: (value) {
            if (value!.isEmpty) return 'Veuillez entrer la région';
            return null;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'District'),
          onSaved: (value) => _district = value!,
          validator: (value) {
            if (value!.isEmpty) return 'Veuillez entrer le district';
            return null;
          },
        ),
      ],
    );
  }
}
