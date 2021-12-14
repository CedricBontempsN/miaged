import 'dart:core';

class UserModel{
    String? uid;
    String? email;
    String? prenom;
    String? nom;
    String? dateNaiss;
    String? ville;
    String? address;

    UserModel({this.uid, this.email, this.prenom, this.nom, this.dateNaiss, this.ville, this.address});

    factory UserModel.fromMap(map){
        return UserModel(
            uid: map['uid'],
            email: map['email'],
            prenom: map['prenom'],
            nom: map['nom'],
            dateNaiss: map['dateNaiss'],
            ville: map['ville'],
            address: map['address']
        );
    }

    Map<String, dynamic> toMap() {
        return {
            'uid': uid,
            'nom': nom,
            'prenom': prenom,
            'dateNaiss': dateNaiss,
            'email': email,
            'ville': ville,
            'address': address
        };
    }
}