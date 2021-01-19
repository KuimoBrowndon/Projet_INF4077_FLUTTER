import 'package:flutter/material.dart';

class Statbyregion {
  String region;
  int nbre;

  Statbyregion({
    @required this.region,
    @required this.nbre,
  });

  //les getters
  String get getregion => this.region;
  int get getnbre => this.nbre;

  //les setters
  set setregion(String newobj) {
    this.region = newobj;
  }

  set setnbre(int newobj) {
    this.nbre = newobj;
  }

  //mappage
  Map<String, dynamic> tomap() {
    var map = Map<String, dynamic>();
    map['region'] = this.region;
    map['nbre'] = nbre;
    return map;
  }

  //demapage
  Statbyregion.frommap(Map<String, dynamic> map) {
    this.region = map['region'];
    this.nbre = map['nbre'];
  }
}
