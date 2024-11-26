import 'package:flutter/material.dart';
import 'package:frontend/multipages/authentificationpage.dart';
import 'package:frontend/multipages/createdeclaration.dart';
import 'package:frontend/multipages/declaration.dart';
import 'package:frontend/multipages/historiquepage.dart';
import 'package:frontend/multipages/inscriptionpage.dart';
import 'package:frontend/multipages/mainScreen.dart';
import 'package:frontend/pages/declaration_details.dart';
import 'package:frontend/pages/declaration_form.dart';
import 'package:frontend/pages/declaration_page.dart';
import 'package:frontend/pages/page_declaration.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

/*import 'package:frontend/pages/insc_page.dart';
//import 'package:frontend/pages/insc_page.dart';
import 'package:frontend/pages/accueil_page.dart';
import 'package:frontend/pages/auth_page.dart';
import 'package:frontend/pages/dec_page.dart';
import 'package:frontend/pages/declaration_details.dart';
import 'package:frontend/pages/declaration_form.dart';
import 'package:frontend/pages/insc_page.dart';
import 'package:frontend/pages/inscription_page.dart';
import 'package:frontend/pages/page_authentification.dart';
import 'package:frontend/pages/page_declaration.dart';
import 'package:frontend/pages/pay_page.dart';
import 'package:frontend/pages/profil_page.dart';
//import 'package:frontend/pages/authentification_page.dart';
//import 'package:frontend/pages/declaration_page.dart';
import 'package:frontend/pages/registrationform.dart';
//import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/inscription_page.dart';
*/

void main() { 
  // Initialisez Stripe avec la clé publique
  Stripe.publishableKey ='pk_test_51Q4ibOL0rJAPxroxbgUrkwdhwxf6z7asbexPpV0WY20Fq3rOEe3D2MKuczrzHv9qJ9qynJkltr8GP7VhueNNmqIR00UqbUrRCd'; 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      /*initialRoute: "/",
      routes: {
        "/": (context) =>  PageInscription(),
        //"/declaration": (context) => const DeclarationPage()
      },*/
      home: AuthentificationPage(),
    );
  }
}
