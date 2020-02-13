import 'dart:convert';

import 'package:demo_app/common/network/omdb_ws_client.dart';
import 'package:demo_app/data/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@Bind.toType(MovieDatasourceImpl)
@injectable
abstract class MovieDatasource {
  Future<List<Movie>> searchMoviesByTitleAndYear(String title, String year);
}

@lazySingleton
@injectable
class MovieDatasourceImpl extends MovieDatasource {
  static const String DOMAIN ='omdbapi.com';
  static const String API_KEY = '4c2c77c6';

  final OmdbWsClient omdbWsClient;

  MovieDatasourceImpl({this.omdbWsClient});

  factory MovieDatasourceImpl.create() {
    return MovieDatasourceImpl(
      omdbWsClient: OmdbWsClientImpl(http.Client()),
    );
  }

  @override
  Future<List<Movie>> searchMoviesByTitleAndYear(
      String title, String year) async {
    List<Movie> movies = [];
    Uri uri = Uri.https(DOMAIN, '',
        {'s': title, 'y': year, 'apikey': API_KEY});

    final response = await omdbWsClient.get(uri);
    String json = response.body;
    Map<String, dynamic> decodedJson = jsonDecode(json);
    List<dynamic> listResult = decodedJson['Search'];
    for (Map<String, dynamic> result in listResult) {
      movies.add(Movie.fromJson(result));
    }
    return movies;
  }
}
