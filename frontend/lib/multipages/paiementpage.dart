import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  final String declarationId; // ID de la déclaration pour le paiement

  const PaymentPage({Key? key, required this.declarationId}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  String? _clientSecret;

  @override
  void initState() {
    super.initState();
    // Initialiser Stripe
    Stripe.publishableKey = "votre_clé_publiable_de_stripe"; // Remplacez par votre clé
    _fetchClientSecret(); // Obtenez le client secret à partir de votre serveur
  }

  Future<void> _fetchClientSecret() async {
    String? token = await _storage.read(key: 'token'); // Récupérez le token de sécurité
    var response = await http.post(
      Uri.parse("http://localhost:3000/api/declaration/${widget.declarationId}/creer"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _clientSecret = json.decode(response.body)['clientSecret'];
      });
    } else {
      // Gérer les erreurs ici
      print("Erreur lors de la récupération du client secret: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la récupération du client secret')),
      );
    }
  }

  Future<void> _pay() async {
    if (_clientSecret != null) {
      try {
        // Afficher le Payment Sheet
        await Stripe.instance.presentPaymentSheet().then((_) async {
          // Si le paiement a réussi, mettre à jour le statut sur votre serveur
          await _confirmPayment();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Paiement réussi!')),
          );

          // Retour à la page précédente ou mise à jour de l'interface ici
          Navigator.pop(context);
        }).catchError((error) {
          print("Erreur lors de l'affichage du Payment Sheet: $error");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors du paiement: $error')),
          );
        });
      } catch (e) {
        // Gérer les erreurs
        print("Erreur lors du paiement: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du paiement: $e')),
        );
      }
    }
  }

  Future<void> _confirmPayment() async {
    String? token = await _storage.read(key: 'token'); // Récupérez le token de sécurité
    var response = await http.post(
      Uri.parse("http://localhost:3000/api/declaration/${widget.declarationId}/confirmer"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print("Confirmation du paiement réussie");
    } else {
      print("Erreur lors de la confirmation du paiement: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paiement"),
      ),
      body: Center(
        child: _clientSecret == null
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _pay,
                child: Text("Payer"),
              ),
      ),
    );
  }
}
