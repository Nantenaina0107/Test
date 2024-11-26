import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PageAuthentification extends StatefulWidget {
  const PageAuthentification({super.key});
  @override
  _PageAuthentificationState createState() => _PageAuthentificationState();
}

class _PageAuthentificationState extends State<PageAuthentification> {
  final _nifController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _login() async {
    final String nif = _nifController.text;
    final String password = _passwordController.text;

    if (nif.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez remplir tous les champs.';
      });
      return;
    }

    final response = await http.post(
      Uri.parse('http://<ton_backend_url>/api/auth/login'), // Remplace par l'URL de ton backend
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'nif': nif, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final String token = data['token'];
      // Ici, tu peux stocker le token avec un package comme shared_preferences
      print('Connexion réussie, token: $token');
      // Naviguer vers la page suivante ou faire d'autres actions
    } else {
      setState(() {
        _errorMessage = 'NIF ou mot de passe incorrect.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nifController,
              decoration: const InputDecoration(labelText: 'NIF'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Se connecter'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _errorMessage,
                  style:const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
