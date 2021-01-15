import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testo/dbhelber/db_helper.dart';
import 'package:testo/models/patient.dart';
import 'package:testo/models/SuiviPatient.dart';

// ignore: must_be_immutable
class Suivi extends StatefulWidget {
  Patient patient;
  Suivi(this.patient);
  SuiviState createState() => SuiviState();
}

class SuiviState extends State<Suivi> {
  final formKey = new GlobalKey<FormState>();
  void initState() {
    super.initState();
  }

  TextEditingController dateHeurecontroler = TextEditingController();
  TextEditingController deshydratationcontroler = TextEditingController();
  TextEditingController sellescontroler = TextEditingController();
  TextEditingController vomissementscontroler = TextEditingController();
  TextEditingController diarrheecontroler = TextEditingController();

  SuiviPatient suivipatient = SuiviPatient(
      id: int.parse(
          "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().microsecond}"),
      idpatient: 0,
      dateHeure: DateTime.now(),
      deshydratation: 0,
      selles: 0,
      vomissements: 0,
      diarrhee: 0);

  DateTime value = DateTime.now();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  String textErrorDateentre = "";
  bool testDateentre = false;
  DateTime dateentre = DateTime.now();

  clearName() {
    setState(() {
      update = false;
      deshydratationcontroler.clear();
      sellescontroler.clear();
      vomissementscontroler.clear();
      diarrheecontroler.clear();
      suivipatient = SuiviPatient(
          id: int.parse(
              "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().microsecond}"),
          idpatient: 0,
          dateHeure: DateTime.now(),
          deshydratation: 0,
          selles: 0,
          vomissements: 0,
          diarrhee: 0);
    });
  }

  validate() {
    print(suivipatient.tomap());
    if (formKey.currentState.validate()) {
      suivipatient.idpatient = widget.patient.id;
      formKey.currentState.save();
      if (update) {
        suivipatient.setdateHeure = DateTime.now();
        dbHelper.updateSuiviPatient(suivipatient);
      } else {
        dbHelper.saveSuiviPatient(suivipatient);
      }
      clearName();
    }
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Flexible(
                  child: TextFormField(
                    controller: deshydratationcontroler,
                    enabled: true,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      suivipatient.deshydratation = int.tryParse(val);
                    },
                    decoration:
                        InputDecoration(labelText: 'Niveau de Déshydratation'),
                    validator: (val) => val.length == 0
                        ? "Entrer le niveau de déshydratation"
                        : int.tryParse(val) > 5
                            ? "Le niveau est compris entre 0 et 5"
                            : null,
                    // onSaved: (val) => stock.nomPrenomstock = val,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Flexible(
                  child: TextFormField(
                    controller: sellescontroler,
                    enabled: true,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      suivipatient.selles = int.tryParse(val);
                    },
                    decoration: InputDecoration(labelText: 'Niveau de selles'),
                    validator: (val) => val.length == 0
                        ? "Entrer le niveau de selles"
                        : int.tryParse(val) > 5
                            ? "Le niveau est compris entre 0 et 5"
                            : null,
                    // onSaved: (val) => stock.nomPrenomstock = val,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Flexible(
                  child: TextFormField(
                    controller: vomissementscontroler,
                    enabled: true,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      suivipatient.vomissements = int.tryParse(val);
                    },
                    decoration:
                        InputDecoration(labelText: 'Niveau de vomissements'),
                    validator: (val) => val.length == 0
                        ? "Entrer le niveau de vomissements"
                        : int.tryParse(val) > 5
                            ? "Le niveau est compris entre 0 et 5"
                            : null,
                    // onSaved: (val) => stock.nomPrenomstock = val,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Flexible(
                  child: TextFormField(
                    controller: diarrheecontroler,
                    enabled: true,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      suivipatient.diarrhee = int.tryParse(val);
                    },
                    decoration:
                        InputDecoration(labelText: 'Niveau de diarrhée'),
                    validator: (val) => val.length == 0
                        ? "Entrer le niveau de diarrhée"
                        : int.tryParse(val) > 5
                            ? "Le niveau est compris entre 0 et 5"
                            : null,
                    // onSaved: (val) => stock.nomPrenomstock = val,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  color: Color.fromRGBO(135, 206, 235, 1),
                  onPressed: () {
                    if (suivipatient.getdeshydratation > 5 ||
                        suivipatient.getselles > 5 ||
                        suivipatient.getvomissements > 5 ||
                        suivipatient.getdiarrhee > 5) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: Text('Oupss!!!'),
                                content: Text(
                                    'Les niveaux des paramètres doivent être entre 0 et 5'),
                                actions: <Widget>[
                                  new FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ]);
                          });
                    }
                    validate();
                  },
                  child: update ? Text("Mise a jour") : Text("Valider"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool update = false;
  bool charge = true;
  DBHelper dbHelper = DBHelper();

  SingleChildScrollView dataTable(List<SuiviPatient> suivipatientList) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          //espace entre les colonnes
          columnSpacing: MediaQuery.of(context).size.width / 6,
          columns: [
            DataColumn(
              label: Text('DATE ET HEURE'),
            ),
            DataColumn(
              label: Text('DESHYDRATATION'),
            ),
            DataColumn(
              label: Text('SELLES'),
            ),
            DataColumn(
              label: Text('VOMISSEMENTS'),
            ),
            DataColumn(
              label: Text('DIARRHEE'),
            ),
          ],
          rows: suivipatientList
              .map(
                (suivipatient2) => DataRow(cells: [
                  DataCell(Text(suivipatient2.getdateHeure.toString()),
                      onTap: () async {
                    setState(() {
                      update = true;
                      deshydratationcontroler.text =
                          suivipatient2.deshydratation.toString();
                      sellescontroler.text = suivipatient2.getselles.toString();
                      vomissementscontroler.text =
                          suivipatient2.getvomissements.toString();
                      diarrheecontroler.text =
                          suivipatient2.getdiarrhee.toString();
                      suivipatient = suivipatient2;
                    });
                  }),
                  DataCell(Text(suivipatient2.getdeshydratation.toString()),
                      onTap: () async {
                    setState(() {
                      update = true;
                      deshydratationcontroler.text =
                          suivipatient2.deshydratation.toString();
                      sellescontroler.text = suivipatient2.getselles.toString();
                      vomissementscontroler.text =
                          suivipatient2.getvomissements.toString();
                      diarrheecontroler.text =
                          suivipatient2.getdiarrhee.toString();
                      suivipatient = suivipatient2;
                    });
                  }),
                  DataCell(Text(suivipatient2.getselles.toString()),
                      onTap: () async {
                    setState(() {
                      update = true;
                      deshydratationcontroler.text =
                          suivipatient2.deshydratation.toString();
                      sellescontroler.text = suivipatient2.getselles.toString();
                      vomissementscontroler.text =
                          suivipatient2.getvomissements.toString();
                      diarrheecontroler.text =
                          suivipatient2.getdiarrhee.toString();
                      suivipatient = suivipatient2;
                    });
                  }),
                  DataCell(Text(suivipatient2.getvomissements.toString()),
                      onTap: () async {
                    setState(() {
                      update = true;
                      deshydratationcontroler.text =
                          suivipatient2.deshydratation.toString();
                      sellescontroler.text = suivipatient2.getselles.toString();
                      vomissementscontroler.text =
                          suivipatient2.getvomissements.toString();
                      diarrheecontroler.text =
                          suivipatient2.getdiarrhee.toString();
                      suivipatient = suivipatient2;
                    });
                  }),
                  DataCell(Text(suivipatient2.getdiarrhee.toString()),
                      onTap: () async {
                    setState(() {
                      update = true;
                      deshydratationcontroler.text =
                          suivipatient2.deshydratation.toString();
                      sellescontroler.text = suivipatient2.getselles.toString();
                      vomissementscontroler.text =
                          suivipatient2.getvomissements.toString();
                      diarrheecontroler.text =
                          suivipatient2.getdiarrhee.toString();
                      suivipatient = suivipatient2;
                    });
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
          future: dbHelper.getSuiviPatient(widget.patient.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return dataTable(snapshot.data);
            }

            if (snapshot.data == null || snapshot.data.length == 0) {
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
            "Suivi de ${widget.patient.getnomPrenom}",
            style: TextStyle(fontSize: 25.0),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[form(), list1()],
          ),
        ));
  }
}
