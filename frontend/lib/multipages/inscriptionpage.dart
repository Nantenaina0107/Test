import 'package:flutter/material.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  int _currentstep = 0;
  final _formKey = GlobalKey<FormState>();
  //variables 
  final nom = TextEditingController();
  final prenom = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final cin = TextEditingController();
  DateTime? datenaiss;
  final lieunaiss = TextEditingController();
  String situation ="";
  String sexe ="";

  //variables pour les activités
  final secteur = TextEditingController();
  final description = TextEditingController();
  bool isInvestisseur = false;
  final secteurInvestissement = TextEditingController();

  //variables pour les siège
  final adresse = TextEditingController();
  final fokontany = TextEditingController();
  final commune = TextEditingController();
  final region = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMMATRICULATION"),
      ),
      body: Stepper(
        currentStep: _currentstep,
        onStepContinue: () {
          if (_currentstep < 2 && _formKey.currentState!.validate()) {
            setState(() {
              _currentstep += 1;
            });
          }
        },
        onStepCancel: () {
          if (_currentstep > 0) {
            setState(() {
              _currentstep -= 1;
            });
          }
        },
        steps: [
          Step(
            title: Text("Détails personnelles"),
            content: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nom,
                    decoration: InputDecoration(
                      labelText: "Nom"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Entrer votre nom";
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: prenom,
                    decoration: InputDecoration(
                      labelText: "Prénom"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Entrer votre prénom";
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: "email"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Entrer votre Email";
                      //if (!RegExp("^[@]+@[^@]+\.[^@]+").hasMatch(value)) return "Email non valide";
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: cin,
                    decoration: InputDecoration(
                      labelText: "CIN"
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty || value.length != 12) return "Entrer votre CIN de 12 chiffres";
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: lieunaiss,
                    decoration: InputDecoration(
                      labelText: "Lieu de naissance"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Entrer votre Lieu de naissance";
                      return null;
                    },
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: "situation matrimoniale"
                    ),
                    value: situation.isNotEmpty ? situation : null,
                    items: ["Célibataire", "Marié(e)", "Divorcé(e)"]
                      .map((status)=> DropdownMenuItem(child: Text(status),value: status,)).toList(), 
                    onChanged: (value){
                      setState(() {
                        situation = value!;
                      });
                    },
                    validator: (value) {
                      value == null ? "Séléctionnez votre situation matrimoniale" : null;
                    },
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: "Genre"
                    ),
                    value: sexe.isNotEmpty ? sexe : null,
                    items: ["Masculin", "Féminin"]
                      .map((status)=> DropdownMenuItem(child: Text(status),value: status,)).toList(), 
                    onChanged: (value){
                      setState(() {
                        sexe = value!;
                      });
                    },
                    validator: (value) {
                      value == null ? "Séléctionnez votre genre" : null;
                    },
                  )
                ],
              )
            )
          ),
          Step(
            title: Text("Activités"), 
            content: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: secteur,
                    decoration: InputDecoration(
                      labelText: "Secteur"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Entrer votre secteur";
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: description,
                    decoration: InputDecoration(
                      labelText: "Description"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Entrer votre Description";
                      return null;
                    },
                  ),
                  SwitchListTile(
                    title: Text('Investisseur'),
                    value: isInvestisseur,
                    onChanged: (value) {
                      setState(() {
                        isInvestisseur = value;
                      });
                    }, 
                  ),
                  if(isInvestisseur)
                    TextFormField(
                    controller: secteurInvestissement,
                    decoration: InputDecoration(
                      labelText: "Secteur d'Investissement"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Entrer votre Secteur d'Investissement";
                      return null;
                    },
                  ),
                ],
              ) 
            )
          ),
          Step(
            title: Text("Siéges"), 
            content: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: adresse,
                    decoration: InputDecoration(
                      labelText: "Adresse actuelle"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Entrer votre adresse actuel";
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: fokontany,
                    decoration: InputDecoration(
                      labelText: "Fokontany"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Entrer votre Fokontany";
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: commune,
                    decoration: InputDecoration(
                      labelText: "Commune"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Entrer votre commune";
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: region,
                    decoration: InputDecoration(
                      labelText: "Région"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Entrer votre Région";
                      return null;
                    },
                  ),
                ],
              )
            )
          )
        ],
      ),
    );
  }
}
