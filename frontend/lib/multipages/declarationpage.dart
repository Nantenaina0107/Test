import 'package:flutter/material.dart';
import '../services/declarationservice.dart';
import 'createdeclaration.dart';
import 'declarationdetailpage.dart';

class DeclarationPage extends StatefulWidget {
  @override
  _DeclarationPageState createState() => _DeclarationPageState();
}

class _DeclarationPageState extends State<DeclarationPage> {
  final DeclarationService _declarationService = DeclarationService();
  late Future<List<dynamic>> _declarations;

  @override
  void initState() {
    super.initState();
    _declarations = _declarationService.fetchDeclarations();
  }

   void _goToCreateDeclaration() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateDeclaration()),
    ).then((_) => _refreshDeclarations()); // Rafraîchir la liste après la création
  }

  void _goToDeclarationDetail(dynamic declaration) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeclarationDetailPage(
          declaration: declaration,
          onUpdate: _refreshDeclarations, // Passer le callback
        ),
      ),
    );
  }

  // Méthode pour rafraîchir les déclarations
  void _refreshDeclarations() {
    setState(() {
      _declarations = _declarationService.fetchDeclarations();
    });
  }

  // Méthode pour obtenir la couleur en fonction du statut
  Color _getStatusColor(String status) {
    switch (status) {
      case 'payé':
        return Colors.green;
      case 'Non payé':
        return Colors.red;
      case 'Soumise':
        return Colors.blue;
      default:
        return Colors.blueGrey;
    }
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Déclarations'),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _declarations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune déclaration trouvée.'));
          }

          final declarations = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(), // Désactive le défilement interne
                  shrinkWrap: true, // Assure que la liste utilise l'espace disponible
                  itemCount: declarations.length,
                  itemBuilder: (context, index) {
                    final declaration = declarations[index];
                    final statusColor = _getStatusColor(declaration['status']);

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          'Année Fiscale : ${declaration['anneFiscal']}',
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
                              'Montant Impôt : ${declaration['montantImpot']} Ar',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Statut : ${declaration['status']}',
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
                        onTap: () => _goToDeclarationDetail(declaration),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreateDeclaration,
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey[400],
        tooltip: 'Nouvelle Déclaration',
      ),
    );
  }
}
