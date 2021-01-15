import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testo/models/patient.dart';

// ignore: must_be_immutable
class Sms extends StatefulWidget {
  Patient patient;
  Sms(this.patient);
  SmsState createState() => SmsState();
}

class SmsState extends State<Sms> {
  final formKey = new GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          'SMS à ${widget.patient.getnomPrenom}',
          style: TextStyle(fontSize: 25.0),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Envoie des SMS',
                style: TextStyle(color: Colors.indigo, fontSize: 25),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                'à un patient',
                style: TextStyle(color: Colors.indigo, fontSize: 21),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
