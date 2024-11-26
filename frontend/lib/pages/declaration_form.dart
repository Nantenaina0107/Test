import 'package:flutter/material.dart';

class DeclarationForm extends StatefulWidget {
  const DeclarationForm({super.key});

  @override
  _DeclarationFormState createState() => _DeclarationFormState();
}

class _DeclarationFormState extends State<DeclarationForm> {
  final _formKey = GlobalKey<FormState>();

  // Champs à envoyer au backend
  String secteur = "Commerce"; // Valeur par défaut
  String anneeFiscale = "2023"; // Valeur par défaut
  bool isInvest = false;
  double? montantInvestissement;
  double? chiffreAffaires;

  // Fonction simulant l'envoi des données au backend
  Future<void> submitDeclaration() async {
    if (_formKey.currentState!.validate()) {
      // Simuler l'envoi des données et la réception de la réponse du backend
      Map<String, dynamic> response = await simulateBackendResponse();

      // Rediriger vers la page de détails de la déclaration avec les données reçues du backend
      /*Navigator.push(
        context,
        MaterialPageRoute(
          //builder: (context) => DeclarationDetails(response),
        ),
      );*/
    }
  }

  Future<Map<String, dynamic>> simulateBackendResponse() async {
    // Simuler une réponse du backend après soumission
    await Future.delayed(Duration(seconds: 2)); // Simule un délai de traitement
    return {
      'nif': '1234567890',
      'chiffreAffaires': chiffreAffaires ?? 0,
      'montantInvestissement': isInvest ? montantInvestissement ?? 0 : 0,
      'montantAPayer': 1000000, // Simuler le calcul du backend
      'status': 'En attente de paiement',
      'dateDeclaration': DateTime.now().toString(),
      'dateLimite': DateTime.now().add(Duration(days: 30)).toString(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Déclaration d\'impôts'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Secteur et année fiscale dans une card pour une meilleure lisibilité
                Card(
                  elevation: 3,
                  margin: EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Secteur d\'activité : $secteur',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Année fiscale : $anneeFiscale',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                // Switch pour les investissements avec un style plus moderne
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'investisseur?',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Switch(
                              value: isInvest,
                              activeColor: Colors.blueGrey,
                              onChanged: (value) {
                                setState(() {
                                  isInvest = value;
                                });
                              },
                            ),
                          ],
                        ),
                        if (isInvest)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Montant d\'investissement',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (isInvest && (value == null || value.isEmpty)) {
                                  return 'Veuillez saisir le montant d\'investissement';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                montantInvestissement = double.tryParse(value);
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Chiffre d'affaires input avec un champ visuellement amélioré
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Chiffre d\'affaires',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir le chiffre d\'affaires';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        chiffreAffaires = double.tryParse(value);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Bouton de soumission avec un design modernisé
                Center(
                  child: ElevatedButton(
                    onPressed: submitDeclaration,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blueGrey,
                    ),
                    child: Text(
                      'Soumettre la déclaration',
                      style: TextStyle(fontSize: 18,color: Color.fromARGB(221, 183, 217, 221), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}