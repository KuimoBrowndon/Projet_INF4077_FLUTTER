import 'dart:async';
import 'dart:io' as io;
import 'package:intl/intl.dart';


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;

  //create database
  static const String DB_NAME = 'cholera.db';

//creation de la table vente

  String tablevente = 'vente';
  String venteColid = 'id';
  String venteColidProduit = 'idProduit';
  String venteColidCommande = 'idCommande';
  String venteColtype = 'type';
  String venteColquantite = 'quantite';
  String venteColprixTotal = 'prixTotal';
  String venteColDate = 'date';
  String venteColprixAchat = 'prixAchat';
  String venteColprixUnitaire = 'prixUnitaire';
  String venteColdevice = 'etat';
  String venteColidCreance = 'idCreance';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  // from NANA

  // use the initDb function to retrieve the directory where my DB is created
  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
   
    await db.execute(
        'CREATE TABLE $tablevente($venteColid INTEGER PRIMARY KEY AUTOINCREMENT,$venteColidProduit VARCHAR(100),$venteColidCommande VARCHAR(100),$venteColquantite INTEGER, $venteColprixUnitaire DOUBLE ,    $venteColprixAchat DOUBLE, $venteColtype VARCHAR(100), $venteColdevice VARCHAR(200), $venteColidCreance VARCHAR(200), $venteColprixTotal DOUBLE, $venteColDate DATETIME)');


 
  }

 

  // Create customer
  Future<int> saveClient(Client client) async {
    var dbClient = await db;
    return await dbClient.insert(tableClient, client.toMap());
  }

 





 


  Future<List<Depense>> getDepenses() async {
    Database db = await this.db;
    var result = await db.rawQuery('SELECT * FROM $tabledepense');

    List<Depense> ts = [];
    if (result.length > 0) {
      for (int i = 0; i < result.length; i++) {
        ts.add(Depense.fromMap(result[i]));
      }
    }
    return ts;
  }

 
 
 



  Future<int> deleteVersement(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableVersement, where: '$versementColID = ?', whereArgs: [id]);
  }
  Future<int> updateClient(Client client) async {
    var dbClient = await db;
    return await dbClient.update(tableClient, client.toMap(),
        where: '$clientColID_CLIENT = ?', whereArgs: [client.id]);
  }

 
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
