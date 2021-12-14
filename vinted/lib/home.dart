import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vinted/commun.dart';
import 'package:vinted/panier.dart';
import 'package:vinted/parametres.dart';
import 'package:english_words/english_words.dart';
import 'package:vinted/produits/produitEte.dart';
import 'package:vinted/produits/produits.dart';
import 'package:vinted/produits/produitsHiver.dart';
import 'compte.dart';
import 'globals.dart' as globals;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.all_inclusive)),
                Tab(icon: Icon(Icons.ac_unit_rounded)),
                Tab(icon: Icon(Icons.wb_sunny_outlined)),
              ],
            ),
            title: const Text('Mon magasin'),
          ),
          body: const TabBarView(
            children: <Widget>[
              Center(
                child: Produits(),
              ),
              Center(
                child: ProduitsHiver(),
              ),
              Center(
                child: ProduitsEte(),
              ),
            ],
          ),
          bottomNavigationBar: Commun(),
        ),
      ),

    );
  }
}




