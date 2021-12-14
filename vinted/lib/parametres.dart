import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vinted/commun.dart';

class Parametres extends StatelessWidget {
  const Parametres({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Commun(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Test", textAlign: TextAlign.left, style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }
}