import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Garagem extends StatefulWidget{

  _Garagem createState() => _Garagem();

}


class _Garagem extends State<Garagem> {

  String estadoPortao = "Fechado";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Garagem'),
        ),
        body: Center(
          child: Column(
          mainAxisSize: MainAxisSize.min ,
          children: <Widget>[
            Container(
              child: OutlineButton(
                onPressed: () {
                  httpEstadoPortao("Aberto");
                },
                highlightElevation: 30.0,
                highlightColor: Colors.green,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                borderSide: BorderSide(color: Colors.green),
                textColor: Colors.green,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: const Text('Abrir', style: TextStyle(fontSize: 30)),
                ),
              ),
            ),
            const SizedBox(height: 70),
            Container(
              child: OutlineButton(
                onPressed: () {
                  httpEstadoPortao("Fechado");
                },
                highlightElevation: 30.0,
                highlightColor: Colors.red,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                borderSide: BorderSide(color: Colors.red),
                textColor: Colors.red,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: const Text('Fechar', style: TextStyle(fontSize: 30)),
                ),
              ),
            )
          ],
        )));
  }

  void _httpEstadoPortao() async {
    String url =
        "http://169.254.155.190:8080/rest/items/PortaoGaragem/state";
    http.Response response = await http.get(url);

    String c = response.body;
    setState(() {
     estadoPortao = c; 
    });
  }


  void httpEstadoPortao(String estado) async {
    String url =
        "http://169.254.155.190:8080/basicui/CMD?PortaoGaragem=";
    url = url + estado;
    
    http.Response response = await http.get(url);

    print(response.toString());
    print(response.statusCode);
  }
}
