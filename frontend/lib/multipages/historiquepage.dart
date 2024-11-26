import 'package:flutter/material.dart';
import 'package:frontend/multipages/historiquedetailpage.dart';
import '../services/paiementservice.dart';

/*class HistoriquePage extends StatelessWidget {
  const HistoriquePage({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text("Historique du paiement"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index){
          return ListTile(
            title: Text("Paiement #${index+1}"),
            subtitle: Text("description"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)
                =>HistoriqueDetailPage(index: index)
                ),
              );
            },
          );
        }
      ),
    );
  }
}*/

class HistoriquePage extends StatefulWidget {
  @override
  _HistoriquePageState createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  final PaiementService _paiementService = PaiementService();
  late Future<List<dynamic>> _paiements;

  @override
  void initState() {
    super.initState();
    _paiements = _paiementService.fetchHistorique();
  }
  
  void _gotoHistoriqueDetails(Map<String, dynamic> paiement) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HistoriqueDetailPage(paiement: paiement),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique des Paiements'),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _paiements,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun paiement trouvé.'));
          }

          final paiements = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(), // Désactive le défilement interne
                  shrinkWrap: true, // Assure que la liste utilise l'espace disponible
                  itemCount: paiements.length,
                  itemBuilder: (context, index) {
                    final paiement = paiements[index];
                    final statusColor = _getStatusColor(paiement['status']);

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          'Référence : ${paiement['ref']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              'Montant : ${paiement['montantImpot']} Ar',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Date : ${paiement['dateP']}',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Statut : ${paiement['status']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.blueGrey[800],
                        ),
                        // Action à effectuer lors du clic si nécessaire
                        onTap: () => _gotoHistoriqueDetails(paiement), // Appel de la fonction
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
