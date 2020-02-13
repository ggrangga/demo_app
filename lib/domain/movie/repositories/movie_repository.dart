import 'package:demo_app/data/repositories/movie_repository.dart';
import 'package:demo_app/domain/movie/entities/movie_entitiy.dart';
import 'package:injectable/injectable.dart';

@Bind.toType(MovieRepositoryImpl)
@injectable
abstract class MovieRepository {
  Future<List<MovieEntity>> searchMovies(String title, String year);  
}