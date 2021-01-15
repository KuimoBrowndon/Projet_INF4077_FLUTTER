import 'package:flutter/material.dart';
import 'package:testo/components/container_card_homepage.dart';
import '../constants copy.dart';
import 'RegisterPatient.dart';
import 'StatPatient.dart';
import 'LocalisationUser.dart';
import 'login.dart';
import 'PatienListe.dart';
import 'SendSms.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  Size size;
  Color color;
  Widget build(BuildContext context) {
    this.color = kPrimaryColor;
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // Use a centerTitle to set the text at the center of appBar
        centerTitle: true,
        title: new Text('Accueil ',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        backgroundColor: color,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Container(
              // definition of slide screen
              height: size.height / 1,
            ),
            //),
          ),
          // creation of a container to wrap all my cards
          Container(
            margin: EdgeInsets.only(top: 60.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: <Widget>[
                  ContainerCardHomePage(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPatient()));
                      },
                      icon: Icons.people,
                      libelle: 'Patients'),
                  ContainerCardHomePage(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PatienListe()));
                      },
                      icon: Icons.supervised_user_circle,
                      libelle: 'Suivi des Patients'),
                  ContainerCardHomePage(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StatPatient()));
                      },
                      icon: Icons.bar_chart,
                      libelle: 'Statistiques'),
                  ContainerCardHomePage(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocalisationUser()));
                      },
                      icon: Icons.location_city,
                      libelle: 'Localisation'),
                  ContainerCardHomePage(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SendSms()));
                      },
                      icon: Icons.sms,
                      libelle: 'SMS'),
                  ContainerCardHomePage(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      icon: Icons.logout,
                      libelle: 'Déconnexion'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
