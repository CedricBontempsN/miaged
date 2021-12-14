import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vinted/produits/produits.dart';
import '../globals.dart' as globals;

import 'commun.dart';

class Panier extends StatefulWidget {
  const Panier({Key? key}) : super(key: key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  var listePanier = [];
  List<dynamic> liste = [];
  User? user = FirebaseAuth.instance.currentUser;
  int total=0;

  @override
  void initState(){
    super.initState();
    getPanier();
    print(listePanier);
    setState((){});

  }

  void getPanier(){
    print("getPanier");
    var doc = FirebaseFirestore.instance
        .collection("panier")
        .where('uid', isEqualTo: user!.uid)
        .get();
    doc.then((value) => value.docs.forEach((element) {
      liste = element.get("listeProduits");

      for(int j=0; j<liste.length; j++){
        var splitedWord = [];
        splitedWord = liste[j].toString().split("-");
        for(int i=0; i<globals.liste.length; i++){
          //print("==="+splitedWord[0]+"=="+globals.liste[i]["titre"]);
          if(splitedWord[0]==globals.liste[i]["titre"]){
            for(int z=0; z<int.parse(splitedWord[1]); z++) {
              listePanier.add(globals.liste[i]);
              total += int.parse(globals.liste[i]!["prix"].toString());
            }
            (context as Element).reassemble();
          }
        }
      }
    }));
    print(listePanier);
  }

  @override
  Widget build(BuildContext context) {
    (context as Element).reassemble();
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text("Mon panier"),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 40,
            color: Colors.greenAccent,
            child: Center(
              child: Text(
                "Total : "+total.toString()+" €",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: listePanier.length,
      itemBuilder: (BuildContext context, int index) {
        var article=listePanier[index];
        return Card(
          child: ListTile(
            title:
            Text(article!["titre"], style: TextStyle(fontSize: 30)),
            subtitle: Text('Taille ' + article["taille"] +"  "+ article["prix"].toString() + '€'),
            leading: Image(image: NetworkImage(article["image"]),),
            trailing: IconButton(icon: Icon(Icons.remove_shopping_cart_outlined), onPressed: (){
              total-=int.parse(article!["prix"].toString());
              (context as Element).reassemble();
              listePanier.remove(article);
              index = index-1;
              reset();
              (context as Element).reassemble();
            }),

          ),
        );
    }
    ),

    ],
    ),

    );

  }

  void reset(){
    (context as Element).reassemble();
  }
}
