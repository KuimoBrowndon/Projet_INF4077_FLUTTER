import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Patch2;
import 'dart:io' as Io;
import 'package:image/image.dart' as Image2;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testo/models/patient.dart';

class LocalisationUser extends StatefulWidget {
  @override
  LocalisationUserState createState() => LocalisationUserState();
}

class LocalisationUserState extends State<LocalisationUser> {
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
            "Localiser l'utilisateur",
            style: TextStyle(fontSize: 25.0),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
        ));
  }
}
