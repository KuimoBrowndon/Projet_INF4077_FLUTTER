import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testo/dbhelber/db_helper.dart';
import 'package:testo/models/patient.dart';
import 'package:testo/page/Suivi.dart';

class PatienListe extends StatefulWidget {
  @override
  PatienListeState createState() => PatienListeState();
}

class PatienListeState extends State<PatienListe> {
  void initState() {
    super.initState();
  }

  DateTime value = DateTime.now();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  String textErrorDateentre = "";
  bool testDateentre = false;
  DateTime dateentre = DateTime.now();

  bool update = false;
  bool charge = true;
  DBHelper dbHelper = DBHelper();

  SingleChildScrollView dataTable(List<Patient> patientList) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          //espace entre les colonnes
          columnSpacing: MediaQuery.of(context).size.width / 6,
          columns: [
            DataColumn(
              label: Text('NOM ET PRENOM'),
            ),
            DataColumn(
              label: Text('SEXE'),
            ),
            DataColumn(
              label: Text('REGION'),
            ),
            DataColumn(
              label: Text('TELEPHONE'),
            ),
            DataColumn(
              label: Text('AGE'),
            ),
            DataColumn(
              label: Text('STATUT'),
            ),
          ],
          rows: patientList
              .map(
                (patient2) => DataRow(cells: [
                  DataCell(Text(patient2.nomPrenom), onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Suivi(patient2)));
                  }),
                  DataCell(Text(patient2.getsexe.toString()), onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Suivi(patient2)));
                  }),
                  DataCell(Text(patient2.getregion.toString()),
                      onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Suivi(patient2)));
                  }),
                  DataCell(Text(patient2.gettelephone.toString()),
                      onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Suivi(patient2)));
                  }),
                  DataCell(Text(patient2.getage.toString()), onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Suivi(patient2)));
                  }),
                  DataCell(Text(patient2.getstatut.toString()),
                      onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Suivi(patient2)));
                  }),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  list1() {
    return Container(
      child: FutureBuilder(
          future: dbHelper.getPatients(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return dataTable(snapshot.data);
            }
            if (null == snapshot.data || snapshot.data.length == 0) {
              return Text("Aucune information disponible");
            }
            return CircularProgressIndicator();
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            'Suivi des Patients',
            style: TextStyle(fontSize: 25.0),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[list1()],
          ),
        ));
  }
}
