import 'package:flutter/material.dart';
import '../models/cartefiscal.dart'; // Assurez-vous d'importer votre modèle

class CarteFiscaleDetailPage extends StatelessWidget {
  final CarteFiscale carte;

  CarteFiscaleDetailPage({required this.carte});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la Carte Fiscale'),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NIF: ${carte.nif}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Référence de Paiement: ${carte.idP}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Date de Création: ${carte.createdAt}', // Assurez-vous d'avoir cette donnée
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'QR Code:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Image.network(carte.qrCode), // Assurez-vous que qrCode est une URL ou utilisez un widget QR
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Action pour partager ou sauvegarder la carte fiscale
                // Implémentez votre logique de partage ici si nécessaire
              },
              child: Text('Partager la Carte Fiscale'),
            ),
          ],
        ),
      ),
    );
  }
}
