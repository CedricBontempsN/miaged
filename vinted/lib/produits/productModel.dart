import 'dart:core';

class ProductModel{
  String? pid;
  String? image;
  String? prix;
  String? taille;
  String? titre;

  ProductModel({this.pid, this.image, this.prix, this.taille, this.titre});

  factory ProductModel.fromMap(map){
    return ProductModel(
        pid: map['pid'],
        image: map['image'],
        prix: map['prix'],
        taille: map['taille'],
        titre: map['titre']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'image': image,
      'prix': prix,
      'taille': taille,
      'titre': titre
    };
  }
}