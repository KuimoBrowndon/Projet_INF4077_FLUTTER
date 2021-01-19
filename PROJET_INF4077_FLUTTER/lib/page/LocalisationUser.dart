import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class LocalisationUser extends StatefulWidget {
  @override
  LocalisationUserState createState() => LocalisationUserState();
}

class LocalisationUserState extends State<LocalisationUser> {
  final formKey = new GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  MapController controller = new MapController();

  getPermission() async {
    final GeolocationResult result =
        await Geolocation.requestLocationPermission(
            permission: const LocationPermission(
                android: LocationPermissionAndroid.fine,
                ios: LocationPermissionIOS.always));
    return result;
  }

  getLocation() {
    return getPermission().then((result) async {
      if (result.isSuccessful) {
        var coords =
            // ignore: await_only_futures
            await Geolocation.currentLocation(accuracy: LocationAccuracy.best);
        return coords;
      }
    });
  }

  buildMap() {
    getLocation().then((response) {
      if (response.isSuccessful) {
        response.listen((value) {
          controller.move(
              new LatLng(value.Location.latitude, value.location.longitude),
              15.0);
        });
      }
    });
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
        /*body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Localiser',
                style: TextStyle(color: Colors.indigo, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );*/
        body: new FlutterMap(
            mapController: controller,
            options: new MapOptions(center: buildMap(), minZoom: 5.0),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
            ]));
  }
}
