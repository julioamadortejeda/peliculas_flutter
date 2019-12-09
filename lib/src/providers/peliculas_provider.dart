import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:peliculas_tutorial/src/models/actor_model.dart';
import 'package:peliculas_tutorial/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '1865f43a0549ca50d341dd9ab8b29f49';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;
  bool _cargando = false;
  List<Pelicula> _populares = List();

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString(),
    });

    final response = await _procesarRespuesta(url);
    _populares.addAll(response);
    popularesSink(_populares);
    _cargando = false;

    return response;
  }

  Future<List<Actor>> getCast(String peliculaID) async {
    final url = Uri.https(_url, '3/movie/$peliculaID/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    return await _procesarRespuesta(url);
  }
}
