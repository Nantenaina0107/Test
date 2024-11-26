import 'package:flutter/material.dart';


// Page d'Authentification
class AuthentificationPage extends StatefulWidget {
  @override
  _AuthentificationPageState createState() => _AuthentificationPageState();
}

class _AuthentificationPageState extends State<AuthentificationPage> {
  final _formKey = GlobalKey<FormState>();
  String _nif = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentification'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Connectez-vous',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'NIF',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _nif = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer votre NIF';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onSaved: (value) {
                    _password = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Logique pour authentifier l'utilisateur avec le NIF et le mot de passe
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Connexion en cours...')),
                      );
                    }
                  },
                  child: Text('Se connecter'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
