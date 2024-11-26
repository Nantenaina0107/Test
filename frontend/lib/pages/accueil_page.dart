import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accueil',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AccueilPage(),
    );
  }
}

// Page d'Accueil
class AccueilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            _buildCard(
              context,
              title: 'Déclaration',
              icon: Icons.article,
              onTap: () {
                // Naviguer vers la page de déclaration
              },
            ),
            _buildCard(
              context,
              title: 'Consultation Fiscale',
              icon: Icons.assignment,
              onTap: () {
                // Naviguer vers la page de consultation fiscale
              },
            ),
            _buildCard(
              context,
              title: 'Historique Paiement',
              icon: Icons.payment,
              onTap: () {
                // Naviguer vers la page d'historique de paiement
              },
            ),
            _buildCard(
              context,
              title: 'Carte Fiscale',
              icon: Icons.credit_card,
              onTap: () {
                // Naviguer vers la page de carte fiscale
              },
            ),
            _buildCard(
              context,
              title: 'Profil',
              icon: Icons.person,
              onTap: () {
                // Naviguer vers la page de profil
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers la page de nouvelle déclaration
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Déclaration',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Consultation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Paiement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: 0, // L'index de l'onglet actif
        selectedItemColor: Colors.teal,
        onTap: (index) {
          // Logique pour changer de page selon l'index
        },
      ),
    );
  }

  // Fonction pour construire chaque carte
  Widget _buildCard(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.teal),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
