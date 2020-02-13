import 'dart:convert';
import 'package:demo_app/common/network/omdb_ws_client.dart';
import 'package:demo_app/data/models/favorite_movie.dart';
import 'package:demo_app/data/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Bind.toType(FavoriteMovieDatasourceImpl)
@injectable
abstract class FavoriteMovieDatasource {
  Future<List<FavoriteMovie>> getAllFavoriteMovies();
  Future<void> addFavoriteMovie(Movie movie);
  Future<FavoriteMovie> getRecommended();
  Future<void> deleteFavoriteMovie(String id);
  Future<void> updateFavoriteMovie(FavoriteMovie movie);
  Future<FavoriteMovie> getFavoriteMovieById(String id);
}

@lazySingleton
@injectable
class FavoriteMovieDatasourceImpl extends FavoriteMovieDatasource {
  static const String DOMAIN = 'demo-video-ws-chfmsoli4q-ew.a.run.app';
  static const String API_KEY = '4c2c77c6';
  final OmdbWsClient omdbWsClient;
  final sharedPreferences = SharedPreferences.getInstance();

  FavoriteMovieDatasourceImpl({this.omdbWsClient});

  factory FavoriteMovieDatasourceImpl.create() {
    return FavoriteMovieDatasourceImpl(
      omdbWsClient: OmdbWsClientImpl(http.Client()),
    );
  }

  Future<String> getToken() async {
    final _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString("userToken");
    return token;
  }

  @override
  Future<List<FavoriteMovie>> getAllFavoriteMovies() async {
    List<FavoriteMovie> movies = [];
    Uri uri = Uri.https(DOMAIN, 'video-ws/videos', {'apikey': API_KEY});

    final token = await getToken();
    final _header = {'token': token};

    final response = await omdbWsClient.get(uri, headers: _header);
    String json = response.body;
    List<dynamic> decodedJson = jsonDecode(json);
    for (Map<String, dynamic> movieJson in decodedJson) {
      movies.add(FavoriteMovie.fromJsonDemoApi(movieJson));
    }
    return movies;
  }

  @override
  Future<void> addFavoriteMovie(Movie movie) async {
    Uri uri = Uri.https(DOMAIN, 'video-ws/videos/');
    final token = await getToken();
    final _header = {"token": token, "Content-type" : "application/json"};
    final _body = movie.toJson();

    omdbWsClient.post(uri, body: json.encode(_body), headers: _header);
  }

  @override
  Future<FavoriteMovie> getRecommended() async {
    Uri uri = Uri.https(DOMAIN, 'video-ws/recommended', {'apikey': API_KEY});
    final token = await getToken();
    final _header = {'token': token};

    final response = await omdbWsClient.get(uri, headers: _header);
    String json = response.body;
    Map<String, dynamic> decodedJson = jsonDecode(json);
    return FavoriteMovie.fromJsonDemoApi(decodedJson);
  }

  @override
  Future<void> deleteFavoriteMovie(String id) async {
    Uri uri = Uri.https(DOMAIN, 'video-ws/videos/$id', {'apikey': API_KEY});
    final token = await getToken();
    final _header = {'token': token};

    await omdbWsClient.delete(uri, headers: _header);
  }

  @override
  Future<void> updateFavoriteMovie(FavoriteMovie movie) async {
    Uri uri =
        Uri.https(DOMAIN, 'video-ws/videos/${movie.id}', {'apikey': API_KEY});
    final token = await getToken();
    final _header = {'token': token};
    final _body = movie.toJson();

    await omdbWsClient.put(uri, headers: _header, body: _body);
  }

  Future<dynamic> getFromSharedPreferences(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key);
  }

  @override
  Future<FavoriteMovie> getFavoriteMovieById(String id) async {
    Uri uri = Uri.https(DOMAIN, 'video-ws/videos/$id');
    final token = await getToken();
    final _header = {'token': token};

    final response = await omdbWsClient.get(uri, headers: _header);
    String json = response.body;
    Map<String, dynamic> decodedJson = jsonDecode(json);
    return FavoriteMovie.fromJsonDemoApi(decodedJson);
  }
}
