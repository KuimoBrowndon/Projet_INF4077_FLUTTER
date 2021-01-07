import 'package:flutter/material.dart';

import '../constants copy.dart';


class ContainerCardHomePage extends StatelessWidget {
  const ContainerCardHomePage({
    Key key,
    @required this.onTap,
    @required this.icon,
    @required this.libelle,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final IconData icon;
  final String libelle;

  @override
  Widget build(BuildContext context) {
    Color color = kPrimaryColor;
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: color,
          elevation: 4.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(
                icon,
                size: 50.0,
                color: Colors.white,
              ),
              new Text(
                libelle,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
