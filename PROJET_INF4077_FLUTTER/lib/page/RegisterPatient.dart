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
import 'package:testo/dbhelber/db_helper.dart';
import 'package:testo/models/patient.dart';

class RegisterPatient extends StatefulWidget {
  @override
  RegisterPatientState createState() => RegisterPatientState();
}

class RegisterPatientState extends State<RegisterPatient> {
  final formKey = new GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  TextEditingController nomPrenomcontroler = TextEditingController();
  TextEditingController telephonecontroler = TextEditingController();
  TextEditingController agecontroler = TextEditingController();
  TextEditingController statutcontroler = TextEditingController();
   List<String> statutlist = ["OUI", "NON"];
  String statut = "";
  Patient patient = Patient(
      age: 0,
      id: int.parse(
          "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().microsecond}"),
      nomPrenom: '',
      photo: '',
      statut: "",
      telephone: 0);

  DateTime value = DateTime.now();
  final format = DateFormat("yyyy-MM-dd HH:mm");

  String textErrorDateentre = "";
  bool testDateentre = false;
  DateTime dateentre = DateTime.now();

  File _imageFile;
  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      _imageFile = await redimentionImageEtCopie(imageFile);
      setState(() {
        _imageFile = _imageFile;
        //cest ici que je dois gerer le parametrage de limage
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildImage() {
    if (_imageFile != null) {
      return Image.file(
        _imageFile,
        fit: BoxFit.fill,
      );
    } else {
      return Text('Choisir une image', style: TextStyle(fontSize: 18.0));
    }
  }

  Widget _buildButtons() {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(height: 80.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildActionButton(
                key: Key('retake'),
                text: 'Photos',
                onPressed: () => captureImage(ImageSource.gallery),
              ),
              _buildActionButton(
                key: Key('upload'),
                text: 'Camera',
                onPressed: () => captureImage(ImageSource.camera),
              ),
            ]));
  }

  Widget _buildActionButton({Key key, String text, Function onPressed}) {
    return Expanded(
      child: FlatButton(
          key: key,
          child: Text(text, style: TextStyle(fontSize: 20.0)),
          shape: RoundedRectangleBorder(),
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: onPressed),
    );
  }

  Future<File> redimentionImageEtCopie(File imagefile) async {
    // Read a jpeg image from file.
    final filename = Patch2.basename(imagefile.path);
    patient.photo = filename;
    Image2.Image image =
        Image2.decodeImage(new Io.File(imagefile.path).readAsBytesSync());

    // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
    Image2.Image bonneImage = Image2.copyResize(image, width: 200, height: 200);
    String dir = (await getApplicationDocumentsDirectory()).path;
    // Save the thumbnail as a PNG.
    return new Io.File('$dir/$filename')
      ..writeAsBytesSync(Image2.encodePng(bonneImage));
  }

  clearName() {
    setState(() {
      _imageFile=null;
      nomPrenomcontroler.clear();
      nomPrenomcontroler.clear();
      telephonecontroler.clear();
      agecontroler.clear();
      statutcontroler.clear();
      statut="";
      patient = Patient(
          age: 0,
          id: int.parse(
              "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().microsecond}"),
          nomPrenom: '',
          photo: '',
          statut: "",
          telephone: 0);
    });
  }

  validate() {
    print(patient.tomap());
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      if (update) {
        dbHelper.updatePatient(patient);
      } else {
        dbHelper.savePatient(patient);
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
          //mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisSize: MainAxisSize.min,
          //verticalDirection: VerticalDirection.down,
          children: <Widget>[
            const SizedBox(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Flexible(
                  child: TextFormField(
                    controller: nomPrenomcontroler,
                    enabled: true,
                    keyboardType: TextInputType.text,
                    onChanged: (val) {
                      patient.nomPrenom = val.toUpperCase();
                    },

                    decoration: InputDecoration(labelText: 'nomPrenom'),
                    validator: (val) =>
                        val.length == 0 ? 'Entrer le nomPrenom' : null,
                    // onSaved: (val) => stock.nomPrenomstock = val,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Flexible(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    autofocus: true,
                    underline: Container(),
                    items: statutlist.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    hint: Text(
                      "Statut: $statut",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                    onChanged: (value) {
                    setState(() {
                      statut=value;
                          patient.setstatut=value;
                        });
                    },
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
                    controller: telephonecontroler,
                    enabled: true,
                    keyboardType: TextInputType.phone,
                    onChanged: (val) {
                      patient.telephone = int.tryParse(val);
                    },

                    decoration: InputDecoration(labelText: 'telephone'),
                    validator: (val) =>
                        val.length == 0 ? 'Entrer le telephone' : null,
                    // onSaved: (val) => stock.nomPrenomstock = val,
                  ),
                ),
                SizedBox(
              width: 10,
            ),
                    new Flexible(
                  child: TextFormField(
                    controller: agecontroler,
                    enabled: true,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      patient.age = int.tryParse(val);
                    },

                    decoration: InputDecoration(labelText: 'age'),
                    validator: (val) => val.length == 0 ? 'Entrer l age' : null,
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
                  child: _buildImage(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Flexible(
                    child: FlatButton(
                        onPressed: () {
                          captureImage(ImageSource.camera);
                        },
                        child: Icon(
                          Icons.add_a_photo,
                          size: 50,
                        ))),
                SizedBox(
                  width: 5,
                ),
                new Flexible(
                    child: FlatButton(
                        onPressed: () {
                          captureImage(ImageSource.gallery);
                        },
                        child: Icon(
                          Icons.add_photo_alternate,
                          size: 50,
                        ))),
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
                  onPressed: (){

if(patient.getstatut.length==0||patient.getphoto.length==0){


      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: Text('Oupss!!!'),
                                content: Text(
                                    'Statut ou photo manquant '),
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
                  child: Text("Valider"),
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

  SingleChildScrollView dataTable(List<Patient> patientList) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          //espace entre les colone
          columnSpacing: MediaQuery.of(context).size.width / 4,
          columns: [
            DataColumn(
              label: Text('NOM'),
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
                  DataCell(Text(patient2.nomPrenom), onTap: ()async {
                    _imageFile=File("${(await getApplicationDocumentsDirectory()).path}/${patient2.getphoto}");
                    setState(() {
                      update = true;
                      nomPrenomcontroler.text = patient2.nomPrenom;
                      
                      telephonecontroler.text =
                          patient2.gettelephone.toString();
                      agecontroler.text = patient2.getage.toString();
                      statutcontroler.text = patient2.getstatut;
                      patient=patient2;
                      statut=patient.getstatut;
                      
                    });
                  }),
                  DataCell(Text(patient2.gettelephone.toString()), onTap: ()async {
                    _imageFile=File("${(await getApplicationDocumentsDirectory()).path}/${patient2.getphoto}");
                    setState(() {
                      update = true;
                      nomPrenomcontroler.text = patient2.nomPrenom;
                      
                      telephonecontroler.text =
                          patient2.gettelephone.toString();
                      agecontroler.text = patient2.getage.toString();
                      statutcontroler.text = patient2.getstatut;
                      patient=patient2;
                      statut=patient.getstatut;
                      
                    });
                  }),
                  DataCell(Text(patient2.getage.toString()),  onTap: ()async {
                    _imageFile=File("${(await getApplicationDocumentsDirectory()).path}/${patient2.getphoto}");
                    setState(() {
                      update = true;
                      nomPrenomcontroler.text = patient2.nomPrenom;
                      
                      telephonecontroler.text =
                          patient2.gettelephone.toString();
                      agecontroler.text = patient2.getage.toString();
                      statutcontroler.text = patient2.getstatut;
                      patient=patient2;
                      statut=patient.getstatut;
                      
                    });
                  }),
                  DataCell(Text(patient2.getstatut.toString()),  onTap: ()async {
                    _imageFile=File("${(await getApplicationDocumentsDirectory()).path}/${patient2.getphoto}");
                    setState(() {
                      update = true;
                      nomPrenomcontroler.text = patient2.nomPrenom;
                      
                      telephonecontroler.text =
                          patient2.gettelephone.toString();
                      agecontroler.text = patient2.getage.toString();
                      statutcontroler.text = patient2.getstatut;
                      patient=patient2;
                      statut=patient.getstatut;
                      
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
    double longueur = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            'Gestion des Patients',
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
