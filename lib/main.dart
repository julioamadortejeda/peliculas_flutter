import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Custom imports
import 'package:peliculas_tutorial/src/pages/home_page.dart';
import 'package:peliculas_tutorial/src/pages/pelicula_detail.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detail': (BuildContext context) => PeliculaDetail()
      },
    );
  }
}
