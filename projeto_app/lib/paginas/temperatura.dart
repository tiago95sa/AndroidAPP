import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Temperatura extends StatefulWidget {
  @override
  _Temperatura createState() => new _Temperatura();
}

class _Temperatura extends State<Temperatura> {
  
  bool _temperaturaAutomatica = false;
  int _sliderTemperatura = 5;

  @override
  void initState() {
    super.initState();
    _httpEstadoTemperaturaAutomatica();
    _httpEstadoSliderTemperatura();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Temepratura Interior'),
        ),
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(30.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Container(
                      width: 50.0,
                      height: 90.0,
                      child: Column(children: <Widget>[
                        SwitchListTile(
                            title: Text(
                              'Temperatura automática',
                              style: TextStyle(fontSize: 20),
                            ),
                            value: _temperaturaAutomatica,
                            onChanged: (bool valor) {
                              setState(() {
                                String state;
                                if (valor == true) {
                                  state = "ON";
                                } else {
                                  state = "OFF";
                                }
                                _httpTemperaturaAutomatica(state);
                                _temperaturaAutomatica = valor;
                              });
                            },
                            activeColor: Colors.blue)
                      ]),
                    ),
                    SizedBox(height: 50.0),
                    Container(
                      width: 50.0,
                      height: 150.0,
                      child: Column(children: <Widget>[
                        Align(
                            child: Text('Regular Temperatura Interior',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.left),
                            alignment: Alignment.bottomLeft),
                        Align(
                            child: Text(_sliderTemperatura.toString() + "ºC",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.left),
                            alignment: Alignment.topRight),
                        SizedBox(height: 10.0),
                        Slider(
                          min: 4,
                          max: 30,
                          divisions: 26,
                          value: _sliderTemperatura.toDouble(),
                          activeColor: Colors.blue,
                          onChanged: (newValue) {
                            setState(() {
                              _sliderTemperatura = newValue.toInt();
                            });
                          },
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Colors.blue,
                          child: Text('Confirmar'),
                          onPressed: () {
                            _httpSliderTemperatura(_sliderTemperatura);
                          },
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void _httpTemperaturaAutomatica(String estado) async {
    print(estado);
    String url = "http://169.254.155.190:8080/basicui/CMD?Test=";
    url = url + estado;
    print(url);
    http.Response response = await http.get(url);
    print(response.toString());
    print(response.statusCode);
  }

  void _httpSliderTemperatura(int percentagem) async {
    String url =
        "http://169.254.155.190:8080/basicui/CMD?Temperatura_Interior=";
    url = url + percentagem.toString();
    print(url);
    http.Response response = await http.get(url);
    print(response.statusCode);
  }

  void _httpEstadoTemperaturaAutomatica() async {
    String url = "http://169.254.155.190:8080/rest/items/Test/state";
    http.Response response = await http.get(url);

    if (response.body == 'ON') {
      setState(() {
        _temperaturaAutomatica = true;
      });
    } else {
      setState(() {
        _temperaturaAutomatica = false;
      });
    }
  }

  void _httpEstadoSliderTemperatura() async {
    String url =
        "http://169.254.155.190:8080/rest/items/Temperatura_Interior/state";
    http.Response response = await http.get(url);

    String c = response.body;
    setState(() {
      _sliderTemperatura = int.parse(c);
    });
  }
}
