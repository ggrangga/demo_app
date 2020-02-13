import 'package:demo_app/data/datasources/favorite_movie_datasource.dart';
import 'package:demo_app/domain/favorite_movie/entities/favorite_movie_entitiy.dart';
import 'package:demo_app/domain/favorite_movie/repositories/favorite_movie_repository.dart';
import 'package:demo_app/domain/movie/entities/movie_entitiy.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class FavoriteMovieRepositoryImpl extends FavoriteMovieRepository {
  final FavoriteMovieDatasource movieDatasource;

  FavoriteMovieRepositoryImpl(this.movieDatasource);

  @override
  Future<List<FavoriteMovieEntity>> getAllfavoriteMovies() async {
    return await movieDatasource.getAllFavoriteMovies();
  }

  @override
  Future<FavoriteMovieEntity> recommendedMovies() async {
    return await movieDatasource.getRecommended();
  }

  @override
  Future<void> addToFavoriteMovie(MovieEntity movieEntity) async {
    return await movieDatasource.addFavoriteMovie(movieEntity);
  }

  @override
  Future<void> deleteFavoriteMovie(FavoriteMovieEntity movieEntity) async {
    await movieDatasource.deleteFavoriteMovie(movieEntity.id);
  }

  @override
  Future<void> updateFavoriteMovie(FavoriteMovieEntity movieEntity) {
    return movieDatasource.updateFavoriteMovie(movieEntity);
  }

  @override
  Future<List<FavoriteMovieEntity>> getDashboardMovies() async {
    Future<List<FavoriteMovieEntity>> favoriteMovies = getAllfavoriteMovies();
    return favoriteMovies;
  }

  @override
  Future<FavoriteMovieEntity> getAllfavoriteMovieById(String id) async {
    return await movieDatasource.getFavoriteMovieById(id);
  }
}
