import 'package:flutter/material.dart';
import '../services/declarationservice.dart';
import 'paiementpage.dart'; // Assurez-vous d'importer votre page de paiement

class DeclarationDetailPage extends StatelessWidget {
  final Map<String, dynamic> declaration;
  final Function onUpdate; // Callback pour notifier les mises à jour

  DeclarationDetailPage({required this.declaration,required this.onUpdate});

  final DeclarationService declarationService = DeclarationService();
  

  void _cancelDeclaration(BuildContext context) async {
    final response = await declarationService.cancelDeclaration(declaration['id']);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Déclaration annulée avec succès')),
    );
    onUpdate(); // Notifier le parent pour mettre à jour la liste
    Navigator.pop(context);
  }

  void _validateDeclaration(BuildContext context) async {
    final response = await declarationService.validateDeclaration(declaration['id']);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Déclaration validée avec succès')),
    );
    onUpdate(); // Notifier le parent pour mettre à jour la liste
    Navigator.pop(context);
  }
  
  void _payDeclaration(BuildContext context) async {
    await declarationService.payDeclaration(context, declaration['id']);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Déclaration payée avec succès')),
    );
    onUpdate(); // Notifier le parent pour mettre à jour la liste
  }
  

  @override
  Widget build(BuildContext context) {
    final status = declaration['status'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la Déclaration'),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Affichage des informations de la déclaration avec des icônes
            _buildInfoRow(Icons.person, 'NIF', declaration['nif']),
            _buildInfoRow(Icons.calendar_today, 'Année Fiscale', declaration['anneFiscal'].toString()),
            _buildInfoRow(Icons.business, 'Chiffre d\'Affaires', '${declaration['chiffreAffaires']} Ar'),
            _buildInfoRow(Icons.monetization_on, 'Montant Investissement', '${declaration['montantInvestissement']} Ar'),
            _buildInfoRow(Icons.attach_money, 'Montant Impôt', '${declaration['montantImpot']} Ar'),
            _buildInfoRow(Icons.info, 'Statut', status),
            SizedBox(height: 30),
            // Boutons d'action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.cancel, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: status == 'Soumise' ? () => _cancelDeclaration(context) : null,
                  label: Text('Annuler'),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.check_circle, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: (status == 'Soumise' && status != 'Payé') 
                      ? () => _validateDeclaration(context) 
                      : null,
                  label: Text('Valider'),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.payment, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: (status == 'Soumise' || status == 'Non payé') 
                      ? () => _payDeclaration(context) 
                      : null,
                  label: Text('Payer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour afficher les lignes d'informations avec des icônes
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey[700]),
          SizedBox(width: 10),
          Text(
            '$label :',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(width: 5),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
