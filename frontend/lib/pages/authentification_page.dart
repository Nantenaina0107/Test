import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthentificationPage extends StatefulWidget {
  const AuthentificationPage({super.key});

  @override
  State<AuthentificationPage> createState() => _AuthentificationPageState();
}

class _AuthentificationPageState extends State<AuthentificationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nif = "";
  String password = "";
  bool _isLoading = false;

  Future<void> _login() async{
    // Validation du formulaire
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      _formKey.currentState!.save();

      // Données à envoyer
      final Map<String, dynamic> loginData = {
        'nif': nif,
        'password': password,
      };

      try {
        // Envoyer la requête POST à votre API de connexion
        final response = await http.post(
          Uri.parse('http://localhost:3000/api/login'), // Remplacez par l'URL de votre API
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(loginData),
        );

        if (response.statusCode == 200) {
          // Si la connexion est réussie, redirigez vers une autre page
          print('Connexion réussie');
          // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          // Si la connexion échoue
          print('Erreur de connexion');
          _showErrorDialog('Erreur de connexion. Veuillez vérifier vos informations.');
        }
      } catch (error) {
        print('Erreur: $error');
        _showErrorDialog('Erreur de connexion. Veuillez réessayer.');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Erreur'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'NIF',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => nif = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre NIF';
                  }
                  if (value.length != 10) {
                    return 'Le NIF doit comporter 10 chiffres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                ),
                obscureText: true,
                onSaved: (value) => password = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: const Text('Se connecter'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}