
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vinted/connexion/userModel.dart';

import 'commun.dart';
import 'connexion/connexion.dart';
import 'globals.dart' as globals;

class Compte extends StatefulWidget {
  const Compte({Key? key}) : super(key: key);

  @override
  _CompteState createState() => _CompteState();
}

class _CompteState extends State<Compte> {


  final _formkey = GlobalKey<FormState>();
  TextEditingController nomController = new TextEditingController();
  TextEditingController prenomController = new TextEditingController();
  TextEditingController dateNaissanceController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController villeController = new TextEditingController();
  TextEditingController adresseController = new TextEditingController();

  TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();

  final RegExp mailRegexp = new RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[a-z]");
  final RegExp pwdRegexp = new RegExp(r'^.{6,}$');
  final RegExp prenomRegexp = new RegExp(r'^.{3,}$');
  final _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.reference().child("user");
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedUser = UserModel();
  String ville = "ville";
  String address="address";
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("user").doc(user!.uid).get().then((
        value) {
      this.loggedUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if(this.loggedUser.email!=null){
      emailController.text = loggedUser.email!;
    }
    if(loggedUser.ville != null){
      this.ville=loggedUser.ville!;
    }
    else{
      this.ville="ville";
    }
    if(loggedUser.address!=null){
      this.address=loggedUser.address!;
    }
    else{
      this.address="address";
    }
    String passwordText = "";
    for(int i=0; i<globals.pwdLength; i++){
      passwordText+="*";
    }

    final prenom = TextFormField(
      autofocus: false,
      controller: prenomController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Merci de renseigner votre prenom");
        }
        if (!prenomRegexp.hasMatch(value)) {
          return ("Entrez un prenom correct");
        }
      },
      onSaved: (value) {
        prenomController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: "${loggedUser.prenom}",
        prefixIcon: Icon(Icons.account_circle_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    final nom = TextFormField(
      autofocus: false,
      controller: nomController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Merci de renseigner votre nom");
        }
        if (!prenomRegexp.hasMatch(value)) {
          return ("Entrez un nom correct");
        }
      },
      onSaved: (value) {
        nomController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: "${loggedUser.nom}",
        prefixIcon: Icon(Icons.account_circle_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    final dateNaissance = TextFormField(
      autofocus: false,
      controller: dateNaissanceController,
      keyboardType: TextInputType.datetime,
      onSaved: (value) {
        dateNaissanceController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_today_rounded),
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        hintText: "${loggedUser.dateNaiss}",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    final email = TextFormField(
      //enabled: false,
      readOnly: true,
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Merci d'ajouter votre email");
        }
        if (!mailRegexp.hasMatch(value)) {
          return ("Merci d'ajouter un mail correct");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        //hintText: "${loggedUser.email}",
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    final password = TextFormField(
      enabled: false,
      autofocus: false,
      controller: passwordController,
      obscureText: true,

      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: passwordText,
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    final ville = TextFormField(
      autofocus: false,
      controller: villeController,
      keyboardType: TextInputType.text,

      onSaved: (value) {
        villeController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        hintText: this.ville,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    final adresse = TextFormField(
      autofocus: false,
      controller: adresseController,
      keyboardType: TextInputType.text,

      onSaved: (value) {
        adresseController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        hintText: this.address,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    final logoutButton = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
          onPressed: () {
            _logout(context);
          },
          child: Text(
            "Se déconnecter",
            textAlign: TextAlign.center,
          )
      ),
    );

    final saveButton = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
          onPressed: () {
            _enregistrerModifications();
          },
          child: Text(
            "Enregistrer",
            textAlign: TextAlign.center,
          )
      ),
    );

    return Scaffold(
      body:  Center(
    child: SingleChildScrollView(
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formkey,
          child:Column(
            children: <Widget>[
              email,
              SizedBox(height:15),
              password,
              SizedBox(height:15),
              nom,
              SizedBox(height:15),
              prenom,
              SizedBox(height:15),
              dateNaissance,
              SizedBox(height:15),
              ville,
              SizedBox(height:25),
              adresse,
              SizedBox(height:25),
              saveButton,
              SizedBox(height:15),
              logoutButton,
              SizedBox(height:15),
            ],
          ),
        ),
      ),
    ),
    ),
    ),
      bottomNavigationBar: Commun(),
    );
  }
  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Connexion()));
  }

  Future<void> _enregistrerModifications() async {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;
      UserModel userModel = UserModel();

      userModel.email = user!.email;
      userModel.uid = user!.uid;
      if(prenomController.text!=""){
        userModel.prenom = prenomController.text;
      }
      else{
        userModel.prenom =loggedUser.prenom;
      }
      if(nomController.text!=""){
        userModel.nom = nomController.text;
      }
      else{
        userModel.nom =loggedUser.nom;
      }
      if(dateNaissanceController.text!=""){
        userModel.dateNaiss = dateNaissanceController.text;
      }
      else{
        userModel.dateNaiss =loggedUser.dateNaiss;
      }
      if(villeController.text!=""){
        userModel.ville = villeController.text;
      }
      else{
        userModel.ville =loggedUser.ville;
      }
      if(adresseController.text!=""){
        userModel.address = adresseController.text;
      }
      else{
        userModel.address =loggedUser.address;
      }

      await firebaseFirestore
          .collection("user")
          .doc(user.uid)
          .set(userModel.toMap());
      Fluttertoast.showToast(msg: "Modifications enregistrées");
      globals.email = user.email!;
  }
}

