import 'package:flutter/material.dart';

//Custom imports
import 'package:peliculas_tutorial/src/providers/peliculas_provider.dart';
import 'package:peliculas_tutorial/src/models/pelicula_model.dart';

class DataSearch extends SearchDelegate {
  final peliculasProvider = PeliculasProvider();
  String seleccion = '';
  final peliculas = [
    'Spiederman',
    'Ironman',
    'Acuaman',
    '300',
    'Predestination',
    'Shazam',
    'Capitan America',
    'Ironman 2',
    'Ironman 3',
    'Ironman 4',
    'Ironman 5',
  ];

  final peliculasRecientes = ['Siperman', '300'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de el Appbar (botones para limpiar o cancelar la busqueda)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // El icono a la izquierda del Appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.00,
        color: Colors.amberAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Las sugerencias que aparecen cuando escirben
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterIMG()),
                  placeholder: AssetImage('assets/img/no_img.jpeg'),
                  height: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detail', arguments: pelicula);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
