import 'package:flutter/material.dart';

//Timestamp myTimeStamp = Timestamp.fromDate(date);
//Timestamp t = document['timeFieldName'];
//DateTime d = t.toDate();
//print(d.toString());
class Patient {
  int id;
  String photo;
  String nomPrenom;
  int age;
  int telephone;
  String statut;

  Patient({
    @required this.id,
    @required this.photo,
    @required this.nomPrenom,
    @required this.age,
    @required this.telephone,
    @required this.statut,
  });

  //les getters
  int get getid => this.id;
  String get getphoto => this.photo;
  String get getnomPrenom => this.nomPrenom;
  int get getage => this.age;
  int get gettelephone => this.telephone;
  String get getstatut => this.statut;

  //les setters
  set setid(int newobj) {
    this.id = newobj;
  }

  set setphoto(String newobj) {
    this.photo = newobj;
  }

  set setnomPrenom(String newobj) {
    this.nomPrenom = newobj;
  }

  set setage(int newobj) {
    this.age = newobj;
  }

  set settelephone(int newobj) {
    this.telephone = newobj;
  }

  set setstatut(String newobj) {
    this.statut = newobj;
  }

  //mappage de mon client
  Map<String, dynamic> tomap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['photo'] = this.photo;
    map['nomPrenom'] = this.nomPrenom;
    map['age'] = this.age;
    map['telephone'] = this.telephone;
    map['statut'] = this.statut;
    return map;
  }

  //demapage de mon client
  Patient.frommap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.photo = map['photo'];
    this.nomPrenom = map['nomPrenom'];
    this.age = map['age'];
    this.telephone = map['telephone'];
    this.statut = map['statut'];
  }
}
