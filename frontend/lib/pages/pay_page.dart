import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application Fiscale Moderne',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PaiementPage(),
    );
  }
}

// Page Paiement avec Historique des paiements
class PaiementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique des Paiements'),
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            // Titre de la liste des paiements
            Text(
              'Historique des Paiements',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildPaiementCard(
                    'Paiement - 01 Octobre 2024',
                    'Montant: 500 000 MGA',
                    Icons.payment,
                    Colors.teal.shade100,
                    context,
                  ),
                  _buildPaiementCard(
                    'Paiement - 15 Septembre 2024',
                    'Montant: 1 200 000 MGA',
                    Icons.payment,
                    Colors.green.shade100,
                    context,
                  ),
                  _buildPaiementCard(
                    'Paiement - 01 Août 2024',
                    'Montant: 850 000 MGA',
                    Icons.payment,
                    Colors.blue.shade100,
                    context,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Déclaration',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Paiements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Carte Fiscale',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: 2, // On est sur la page Paiement
        selectedItemColor: Colors.teal,
        onTap: (index) {
          // Gérer la navigation si besoin
        },
      ),
    );
  }

  // Fonction pour créer chaque carte de paiement
  Widget _buildPaiementCard(String title, String subtitle, IconData icon, Color color, BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: IconButton(
          icon: Icon(Icons.details, color: Colors.teal),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailPaiementPage(title: title)),
            );
          },
        ),
      ),
    );
  }
}

// Page pour la soumission d'un nouveau paiement
class NouveauPaiementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouveau Paiement'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Formulaire de soumission d\'un nouveau paiement',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}

// Page des détails d'un paiement
class DetailPaiementPage extends StatelessWidget {
  final String title;

  DetailPaiementPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Paiement'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 10),
            Text(
              'Détails complets du paiement ici...',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
