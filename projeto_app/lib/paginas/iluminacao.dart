import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Iluminacao extends StatefulWidget {
  @override
  _Iluminacao createState() => new _Iluminacao();
}

class _Iluminacao extends State<Iluminacao> {
  int sliderPersiana = 0;
  int sliderLampada = 0;
  bool _iluminacaoAutomatica = false;

  @override
  void initState(){
    super.initState();
    _httpEstadoIluminacaoAutomatica();
    _httpEstadoLampada();
    _httpEstadoPersiana();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Iluminacao'),
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
                              'Iluminação Automática',
                              style: TextStyle(fontSize: 20),
                            ),
                            value: _iluminacaoAutomatica,
                            onChanged: (valor) {
                              setState(() {
                                String state;
                                if (valor == true) {
                                  state = "ON";
                                } else {
                                  state = "OFF";
                                }
                                _httpIluminacaoAutomatica(state);
                                _iluminacaoAutomatica = valor;
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
                            child: Text('Luminosidade',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.left),
                            alignment: Alignment.bottomLeft),
                        Align(
                            child: Text(sliderLampada.toString() + "%",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.left),
                            alignment: Alignment.topRight),
                        SizedBox(height: 10.0),
                        Slider(
                          min: 0.0,
                          max: 100,
                          divisions: 100,
                          value: sliderLampada.toDouble(),
                          activeColor: Colors.blue,
                          onChanged: (newValue) {
                            setState(() {
                              sliderLampada = newValue.toInt();
                            });
                          },
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Colors.blue,
                          child: Text('Confirmar'),
                          onPressed: () {
                            _httpSliderLampada(sliderLampada);
                          },
                        )
                      ]),
                    ),
                    SizedBox(height: 70.0),
                    Container(
                      width: 50.0,
                      height: 150.0,
                      child: Column(children: <Widget>[
                        Align(
                            child: Text('Abertura Persiana',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.left),
                            alignment: Alignment.bottomLeft),
                        Align(
                            child: Text(sliderPersiana.toString() + "%",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.left),
                            alignment: Alignment.topRight),
                        SizedBox(height: 10.0),
                        Slider(
                          min: 0.0,
                          max: 100,
                          divisions: 100,
                          value: sliderPersiana.toDouble(),
                          activeColor: Colors.blue,
                          onChanged: (newValue) {
                            setState(() {
                              sliderPersiana = newValue.toInt();
                            });
                          },
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Colors.blue,
                          child: Text('Confirmar'),
                          onPressed: () {
                            _httpSliderPersiana(sliderPersiana);
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

  void _httpIluminacaoAutomatica(String estado) async {
    print(estado);
    String url =
        "http://169.254.155.190:8080/basicui/CMD?IluminacaoAutomatica=";
    url = url + estado;
    print(url);
    http.Response response = await http.get(url);
    print(response.toString());
    print(response.statusCode);
  }

  void _httpSliderPersiana(int percentagem) async {
    String url = "http://169.254.155.190:8080/basicui/CMD?Persiana=";
    url = url + percentagem.toString();
    print(url);
    http.Response response = await http.get(url);
    print(response.statusCode);
  }

  void _httpSliderLampada(int percentagem) async {
    String url = "http://169.254.155.190:8080/basicui/CMD?Lampada=";
    url = url + percentagem.toString();
    print(url);
    http.Response response = await http.get(url);
    print(response.statusCode);
  }

  void _httpEstadoIluminacaoAutomatica() async {
    String url =
        "http://169.254.155.190:8080/rest/items/IluminacaoAutomatica/state";
    http.Response response = await http.get(url);

    if (response.body == 'ON') {
      setState(() {
        _iluminacaoAutomatica = true;
      });
    } else {
      setState(() {
        _iluminacaoAutomatica = false;
      });
    }
  }

  void _httpEstadoPersiana() async {
    String url =
        "http://169.254.155.190:8080/rest/items/Persiana/state";
    http.Response response = await http.get(url);

    String c = response.body;
    setState(() {
     sliderPersiana = int.parse(c); 
    });
    
  }

  void _httpEstadoLampada() async {
    String url =
        "http://169.254.155.190:8080/rest/items/Lampada/state";
    http.Response response = await http.get(url);

    String c = response.body;
    setState(() {
     sliderLampada = int.parse(c); 
    });
  }

}
