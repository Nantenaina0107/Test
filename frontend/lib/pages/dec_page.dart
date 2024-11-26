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
      home: DeclarationPage(),
    );
  }
}

// Page Déclaration avec Liste, Détails, et Nouvelle Déclaration
class DeclarationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Déclarations'),
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NouvelleDeclarationPage()),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.add, size: 18),
                    SizedBox(width: 4),
                    Text('Nouvelle Déclaration'),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
              ),
            ),
            Text(
              'Liste des Déclarations',
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
                  _buildDeclarationCard(
                    'Déclaration - 01 Octobre 2024',
                    'Montant payé: 500 000 MGA',
                    Icons.assignment_turned_in_outlined,
                    Colors.teal.shade100,
                    context,
                  ),
                  _buildDeclarationCard(
                    'Déclaration - 15 Septembre 2024',
                    'Montant payé: 1 200 000 MGA',
                    Icons.assignment_turned_in_outlined,
                    Colors.green.shade100,
                    context,
                  ),
                  _buildDeclarationCard(
                    'Déclaration - 01 Août 2024',
                    'Montant payé: 850 000 MGA',
                    Icons.assignment_turned_in_outlined,
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
        currentIndex: 1, // On est sur la page Déclaration
        selectedItemColor: Colors.teal,
        onTap: (index) {
          // Gérer la navigation si besoin
        },
      ),
    );
  }

  // Fonction pour créer chaque carte de déclaration
  Widget _buildDeclarationCard(String title, String subtitle, IconData icon, Color color, BuildContext context) {
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
              MaterialPageRoute(builder: (context) => DetailDeclarationPage(title: title)),
            );
          },
        ),
      ),
    );
  }
}

// Page pour la soumission d'une nouvelle déclaration
class NouvelleDeclarationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouvelle Déclaration'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Formulaire de soumission d\'une nouvelle déclaration',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}

// Page des détails d'une déclaration
class DetailDeclarationPage extends StatelessWidget {
  final String title;

  DetailDeclarationPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la Déclaration'),
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
              'Détails complets de la déclaration ici...',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Action pour soumettre un paiement par exemple
              },
              icon: Icon(Icons.payment),
              label: Text('Effectuer un Paiement'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
