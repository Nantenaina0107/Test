import 'package:flutter/material.dart';

class DeclarationDetails extends StatelessWidget {
  final Map<String, dynamic> declarationData;

  DeclarationDetails(this.declarationData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la déclaration'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('NIF : ${declarationData['nif']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                Text('Chiffre d\'affaires : ${declarationData['chiffreAffaires']} Ariary',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                Text('Montant d\'investissement : ${declarationData['montantInvestissement']} Ariary',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                Text('Montant à payer : ${declarationData['montantAPayer']} Ariary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('Status : ${declarationData['status']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                Text('Date de déclaration : ${declarationData['dateDeclaration']}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                Text('Date limite de paiement : ${declarationData['dateLimite']}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Logique pour procéder au paiement
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blueGrey,
                    ),
                    child: Text('Procéder au paiement', style: TextStyle(fontSize: 18)),
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