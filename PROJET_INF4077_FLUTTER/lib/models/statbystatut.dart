import 'package:flutter/material.dart';

//Timestamp myTimeStamp = Timestamp.fromDate(date);
//Timestamp t = document['timeFieldName'];
//DateTime d = t.toDate();
//print(d.toString());
class Statbystatut {
  String statut;
  int nbre;

  Statbystatut({
    @required this.statut,
    @required this.nbre,
  });

  //les getters
  String get getstatut => this.statut;
  int get getnbre => this.nbre;

  //les setters
  set setstatut(String newobj) {
    this.statut = newobj;
  }

  set setnbre(int newobj) {
    this.nbre = newobj;
  }

  //mappage
  Map<String, dynamic> tomap() {
    var map = Map<String, dynamic>();
    map['statut'] = this.statut;
    map['nbre'] = nbre;
    return map;
  }

  //demapage
  Statbystatut.frommap(Map<String, dynamic> map) {
    this.statut = map['statut'];
    this.nbre = map['nbre'];
  }
}
