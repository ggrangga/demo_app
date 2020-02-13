import 'package:demo_app/data/datasources/movie_datasource.dart';
import 'package:demo_app/domain/movie/entities/movie_entitiy.dart';
import 'package:demo_app/domain/movie/repositories/movie_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class MovieRepositoryImpl extends MovieRepository{
  final MovieDatasource movieDatasource;

  MovieRepositoryImpl(this.movieDatasource);

  @override
  Future<List<MovieEntity>> searchMovies(String title, String year) async {    
    return await movieDatasource.searchMoviesByTitleAndYear(title, year);
  }
}