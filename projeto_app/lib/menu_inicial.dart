import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:projeto_app/paginas/fumos.dart';
import 'package:projeto_app/paginas/iluminacao.dart';
import 'package:projeto_app/paginas/settings.dart';
import 'package:projeto_app/paginas/sobre.dart';
import 'package:projeto_app/paginas/temperatura.dart';
import 'package:projeto_app/paginas/vestuario.dart';
import 'package:projeto_app/paginas/garagem.dart';


class MenuGridInicial extends StatefulWidget {
  @override
  _MenuGridInicial createState() => _MenuGridInicial();
}

class _MenuGridInicial extends State<MenuGridInicial> {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
      crossAxisSpacing: 12.0,
      crossAxisCount: 2,
      mainAxisSpacing: 12.0,
      children: <Widget>[
        InkWell(
          child: MyIcon('assets/iluminacao.png'),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Iluminacao(),
                ),
              ),
        ),
        InkWell(
          child: MyIcon('assets/roupa.png'),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Vestuario(),
                ),
              ),
        ),
        InkWell(
          child: MyIcon('assets/garagem.png'),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Garagem(),
                ),
              ),
        ),
        InkWell(
          child: MyIcon('assets/sobre.png'),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Sobre(),
                ),
              ),
        ),
        InkWell(
          child: MyIcon('assets/smoke.png'),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Fumos(),
                ),
              ),
        ),
        InkWell(
          child: MyIcon('assets/termometro.png'),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Temperatura(),
                ),
              ),
        ),
      ],
      staggeredTiles: [
        StaggeredTile.extent(1, 150.0),
        StaggeredTile.extent(1, 150.0),
        StaggeredTile.extent(1, 150.0),
        StaggeredTile.extent(1, 150.0),
        StaggeredTile.extent(1, 150.0),
        StaggeredTile.extent(1, 150.0)
      ],
    );
  }

  Material MyIcon(String asset) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(asset),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
