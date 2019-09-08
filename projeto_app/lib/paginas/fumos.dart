import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Fumos extends StatefulWidget{

  @override
  _Fumos createState() => new _Fumos();
}


class _Fumos extends State<Fumos> {

  bool _extratorCozinha = false;
  bool _extratorGaragem = false;


  @override
  void initState(){
    super.initState();
    _httpEstadoExtratorCozinha();
    _httpEstadoExtratorGaragem();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extratores'),
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
                          title: Text('Extrator Cozinha' , style: TextStyle(fontSize: 20),),
                          value: _extratorCozinha , 
                          onChanged: (bool valor){
                            setState((){
                              String state;
                                if (valor == true) {
                                  state = "ON";
                                } else {
                                  state = "OFF";
                                }
                                _httpExtratorCozinha(state);
                                _extratorCozinha = valor;
                            });
                          } , activeColor: Colors.blue)
                      ]),
                    ),
                    
                    SizedBox(height: 50.0),
                    Container(
                      width: 50.0,
                      height: 90.0,
                      child: Column(children: <Widget>[
                        SwitchListTile(
                          title: Text('Extrator Garagem' , style: TextStyle(fontSize: 20),),
                          value: _extratorGaragem , onChanged: (bool valor){
                            setState(() {
                             String state;
                                if (valor == true) {
                                  state = "ON";
                                } else {
                                  state = "OFF";
                                }
                                _httpExtratorGaragem(state);
                                _extratorGaragem = valor; 
                            });
                        } , activeColor: Colors.blue)
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }


  void _httpExtratorCozinha(String estado) async {
    print(estado);
    String url =
        "http://169.254.155.190:8080/basicui/CMD?ExtratorCozinha=";
    url = url + estado;
    print(url);
    http.Response response = await http.get(url);
    print(response.toString());
    print(response.statusCode);
  }

  void _httpExtratorGaragem(String estado) async {
    print(estado);
    String url =
        "http://169.254.155.190:8080/basicui/CMD?ExtratorGaragem=";
    url = url + estado;
    print(url);
    http.Response response = await http.get(url);
    print(response.toString());
    print(response.statusCode);
  }

  
  void _httpEstadoExtratorCozinha() async {
    String url =
        "http://169.254.155.190:8080/rest/items/ExtratorCozinha/state";
    http.Response response = await http.get(url);

    if (response.body == 'ON') {
      setState(() {
        _extratorCozinha = true;
      });
    } else {
      setState(() {
        _extratorCozinha = false;
      });
    }
  }

  void _httpEstadoExtratorGaragem() async {
    String url =
        "http://169.254.155.190:8080/rest/items/ExtratorGaragem/state";
    http.Response response = await http.get(url);

    if (response.body == 'ON') {
      setState(() {
        _extratorGaragem = true;
      });
    } else {
      setState(() {
        _extratorGaragem = false;
      });
    }
  }

}