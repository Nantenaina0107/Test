import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Utilisateur',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProfilPage(),
    );
  }
}

// Page de Profil
class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final _formKey = GlobalKey<FormState>();
  String _nom = 'John';
  String _prenom = 'Doe';
  String _email = 'john.doe@example.com';
  String _cin = '1234567890123';
  String _secteur = 'Import/Export';
  String _descriptionActivite = 'Importation et exportation de biens';
  bool _estInvestisseur = true;

  String _fokontany = 'Ambohimanarina';
  String _commune = 'Antananarivo';
  String _adresse = 'Tananbao';
  String _region = 'Analamanga';
  String _district = 'Antananarivo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Utilisateur'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Carte des Informations Personnelles
              _buildInfoCard(
                context,
                title: 'Informations Personnelles',
                children: [
                  _buildTextField('Nom', _nom, (value) {
                    setState(() {
                      _nom = value;
                    });
                  }),
                  _buildTextField('Prénom', _prenom, (value) {
                    setState(() {
                      _prenom = value;
                    });
                  }),
                  _buildTextField('Email', _email, (value) {
                    setState(() {
                      _email = value;
                    });
                  }),
                  _buildTextField('CIN', _cin, (value) {
                    setState(() {
                      _cin = value;
                    });
                  }),
                ],
              ),

              SizedBox(height: 20),

              // Carte des Activités
              _buildInfoCard(
                context,
                title: 'Activités',
                children: [
                  _buildTextField('Secteur', _secteur, (value) {
                    setState(() {
                      _secteur = value;
                    });
                  }),
                  _buildTextField('Description', _descriptionActivite, (value) {
                    setState(() {
                      _descriptionActivite = value;
                    });
                  }),
                  _buildSwitchRow('Investisseur', _estInvestisseur, (newValue) {
                    setState(() {
                      _estInvestisseur = newValue;
                    });
                  }),
                ],
              ),

              SizedBox(height: 20),

              // Carte du Siège
              _buildInfoCard(
                context,
                title: 'Siège',
                children: [
                  _buildTextField('Fokontany', _fokontany, (value) {
                    setState(() {
                      _fokontany = value;
                    });
                  }),
                  _buildTextField('Commune', _commune, (value) {
                    setState(() {
                      _commune = value;
                    });
                  }),
                  _buildTextField('Adresse', _adresse, (value) {
                    setState(() {
                      _adresse = value;
                    });
                  }),
                  _buildTextField('Région', _region, (value) {
                    setState(() {
                      _region = value;
                    });
                  }),
                  _buildTextField('District', _district, (value) {
                    setState(() {
                      _district = value;
                    });
                  }),
                  _buildUpdateButton(context), // Bouton de mise à jour
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fonction pour construire chaque carte
  Widget _buildInfoCard(BuildContext context, {required String title, required List<Widget> children}) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  // Fonction pour construire un TextFormField
  Widget _buildTextField(String label, String initialValue, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }

  // Fonction pour construire une ligne avec un switch
  Widget _buildSwitchRow(String label, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // Fonction pour construire le bouton de mise à jour
  Widget _buildUpdateButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Logique de mise à jour ici
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Mise à jour effectuée !')),
            );
          }
        },
        child: Text('Mettre à jour les informations'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}
