import 'package:flutter/material.dart';

/*class HistoriqueDetailPage extends StatelessWidget {
  final int index;
  const HistoriqueDetailPage({Key? key, required this.index}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails du paiement"),
      ),
      body: Center(
        child: Text("Détail du paiement #${index+1}"),
      ),
    );
  }
}*/

class HistoriqueDetailPage extends StatelessWidget {
  final Map<String, dynamic> paiement;

  // Constructeur qui prend un objet de paiement sélectionné
  HistoriqueDetailPage({required this.paiement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Paiement'),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Référence : ${paiement['ref']}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Montant : ${paiement['montantImpot']} Ar',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Date : ${paiement['dateP']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Statut : ${paiement['status']}',
              style: TextStyle(
                fontSize: 16,
                color: _getStatusColor(paiement['status']),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Type de paiement : ${paiement['type']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Nom de l\'utilisateur : ${paiement['nomUtilisateur']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Email de l\'utilisateur : ${paiement['emailUtilisateur']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action pour télécharger un reçu ou autre action
              },
              child: Text('Télécharger le Reçu'),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour obtenir la couleur en fonction du statut
  Color _getStatusColor(String status) {
    switch (status) {
      case 'succeeded':
        return Colors.green;
      case 'failed':
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }
}
