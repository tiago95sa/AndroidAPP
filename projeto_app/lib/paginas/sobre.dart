import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Sobre extends StatefulWidget {
  _Sobre createState() => _Sobre();
}

class _Sobre extends State<Sobre> {
  String _garagem = "Fechado";
  String _pessoasCasa = "0";
  String _portaFrente = "Aberto";
  String _portaQuintal = "Fechado";
  String _portaVarandaFrente = "Fechado";
  String _portaVarandaTras = "Fechado";

  @override
  void initState() {
    super.initState();
    _httpEstadoGaragem(_garagem);
    _httpEstadoPessoasPresentes(_pessoasCasa);
    _httpEstadoPortaFrente(_portaFrente);
    _httpEstadoPortaQuintal(_portaQuintal);
    _httpEstadoPortaVarandaFrente(_portaVarandaFrente);
    _httpEstadoPortaFrente(_portaVarandaTras);
  }

  Widget bodyData() => DataTable(
        columns: <DataColumn>[
          DataColumn(
              label: Text("Nome", style: TextStyle(fontSize: 30)),
              numeric: false,
              onSort: null),
          DataColumn(
              label: Text("Estado", style: TextStyle(fontSize: 25)),
              numeric: false,
              onSort: null)
        ],
        rows: <DataRow>[
          DataRow(cells: <DataCell>[
            DataCell(Text("Pessoas Presentes", style: TextStyle(fontSize: 15))),
            DataCell(Text(_pessoasCasa))
          ]),
          DataRow(cells: <DataCell>[
            DataCell(
                PopupMenuButton(
                  child: Text("Porta frente", style: TextStyle(fontSize: 15)),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: OutlineButton(
                            onPressed: () {
                              _httpPortaFrente("Aberto");
                              setState(() {
                                _portaFrente = "Aberto";
                              });
                            },
                            borderSide: BorderSide(color: Colors.green),
                            textColor: Colors.green,
                            highlightElevation: 30.0,
                            highlightColor: Colors.green,
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            child: const Text('Abrir', style: TextStyle(fontSize: 25)),
                          ),
                        ),
                        PopupMenuItem(
                          child: OutlineButton(
                            onPressed: () {
                              _httpPortaFrente("Fechado");
                              setState(() {
                                _portaFrente = "Fechado";
                              });
                            },
                            borderSide: BorderSide(color: Colors.red),
                            textColor: Colors.red,
                            highlightElevation: 30.0,
                            highlightColor: Colors.red,
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            child: const Text('Fechar', style: TextStyle(fontSize: 25)),
                            
                          ),
                        ),
                      ],
                ),
                showEditIcon: true),
            DataCell(Container(child: _estadoTexto(_portaFrente)))
          ]),
          DataRow(cells: <DataCell>[
            DataCell(
                PopupMenuButton(
                  child: Text("Porta quintal", style: TextStyle(fontSize: 15)),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: OutlineButton(
                            onPressed: () {
                              _httpPortaQuintal("Aberto");
                              setState(() {
                               _portaQuintal = "Aberto"; 
                              });
                            },
                            borderSide: BorderSide(color: Colors.green),
                            textColor: Colors.green,
                            highlightElevation: 30.0,
                            highlightColor: Colors.green,
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            child: const Text('Abrir', style: TextStyle(fontSize: 25)),
                            
                          ),
                        ),
                        PopupMenuItem(
                          child: OutlineButton(
                            onPressed: () {
                              _httpPortaQuintal("Fechado");
                              setState(() {
                               _portaQuintal = "Fechado"; 
                              });
                            },
                            borderSide: BorderSide(color: Colors.red),
                            textColor: Colors.red,
                            highlightElevation: 30.0,
                            highlightColor: Colors.red,
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            child: const Text('Fechar', style: TextStyle(fontSize: 25)),
                          ),
                        ),
                      ],
                ),
                showEditIcon: true),
            DataCell(Container(child: _estadoTexto(_portaQuintal)))
          ]),
          DataRow(cells: <DataCell>[
            DataCell(
                PopupMenuButton(
                  child: Text("Porta varanda frente",
                      style: TextStyle(fontSize: 15)),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: OutlineButton(
                            onPressed: () {
                              _httpPortaVarandaFrente("Aberto");
                              setState(() {
                               _portaVarandaFrente = "Aberto"; 
                              });
                            },
                            borderSide: BorderSide(color: Colors.green),
                            textColor: Colors.green,
                            highlightElevation: 30.0,
                            highlightColor: Colors.green,
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            child: const Text('Abrir', style: TextStyle(fontSize: 25)),
                            
                          ),
                        ),
                        PopupMenuItem(
                          child: OutlineButton(
                            onPressed: () {
                              _httpPortaVarandaFrente("Fechado");
                              setState(() {
                                _portaVarandaFrente = "Fechado";
                              });
                            },
                            borderSide: BorderSide(color: Colors.red),
                            textColor: Colors.red,
                            highlightElevation: 30.0,
                            highlightColor: Colors.red,
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            child: const Text('Fechar', style: TextStyle(fontSize: 25)),
                          ),
                        ),
                      ],
                ),
                showEditIcon: true),
            DataCell(Container(child: _estadoTexto(_portaVarandaFrente)))
          ]),
          DataRow(cells: <DataCell>[
            DataCell(
                PopupMenuButton(
                  child: Text("Porta varanda traseira",
                      style: TextStyle(fontSize: 15)),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: OutlineButton(
                            onPressed: () {
                              _httpPortaVarandaTraseira("Aberto");
                              setState(() {
                               _portaVarandaTras = "Aberto"; 
                              });
                            },
                            borderSide: BorderSide(color: Colors.green),
                            textColor: Colors.green,
                            highlightElevation: 30.0,
                            highlightColor: Colors.green,
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            child: const Text('Abrir', style: TextStyle(fontSize: 25)),
                            
                          ),
                        ),
                        PopupMenuItem(
                          child: OutlineButton(
                            onPressed: () {
                              _httpPortaVarandaTraseira("Fechado");
                              setState(() {
                               _portaVarandaTras = "Fechado"; 
                              });
                            },
                            borderSide: BorderSide(color: Colors.red),
                            textColor: Colors.red,
                            highlightElevation: 30.0,
                            highlightColor: Colors.red,
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            child: const Text('Fechar', style: TextStyle(fontSize: 25)),
                          ),
                        ),
                      ],
                ),
                showEditIcon: true),
            DataCell(Container(child: _estadoTexto(_portaVarandaTras)))
          ]),
          DataRow(cells: <DataCell>[
            DataCell(
              Text("Garagem", style: TextStyle(fontSize: 15)),
            ),
            DataCell(Container(child: _estadoTexto(_garagem)))
          ])
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estados'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: bodyData(),
      ),
    );
  }

  Widget _estadoTexto(String estado) {
    //print(estado);
    if (estado == 'Fechado') {
      //print('iiiii');
      return Text("Fechado", style: TextStyle(fontSize: 15, color: Colors.red));
    } else {
      //print('22222');
      return Text("Aberto",
          style: TextStyle(fontSize: 15, color: Colors.green));
    }
  }

  void _httpEstadoGaragem(String estado) async {
    String url = "http://169.254.155.190:8080/rest/items/PortaoGaragem/state";
    http.Response response = await http.get(url);

    String c = response.body;
    setState(() {
      _garagem = c;
    });
  }

  void _httpEstadoPessoasPresentes(String estado) async {
    String url =
        "http://169.254.155.190:8080/rest/items/PessoasPresentes/state";
    http.Response response = await http.get(url);

    String c = response.body;
    setState(() {
      _pessoasCasa = c;
    });
  }

  void _httpEstadoPortaFrente(String estado) async {
    String url = "http://169.254.155.190:8080/rest/items/PortaFrente/state";
    http.Response response = await http.get(url);

    String c = response.body;

    setState(() {
      _portaFrente = c;
    });
  }

  void _httpEstadoPortaQuintal(String estado) async {
    String url = "http://169.254.155.190:8080/rest/items/PortaQuintal/state";
    http.Response response = await http.get(url);

    String c = response.body;
    setState(() {
      _portaQuintal = c;
    });
  }

  void _httpEstadoPortaVarandaFrente(String estado) async {
    String url =
        "http://169.254.155.190:8080/rest/items/PortaVarandaFrente/state";
    http.Response response = await http.get(url);

    String c = response.body;
    setState(() {
      _portaVarandaFrente = c;
    });
  }

  void _httpEstadoPortaVarandaTras(String estado) async {
    String url =
        "http://169.254.155.190:8080/rest/items/PortaVarandaTras/state";
    http.Response response = await http.get(url);

    String c = response.body;
    setState(() {
      _portaVarandaTras = c;
    });
  }

  void _httpPortaFrente(String estado) async {
    String url = "http://169.254.155.190:8080/basicui/CMD?PortaFrente=";
    url = url + estado;

    http.Response response = await http.get(url);

    print(response.toString());
    print(response.statusCode);
  }

  void _httpPortaQuintal(String estado) async {
    String url = "http://169.254.155.190:8080/basicui/CMD?PortaQuintal=";
    url = url + estado;

    http.Response response = await http.get(url);

    print(response.toString());
    print(response.statusCode);
  }

  void _httpPortaVarandaFrente(String estado) async {
    String url = "http://169.254.155.190:8080/basicui/CMD?PortaVarandaFrente=";
    url = url + estado;

    http.Response response = await http.get(url);

    print(response.toString());
    print(response.statusCode);
  }

  void _httpPortaVarandaTraseira(String estado) async {
    String url = "http://169.254.155.190:8080/basicui/CMD?PortaVarandaTras=";
    url = url + estado;

    http.Response response = await http.get(url);

    print(response.toString());
    print(response.statusCode);
  }
}
