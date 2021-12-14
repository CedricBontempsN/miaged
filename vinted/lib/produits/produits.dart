import 'dart:collection';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class Produits extends StatefulWidget {
  const Produits({Key? key}) : super(key: key);

  @override
  _ProduitsState createState() => _ProduitsState();
}

class _ProduitsState extends State<Produits> {
  List productList = List.empty();
  String title = "";
  String description = "";


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("produits").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? doc =
                      snapshot.data?.docs[index];
                  //print(snapshot.data!.docs.length.toString());
                  if(globals.liste.length <= 0) {
                    for (int j = 0; j <
                        int.parse(snapshot.data!.docs.length.toString()); j++) {
                      if (globals.liste.length > 0) {
                        for (int i = 0; i < globals.liste.length; i++) {
                          if (globals.liste[i]["titre"] ==
                              snapshot.data!.docs[j]!["titre"]) {
                            print("AAAAAAA");
                          }
                          else {
                            print("000000");
                            globals.liste.add(snapshot.data!.docs[j]);
                          }
                        }
                      }
                      else {
                        print("11111");
                        globals.liste.add(snapshot.data!.docs[j]);
                      }
                    }
                  }
                  //print(globals.liste);
                  return Card(
                    child: ListTile(
                      title:
                          Text(doc!["titre"], style: TextStyle(fontSize: 30)),
                      subtitle: Text('Taille ' + doc["taille"]),
                      trailing: Text(doc["prix"].toString() + '€'),
                      leading: Image(
                        image: NetworkImage(doc["image"]),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectCard(
                              choice: doc,
                            ),
                          ),
                        );
                      },
                    ),
                  );

                });
          }),
    );
  }
}


class SelectCard extends StatefulWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final QueryDocumentSnapshot<Object?> choice;

  @override
  _SelectCardState createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  User? user = FirebaseAuth.instance.currentUser;
  int quantity = 0;
  bool showElevatedButtonBadge = true;

  @override
  Widget build(BuildContext context) {
    QueryDocumentSnapshot<Object?> choice = widget.choice;
    const TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text(choice["titre"]),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: <Widget>[
                Image(
                  image: NetworkImage(choice["image"]),
                ),
                Text(
                  choice["titre"],
                ),
                Text(
                  "Taille" + choice["taille"],
                ),
                Text(
                  choice["prix"].toString() + " €",
                ),
                Badge(
                  position: BadgePosition.topEnd(top: 0, end: 3),
                  animationDuration: Duration(milliseconds: 300),
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(
                    quantity.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });

                      var doc = FirebaseFirestore.instance
                          .collection("panier")
                          .where('uid', isEqualTo: user!.uid)
                          .get();
                      doc.then((value) => value.docs.forEach((element) {
                            List<dynamic> productList = element.get("listeProduits");

                            if(productList.length > 0) {
                              for(int i=0; i<productList.length; i++){
                                print("===================");
                                var splitedWord = [];
                                splitedWord = productList[i].toString().split("-");
                                if(splitedWord[0]==choice["titre"]){
                                  int qtt = int.parse(splitedWord[1])+1;
                                  productList[i] = choice["titre"]+"-"+ qtt.toString();
                                  i = productList.length;
                                }
                                //Vérifie si notre article n'est pas présent dans la liste ET qu'on arrive à la fin de la liste ! sinon ajoute et continue la litre donc ajout en trop
                                else if(splitedWord[0]!=choice["titre"] && i==productList.length-1){
                                  productList.add(choice["titre"]+"-"+"1");
                                }
                              }
                            }
                            else{
                              productList.add(choice["titre"]+"-"+"1" );
                            }

                            element.reference.update({"listeProduits": productList}).then((value) => print("OK"));
                          }));

                    },
                    child: const Icon(Icons.add_shopping_cart),
                    backgroundColor: Colors.green,
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
