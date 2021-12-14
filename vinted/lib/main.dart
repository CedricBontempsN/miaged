import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vinted/connexion/connexion.dart';
import 'package:vinted/home.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginButton = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Connexion()));
          },
          child: Text(
            "Connexion",
            textAlign: TextAlign.center,
          )
      ),
    );

    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(
          //child: HomePage(),
          child: Connexion(),
        ),
      ),
    );
  }
}