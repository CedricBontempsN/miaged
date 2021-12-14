import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vinted/home.dart';
import '../globals.dart' as globals;
import 'inscription.dart';

class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {

  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final RegExp mailRegexp = new RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[a-z]");
  final RegExp pwdRegexp = new RegExp(r'^.{6,}$');

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

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
      validator:(value){
        if(value!.isEmpty) {
          return("Merci de renseigner votre mot de passe");
        }
        if(!pwdRegexp.hasMatch(value)) {
          return ("Mot de passe trop court");
        }
      },
      obscureText: true,
      onSaved: (value){
        passwordController.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20,20,20,20),
        hintText: "Mot de passe",
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
            connexion(emailController.text, passwordController.text);
            },
          child: Text(
            "Connexion",
            textAlign: TextAlign.center,
          )
      ),
    );

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
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
                    email,
                    SizedBox(height:15),
                    password,
                    SizedBox(height:25),
                    loginButton,
                    SizedBox(height:15),
                    Row(
                      children: <Widget>[
                        Text("Pas encore inscrit ?"),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Inscription()));
                          },
                          child: Text(
                            "Creer un compte",
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

  void connexion(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      if (_formkey.currentState!.validate()) {
        await _auth.signInWithEmailAndPassword(email: email, password: password)
            .then((uid) =>
        {
          if (_auth.currentUser!.emailVerified) {
            globals.pwdLength = password.length,
            globals.liste=[],
            Fluttertoast.showToast(msg: "Connexion effectuée"),
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()))
          }
          else
            {
              Fluttertoast.showToast(
                  msg: "Merci de valider votre email pour vous connecter"),
            }
        }).catchError((e) {
          Fluttertoast.showToast(msg: "Identifiant ou mot de passe incorrect");
        });
      }
    }
  }
}
