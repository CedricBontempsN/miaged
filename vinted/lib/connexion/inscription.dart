import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vinted/connexion/userModel.dart';
import 'package:vinted/connexion/validation_mail.dart';
import '../globals.dart' as globals;


import '../home.dart';
import 'connexion.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();
  final TextEditingController nomController = new TextEditingController();
  final TextEditingController prenomController = new TextEditingController();
  final TextEditingController dateNaissanceController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();

  final RegExp mailRegexp = new RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[a-z]");
  final RegExp pwdRegexp = new RegExp(r'^.{6,}$');
  final RegExp prenomRegexp = new RegExp(r'^.{3,}$');
  @override
  Widget build(BuildContext context) {

    final prenom = TextFormField(
      autofocus: false,
      controller: prenomController,
      keyboardType: TextInputType.text,
      validator:(value){
        if(value!.isEmpty) {
          return("Merci de renseigner votre prenom");
        }
        if(!prenomRegexp.hasMatch(value)) {
          return ("Entrez un prenom correct");
        }
      },
      onSaved: (value){
        prenomController.text=value!;

      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle_outlined),
        contentPadding: EdgeInsets.fromLTRB(20,20,20,20),
        hintText: "Prénom",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    final nom = TextFormField(
      autofocus: false,
      controller: nomController,
      keyboardType: TextInputType.text,
      validator:(value){
        if(value!.isEmpty) {
          return("Merci de renseigner votre nom");
        }
        if(!prenomRegexp.hasMatch(value)) {
          return ("Entrez un nom correct");
        }
      },
      onSaved: (value){
        nomController.text=value!;

      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle_outlined),
        contentPadding: EdgeInsets.fromLTRB(20,20,20,20),
        hintText: "Nom",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    final dateNaissance = TextFormField(
      autofocus: false,
      controller: dateNaissanceController,
      keyboardType: TextInputType.datetime,
      onSaved: (value){
        dateNaissanceController.text=value!;

      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_today_rounded),
        contentPadding: EdgeInsets.fromLTRB(20,20,20,20),
        hintText: "Date de naissance",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    final email = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator:(value){
        if(value!.isEmpty) {
          return("Merci d'ajouter votre email");
        }
        if(!mailRegexp.hasMatch(value)) {
          return ("Merci d'ajouter un mail correct");
        }
        return null;
      },
      onSaved: (value){
        emailController.text=value!;

      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20,20,20,20),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator:(value){
        if(value!.isEmpty) {
          return("Merci de renseigner votre mot de passe");
        }
        if(!pwdRegexp.hasMatch(value)) {
          return ("Mot de passe trop court");
        }
      },
      onSaved: (value){
        passwordController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20,20,20,20),
        hintText: "Mot de passe",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      controller: confirmPasswordController,
      obscureText: true,
      validator:(value){
        if(value!.isEmpty) {
          return("Merci de renseigner votre mot de passe");
        }
        if(!pwdRegexp.hasMatch(value)) {
          return ("Mot de passe trop court");
        }
        if(confirmPasswordController.text!=passwordController.text){
          return ("Les mots de passe ne sont pas les mêmes");
        }
      },
      onSaved: (value){
        confirmPasswordController.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20,20,20,20),
        hintText: "Confirmer mot de passe",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    final loginButton = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
          onPressed: (){
            inscription(emailController.text, passwordController.text);
          },
          child: Text(
            "S'inscrire",
            textAlign: TextAlign.center,
          )
      ),
    );

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: _formkey,
                child:Column(
                  children: <Widget>[
                    prenom,
                    SizedBox(height:15),
                    nom,
                    SizedBox(height:15),
                    email,
                    SizedBox(height:15),
                    dateNaissance,
                    SizedBox(height:15),
                    password,
                    SizedBox(height:15),
                    confirmPassword,
                    SizedBox(height:25),
                    loginButton,
                    SizedBox(height:15),
                    Row(
                      children: <Widget>[
                        Text("Déjà inscrit ?"),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Connexion()));
                          },
                          child: Text(
                            "Se connecter",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

  void inscription(String email, String password) async {
    if(_formkey.currentState!.validate()){
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
            ajoutDetail()})
          .catchError((e){
            Fluttertoast.showToast(msg: e!.message);
          });
      await _auth.currentUser!.sendEmailVerification();
      globals.email = email;


      var panier = {'uid': _auth.currentUser!.uid, 'listeProduits': []};
      FirebaseFirestore.instance.collection("panier").add(panier);

    }
  }

  ajoutDetail() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user!.uid;
    userModel.prenom = prenomController.text;
    userModel.nom = nomController.text;
    userModel.dateNaiss = dateNaissanceController.text;

    await firebaseFirestore
      .collection("user")
      .doc(user.uid)
      .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Inscription réussite");
    globals.email = user.email!;

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ValidationMail()));

  }

}
