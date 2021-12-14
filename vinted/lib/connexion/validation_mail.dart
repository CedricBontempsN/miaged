import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vinted/connexion/connexion.dart';
import '../globals.dart' as globals;

class ValidationMail extends StatelessWidget {
  const ValidationMail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final homeButton = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
          onPressed: (){
            globals.email="";
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Connexion()));
          },
          child: Text(
            "Se connecter",
            textAlign: TextAlign.center,
          )
      ),
    );

    final mail = Text(
            "Un email a été envoyé à l adresse ${globals.email} Merci de cliquer sur le lien pour confirmer votre inscription.",
            textAlign: TextAlign.center,
    );

    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child:Column(
                children: <Widget>[
                  mail,
                  SizedBox(height:15),
                  homeButton,
                  ],
              ),
            ),
          ),
      ),
    );
  }
}
