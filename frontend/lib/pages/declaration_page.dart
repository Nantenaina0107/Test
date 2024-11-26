import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';

class DeclarationPage extends StatefulWidget {
  

 

  @override
  _DeclarationPageState createState() => _DeclarationPageState();
}

class _DeclarationPageState extends State<DeclarationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String secteur = '';
  bool isInvestisseur = false;
  String secteurInvestissement = '';
  double chiffreAffaires = 0.0;
  double montantInvestissement = 0.0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    //_fetchUserData();
  }

  /*Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Envoyer le JWT au serveur pour récupérer les données utilisateur
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/getUserData'), // Remplacez par votre endpoint
        headers: {
          'Authorization': 'Bearer ${widget.jwt}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          secteur = data['secteur'];
          isInvestisseur = data['isInvestisseur'];
          secteurInvestissement = data['secteurInvestissement'] ?? '';
          montantInvestissement = data['montantInvestissement'] ?? 0.0;
        });
      } else {
        print('Erreur lors de la récupération des données');
      }
    } catch (error) {
      print('Erreur: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }*/

  /*Future<void> _submitDeclaration() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Map<String, dynamic> declarationData = {
        'chiffreAffaires': chiffreAffaires,
        'isInvestisseur': isInvestisseur,
        'secteurInvestissement': isInvestisseur ? secteurInvestissement : '',
        'montantInvestissement': isInvestisseur ? montantInvestissement : 0.0,
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:3000/api/declaration'),
          headers: {
            'Authorization': 'Bearer ${widget.jwt}',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(declarationData),
        );

        if (response.statusCode == 200) {
          print('Déclaration soumise avec succès');
          // Afficher un message de succès ou rediriger
        } else {
          print('Erreur lors de la soumission');
        }
      } catch (error) {
        print('Erreur: $error');
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Déclaration'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Secteur',
                      ),
                      initialValue: secteur,
                      readOnly: true, // Le secteur est pré-rempli et non modifiable
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Chiffre d\'affaires',
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (value) => chiffreAffaires = double.tryParse(value!) ?? 0.0,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        const Text('Investisseur :'),
                        Checkbox(
                          value: isInvestisseur,
                          onChanged: (value) {
                            setState(() {
                              isInvestisseur = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    if (isInvestisseur)
                      Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Secteur d\'investissement',
                            ),
                            initialValue: secteurInvestissement, // Pré-rempli avec les données existantes
                            onSaved: (value) => secteurInvestissement = value ?? '',
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Montant de l\'investissement réalisé',
                            ),
                            keyboardType: TextInputType.number,
                            onSaved: (value) => montantInvestissement = double.tryParse(value!) ?? 0.0,
                          ),
                        ],
                      ),
                    /*if (!isInvestisseur)
                      Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                            labelText: "Secteur d'Investissement",
                          ),
                          initialValue: secteurInvestissement,
                          readOnly: true, // Le secteur est pré-rempli et non modifiable
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                            labelText: "Montant d'Investissement",
                          ),
                          initialValue: montantInvestissement.toString(),
                          readOnly: true, // Le secteur est pré-rempli et non modifiable
                          ),
                        ],
                      ),
                    */  
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: (){},//_submitDeclaration,
                      child: const Text('Soumettre la déclaration'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
