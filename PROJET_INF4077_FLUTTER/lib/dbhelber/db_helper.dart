import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testo/models/patient.dart' show Patient;
import 'package:testo/models/SuiviPatient.dart' show SuiviPatient;
import 'package:testo/models/statbystatut.dart' show Statbystatut;
import 'package:testo/models/statbyregion.dart' show Statbyregion;

class DBHelper {
  static Database _db;

  //create database
  static const String DB_NAME = 'cholera.db';

  //creation de la table patient
  String tablepatient = 'patient';
  String patientColid = 'id';
  String patientColphoto = 'photo';
  String patientColidnomPrenom = 'nomPrenom';
  String patientColsexe = 'sexe';
  String patientColregion = 'region';
  String patientColage = 'age';
  String patientColtelephone = 'telephone';
  String patientColstatut = 'statut';

  //creation de la table SuiviPatient
  String tablesuivipatient = 'SuiviPatient';
  String suivipatientColid = 'id';
  String suivipatientColidpatient = 'idpatient ';
  String suivipatientColdateHeure = 'dateHeure';
  String suivipatientColdeshydratation = 'deshydratation';
  String suivipatientColselles = 'selles';
  String suivipatientColvomissements = 'vomissements';
  String suivipatientColdiarrhee = 'diarrhee';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  // use the initDb function to retrieve the directory where my DB is created
  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tablepatient($patientColid INTEGER PRIMARY KEY AUTOINCREMENT,$patientColphoto VARCHAR(100),$patientColidnomPrenom VARCHAR(100),$patientColsexe VARCHAR(100),$patientColregion VARCHAR(100),$patientColage INTEGER,$patientColtelephone INTEGER, $patientColstatut VARCHAR(100))');
    await db.execute(
        'CREATE TABLE $tablesuivipatient($suivipatientColid INTEGER PRIMARY KEY AUTOINCREMENT,$suivipatientColidpatient INTEGER,$suivipatientColdateHeure DATETIME,$suivipatientColdeshydratation INTEGER,$suivipatientColselles INTEGER, $suivipatientColvomissements INTEGER, $suivipatientColdiarrhee INTEGER)');
  }

  // Create patient
  Future<int> savePatient(Patient patient) async {
    var dbPatient = await db;
    return await dbPatient.insert(tablepatient, patient.tomap());
  }

  Future<List<Patient>> getPatients() async {
    Database db = await this.db;
    var result = await db.rawQuery('SELECT * FROM $tablepatient');
    List<Patient> ts = [];
    if (result.length > 0) {
      for (int i = 0; i < result.length; i++) {
        ts.add(Patient.frommap(result[i]));
      }
    }
    return ts;
  }

  Future<int> deletePatient(int id) async {
    var dbPatient = await db;
    return await dbPatient
        .delete(tablepatient, where: '$patientColid = ?', whereArgs: [id]);
  }

  Future<int> updatePatient(Patient patient) async {
    var dbPatient = await db;
    return await dbPatient.update(tablepatient, patient.tomap(),
        where: '$patientColid = ?', whereArgs: [patient.id]);
  }

  // Create SuiviPatient
  Future<int> saveSuiviPatient(SuiviPatient suiviPatient) async {
    var dbPatient = await db;
    return await dbPatient.insert(tablesuivipatient, suiviPatient.tomap());
  }

  Future<List<SuiviPatient>> getSuiviPatient(int idPatient) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $tablesuivipatient  WHERE $suivipatientColidpatient='$idPatient'");
    List<SuiviPatient> ts = [];
    if (result.length > 0) {
      for (int i = 0; i < result.length; i++) {
        ts.add(SuiviPatient.frommap(result[i]));
      }
    }
    return ts;
  }

  Future<int> deleteSuiviPatient(int id) async {
    var dbPatient = await db;
    return await dbPatient.delete(tablesuivipatient,
        where: '$suivipatientColid = ?', whereArgs: [id]);
  }

  Future<int> updateSuiviPatient(SuiviPatient suivipatient) async {
    var dbPatient = await db;
    return await dbPatient.update(tablesuivipatient, suivipatient.tomap(),
        where: '$suivipatientColid = ?', whereArgs: [suivipatient.id]);
  }

  Future<List<Statbystatut>> getStatByStatut() async {
    Database db = await this.db;
    var result = await db.rawQuery(
        'SELECT statut, COUNT(*) as nbre FROM $tablepatient GROUP BY statut ORDER BY statut ASC');
    List<Statbystatut> ts = [];
    if (result.length > 0) {
      for (int i = 0; i < result.length; i++) {
        ts.add(Statbystatut.frommap(result[i]));
      }
    }
    return ts;
  }

  Future<List<Statbyregion>> getStatByRegion() async {
    Database db = await this.db;
    var result = await db.rawQuery(
        'SELECT region, COUNT(*) as nbre FROM $tablepatient GROUP BY region ORDER BY region ASC');
    List<Statbyregion> ts = [];
    if (result.length > 0) {
      for (int i = 0; i < result.length; i++) {
        ts.add(Statbyregion.frommap(result[i]));
      }
    }
    return ts;
  }

  Future close() async {
    var dbPatient = await db;
    dbPatient.close();
  }
}
