import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:testo/dbhelber/db_helper.dart';
import 'package:testo/models/statbyregion.dart' show Statbyregion;
import 'package:testo/models/statbystatut.dart' show Statbystatut;

class StatPatient extends StatefulWidget {
  @override
  StatPatientState createState() => StatPatientState();
}

class StatPatientState extends State<StatPatient> {
  final formKey = new GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data;
    var data1;
    if (data == null) {
      data = [
        GraphiqueData("Adamaoua", 0, Colors.green),
        GraphiqueData("Centre", 12, Colors.green),
        GraphiqueData("Est", 5, Colors.green),
        GraphiqueData("Extrême-Nord", 3, Colors.green),
        GraphiqueData("Littoral", 6, Colors.green),
        GraphiqueData("Nord", 2, Colors.green),
        GraphiqueData("Nord-Ouest", 3, Colors.green),
        GraphiqueData("Ouest", 5, Colors.green),
        GraphiqueData("Sud", 2, Colors.green),
        GraphiqueData("Sud-Ouest", 0, Colors.green),
      ];
    }
    if (data1 == null) {
      data1 = [
        GraphiqueData("Confirmé", 15, Colors.red),
        GraphiqueData("Suspect", 23, Colors.red),
      ];
    }
    var series = [
      charts.Series(
          domainFn: (GraphiqueData GraphiqueData, _) => GraphiqueData.nature,
          measureFn: (GraphiqueData GraphiqueData, _) => GraphiqueData.valeur,
          colorFn: (GraphiqueData GraphiqueData, _) => GraphiqueData.color,
          id: "GraphiqueData",
          data: data,
          labelAccessorFn: (GraphiqueData GraphiqueData, _) =>
              '${GraphiqueData.nature} : ${GraphiqueData.valeur.toString()}')
    ];
    var series1 = [
      charts.Series(
          domainFn: (GraphiqueData GraphiqueData, _) => GraphiqueData.nature,
          measureFn: (GraphiqueData GraphiqueData, _) => GraphiqueData.valeur,
          colorFn: (GraphiqueData GraphiqueData, _) => GraphiqueData.color,
          id: "GraphiqueData",
          data: data1,
          labelAccessorFn: (GraphiqueData GraphiqueData, _) =>
              '${GraphiqueData.nature} : ${GraphiqueData.valeur.toString()}')
    ];
    var chart = charts.BarChart(
      series,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
    );
    var chart1 = charts.PieChart(
      series1,
      defaultRenderer: charts.ArcRendererConfig(
          arcRendererDecorators: [charts.ArcLabelDecorator()], arcWidth: 80),
      animate: true,
    );

    return Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            'Statistiques',
            style: TextStyle(fontSize: 25.0),
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    'Statistiques par région',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: 275,
                    child: chart,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Statistiques par statut des patients',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: 275,
                    child: chart1,
                  ),
                ],
              ),
            )));
  }
}

class GraphiqueData {
  final String nature;
  final int valeur;
  final charts.Color color;

  GraphiqueData(this.nature, this.valeur, Color color)
      : this.color = charts.Color(
            g: color.green, r: color.red, a: color.alpha, b: color.blue);
}
