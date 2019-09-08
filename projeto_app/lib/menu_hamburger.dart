import 'package:flutter/material.dart';

import 'package:projeto_app/paginas/settings.dart';



class MenuHamburguer extends StatefulWidget {
  @override
  _MenuHamburgerApp createState() => _MenuHamburgerApp();
}

class _MenuHamburgerApp extends State<MenuHamburguer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.lightBlue, Colors.blueAccent])),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/smarthome.png',
                          width: 85,
                          height: 85,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Smart Home',
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.notifications),
              title: new Text('Notifications'),
            ),
            new Divider(
              color: Colors.blue,
              indent: 16.0,
            ),
            new ListTile(
              leading: new Icon(Icons.settings),
              title: new Text('Settings'),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Settings()
                    ),
                  ),
            ),
            new Divider(
              color: Colors.blue,
              indent: 16.0,
            ),
            new ListTile(
              leading: new Icon(Icons.info),
              title: new Text('About us'),
            ),
            new Divider(
              color: Colors.blue,
              indent: 16.0,
            ),
          ],
        )
    );
  }
}