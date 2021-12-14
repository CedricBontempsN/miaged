

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vinted/home.dart';
import 'package:vinted/panier.dart';
import 'package:vinted/parametres.dart';
import 'globals.dart' as globals;
import 'compte.dart';

class Commun extends StatefulWidget {
  const Commun({Key? key}) : super(key: key);

  @override
  _CommunState createState() => _CommunState();
}

class _CommunState extends State<Commun> {
  int _selectedIndex = globals.id;


  void _onItemTapped(int index) {
    if(index == 0){
      globals.id=0;
      _selectedIndex = 0;
      _afficherMenu();
    }
    if(index == 1){
      globals.id=1;
      _selectedIndex = 0;
      _afficherCompte();
    }
    if(index == 2){
      globals.id=2;
      _selectedIndex = 2;
      _afficherPanier();
    }
    if(index == 3){
      globals.id=3;
      _selectedIndex = 3;
      _afficherParametres();
    }
    setState(() {
      globals.id=index;
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mon compte',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Mon panier',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      );
  }

  void _afficherPanier(){
    globals.id=2;
    _selectedIndex = 2;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Panier()),
    );
  }

  void _afficherParametres(){
    globals.id=3;
    _selectedIndex = 3;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Parametres()),
    );
  }

  void _afficherMenu() {
    globals.id=0;
    _selectedIndex = 0;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _afficherCompte() {
    globals.id=1;
    _selectedIndex = 1;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Compte()),
    );
  }
}

/*

  void _afficherFavoris(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = globals.saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: globals.font,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),
    );
  }
 */

