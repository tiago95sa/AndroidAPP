import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Vestuario extends StatefulWidget {
  @override
  _Vestuario createState() => new _Vestuario();
}

class _Vestuario extends State<Vestuario> {
  Geolocator geolocator = Geolocator();
  Position userLocation;

  @override
  initState() {
    super.initState();
    _obterLocalizacao().then((valor) {
      setState(() {
        userLocation = valor;
        print(userLocation.longitude);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vestuario')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Obter Localizacao'),
              onPressed: () {
                _obterLocalizacao().then(
                  (valor) {
                    setState(() {
                      userLocation = valor;
                      _obterTemperaturaParaLocalizacao(userLocation);
                    });
                  },
                );
              },
            ),
            userLocation == null
                ? CircularProgressIndicator()
                : Text("Latitude=" + userLocation.latitude.toString() + " Longitude=" + userLocation.longitude.toString()),
            
          ],
        ),
      ),
    );
  }

  Future<Position> _obterLocalizacao() async {
    var currentLocation;

    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }

    return currentLocation;
  }

  void _obterTemperaturaParaLocalizacao(Position pos) async {
    String url =
        'https://api.darksky.net/forecast/96380833c00670953f91c676bdbfe7c6/';
    url = url +
        pos.latitude.toString() +
        ',' +
        pos.longitude.toString() +
        '?units=si';

    http.Response response = await http.get(url);

    Map<String, dynamic> responseData = json.decode(response.body);
    
    
    var responseData2 = responseData['daily']['data'][0];
    
    Map<String, dynamic> res = responseData2;

    print(res['summary']);
    

  }
}
