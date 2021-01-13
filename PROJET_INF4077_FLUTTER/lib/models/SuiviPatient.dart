import 'package:flutter/material.dart';

//Timestamp myTimeStamp = Timestamp.fromDate(date);
//Timestamp t = document['timeFieldName'];
//DateTime d = t.toDate();
//print(d.toString());
class SuiviPatient {
  int id;
  int idpatient;
  DateTime dateHeure;
  int deshydratation;
  int selles;
  int vomissements;
  int diarrhee;

  SuiviPatient({
    @required this.id,
    @required this.idpatient,
    @required this.dateHeure,
    @required this.deshydratation,
    @required this.selles,
    @required this.vomissements,
    @required this.diarrhee,
  });

  //les getters
  int get getid => this.id;
  int get getidpatient => this.idpatient;
  DateTime get getdateHeure => this.dateHeure;
  int get getdeshydratation => this.deshydratation;
  int get getselles => this.selles;
  int get getvomissements => this.vomissements;
  int get getdiarrhee => this.diarrhee;

  //les setters
  set setid(int newobj) {
    this.id = newobj;
  }

  set setidpatient(int newobj) {
    this.id = newobj;
  }

  set setdateHeure(DateTime newobj) {
    this.dateHeure = newobj;
  }

  set setdeshydratation(int newobj) {
    this.deshydratation = newobj;
  }

  set setselles(int newobj) {
    this.selles = newobj;
  }

  set setvomissements(int newobj) {
    this.vomissements = newobj;
  }

  set setdiarrhee(int newobj) {
    this.diarrhee = newobj;
  }

  //mappselles de mon client
  Map<String, dynamic> tomap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['idpatient'] = this.idpatient;
    map['dateHeure'] = this.dateHeure.toString();
    map['deshydratation'] = this.deshydratation;
    map['selles'] = this.selles;
    map['vomissements'] = this.vomissements;
    map['diarrhee'] = this.diarrhee;
    return map;
  }

  //demapselles de mon client
  SuiviPatient.frommap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.idpatient = map['idpatient'];
    this.dateHeure = DateTime.parse(map['dateHeure'].toString());
    this.deshydratation = map['deshydratation'];
    this.selles = map['selles'];
    this.vomissements = map['vomissements'];
    this.diarrhee = map['diarrhee'];
  }
}
