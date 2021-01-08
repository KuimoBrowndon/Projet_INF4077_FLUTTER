import 'dart:async';
import 'dart:io' as io;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testo/models/patient.dart' show Patient;

class DBHelper {
  static Database _db;

  //create database
  static const String DB_NAME = 'cholera.db';

  //creation de la table patient
  String tablepatient = 'patient';
  String patientColid = 'id';
  String patientColphoto = 'photo';
  String patientColidnomPrenom = 'idnomPrenom';
  String patientColage = 'age';
  String patientColtelephone = 'telephone';
  String patientColstatut = 'statut';

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
        'CREATE TABLE $tablepatient($patientColid INTEGER PRIMARY KEY AUTOINCREMENT,$patientColphoto VARCHAR(100),$patientColidnomPrenom VARCHAR(100),$patientColage INTEGER,$patientColtelephone INTEGER, $patientColstatut VARCHAR(100))');
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

  Future close() async {
    var dbPatient = await db;
    dbPatient.close();
  }
}
