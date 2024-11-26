import 'package:flutter/material.dart';
import 'package:frontend/multipages/homepage.dart';
import 'package:frontend/multipages/declarationpage.dart';
import 'package:frontend/multipages/historiquepage.dart';
import 'package:frontend/multipages/cartfiscalpage.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    Homepage(),
    DeclarationPage(),
    HistoriquePage(),
    CarteFiscalePage()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Télèdéclaration de l'IR"),
      ),*/
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: "Déclaration",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Historique",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: "Carte Fiscal",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 21, 214, 27),
        unselectedItemColor: Colors.blueGrey[400],
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),  
    );
  }
}