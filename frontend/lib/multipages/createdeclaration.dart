import 'package:flutter/material.dart';
import '../services/declarationservice.dart';

class CreateDeclaration extends StatefulWidget {
  @override
  _CreateDeclarationState createState() => _CreateDeclarationState();
}

class _CreateDeclarationState extends State<CreateDeclaration> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _anneeController = TextEditingController();
  final TextEditingController _chiffreAffairesController = TextEditingController();
  final TextEditingController _montantInvestissementController = TextEditingController();
  bool _isInvestisseur = false; // Variable pour le type d'investisseur
  final DeclarationService _declarationService = DeclarationService();

  void _submitDeclaration() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _declarationService.createDeclaration(
          int.parse(_anneeController.text),
          double.parse(_chiffreAffairesController.text),
          _isInvestisseur ? double.parse(_montantInvestissementController.text) : 0.0,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Déclaration créée avec succès !')),
        );
        Navigator.pop(context); // Retour à la liste après succès
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la création : $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouvelle Déclaration'),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _anneeController,
                decoration: InputDecoration(
                  labelText: 'Année Fiscale',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Veuillez entrer l\'année fiscale' : null,
              ),
              SizedBox(height: 16), // Ajout d'un espacement
              TextFormField(
                controller: _chiffreAffairesController,
                decoration: InputDecoration(
                  labelText: 'Chiffre d\'Affaires',
                  prefixIcon: Icon(Icons.money),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Veuillez entrer le chiffre d\'affaires' : null,
              ),
              SizedBox(height: 16), // Ajout d'un espacement
              SwitchListTile(
                title: Text('Êtes-vous un investisseur ?'),
                value: _isInvestisseur,
                onChanged: (bool value) {
                  setState(() {
                    _isInvestisseur = value;
                  });
                },
              ),
              if (_isInvestisseur) // Affiche le champ si l'utilisateur est investisseur
                Column(
                  children: [
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _montantInvestissementController,
                      decoration: InputDecoration(
                        labelText: 'Montant Investissement',
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Veuillez entrer le montant d\'investissement' : null,
                    ),
                  ],
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitDeclaration,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[400], // Couleur du bouton
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('Soumettre'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
