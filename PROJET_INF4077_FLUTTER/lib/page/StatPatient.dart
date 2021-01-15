import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
    var data = [
      GraphiqueData("Adamaoua", 2, Colors.green),
      GraphiqueData("Centre", 1, Colors.green),
      GraphiqueData("Est", 1, Colors.green),
      GraphiqueData("Extrême-Nord", 1, Colors.green),
      GraphiqueData("Littoral", 1, Colors.green),
      GraphiqueData("Nord", 0, Colors.green),
      GraphiqueData("Nord-Ouest", 1, Colors.green),
      GraphiqueData("Ouest", 0, Colors.green),
      GraphiqueData("Sud", 1, Colors.green),
      GraphiqueData("Sud-Ouest", 3, Colors.green),
    ];
    var data1 = [
      GraphiqueData("Suspect", 7, Colors.red),
      GraphiqueData("Confirmé", 4, Colors.red),
    ];
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
