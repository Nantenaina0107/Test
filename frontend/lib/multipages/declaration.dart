import 'package:flutter/material.dart';

class Declaration extends StatefulWidget {
  const Declaration({super.key});

  @override
  State<Declaration> createState() => _DeclarationState();
}

class _DeclarationState extends State<Declaration> {
   final _formKey = GlobalKey<FormState>();

  String secteur = '';

  bool isInvestisseur = false;

  String secteurInvestissement = '';

  double chiffreAffaires = 0.0;

  double montantInvestissement = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              if (!isInvestisseur)
              Column(
                children: const [
                  Text('Aucun investissement réalisé'),
                  Text('Montant d\'investissement : 0.0'),
                ],
              ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: (){},//_submitDeclaration,
              child: const Text('Soumettre la déclaration'),
            ),
          ],
        ),
      ),
    );
  }
}