import 'package:flutter/material.dart';

class Newdeclarationpage extends StatelessWidget {
  const Newdeclarationpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nouveau Déclaration"),
      ),
      body : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Secteur',
              ),
              initialValue: null,
              readOnly: true, // Le secteur est pré-rempli et non modifiable
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Secteur',
              ),
              initialValue: null,
              readOnly: true, // Le secteur est pré-rempli et non modifiable
            ), 
          ] 
        ),
      ),
    );
  }
}