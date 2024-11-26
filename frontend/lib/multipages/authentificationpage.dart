import 'package:flutter/material.dart';
import '../services/authentificationservice.dart';
import '../multipages/mainscreen.dart';

class AuthentificationPage extends StatefulWidget {
  @override
  _AuthentificationPageState createState() => _AuthentificationPageState();
}

class _AuthentificationPageState extends State<AuthentificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nifController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthentificationService();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  // Affiche un message avec un dialogue d'alerte
  void _showMessage(String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: isSuccess ? Colors.green : Colors.red,
              ),
              SizedBox(width: 8),
              Text(isSuccess ? 'Succès' : 'Erreur'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final message = await _authService.login(
          _nifController.text,
          _passwordController.text,
        );
        _showMessage(message, true);

        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Mainscreen()),
          );
        });
      } catch (e) {
        _showMessage(e.toString(), false);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text('Connexion'),
        backgroundColor: Colors.blueGrey[400],
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo ou Image de bienvenue
                /*Image.asset(
                  'assets/logo.png',  // Assurez-vous d'ajouter une image dans le dossier assets
                  height: 100,
                ),*/
                SizedBox(height: 20),
                Text(
                  'Bienvenue!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                ),
                SizedBox(height: 20),

                // Champ NIF
                TextFormField(
                  controller: _nifController,
                  decoration: InputDecoration(
                    labelText: 'NIF',
                    prefixIcon: Icon(Icons.perm_identity),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Veuillez entrer votre NIF' : null,
                ),
                SizedBox(height: 15),

                // Champ mot de passe avec option d'afficher/masquer
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: (value) =>
                      value!.isEmpty ? 'Veuillez entrer votre mot de passe' : null,
                ),
                SizedBox(height: 20),

                // Bouton de connexion
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          //primary: Colors.blueGrey[800],
                        ),
                        child: Text(
                          'Connexion',
                          style: TextStyle(
                            color: Colors.blueGrey[400],
                            fontSize: 18),
                        ),
                      ),
                SizedBox(height: 20),
                
                // Option de mot de passe oublié
                TextButton(
                  onPressed: () {
                    // Action pour mot de passe oublié
                  },
                  child: Text(
                    'Mot de passe oublié?',
                    style: TextStyle(
                      color: Colors.blueGrey[400],
                    ),
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
