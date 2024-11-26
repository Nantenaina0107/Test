import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'cartefiscaldetailpage.dart';
import '../services/carteservice.dart';
import '../models/cartefiscal.dart'; // Assurez-vous d'avoir ce modèle

class CarteFiscalePage extends StatefulWidget {
  @override
  _CarteFiscalePageState createState() => _CarteFiscalePageState();
}

class _CarteFiscalePageState extends State<CarteFiscalePage> {
  final ApiService _apiService = ApiService();
  late Future<List<CarteFiscale>> _cartesFiscales;

  @override
  void initState() {
    super.initState();
    _cartesFiscales = _apiService.fetchCartesFiscales();
  }

  void _gotoCarteDetails(CarteFiscale carte) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarteFiscaleDetailPage(carte: carte),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartes Fiscales'),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: FutureBuilder<List<CarteFiscale>>(
        future: _cartesFiscales,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune carte fiscale trouvée.'));
          }

          final cartesFiscales = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cartesFiscales.length,
                  itemBuilder: (context, index) {
                    final carte = cartesFiscales[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          'NIF : ${carte.nif}',
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
                              'Référence Paiement : ${carte.idP}',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Date de création : ${carte.createdAt}', // Assurez-vous d'avoir cette donnée
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'QR Code : ${carte.qrCode}', // Afficher le QR code (ou son statut)
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.blueGrey[800],
                        ),
                        onTap: () => _gotoCarteDetails(carte),
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
