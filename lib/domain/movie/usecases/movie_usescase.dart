import 'package:demo_app/common/models/usecase.dart';
import 'package:demo_app/domain/movie/entities/movie_entitiy.dart';
import 'package:demo_app/domain/movie/repositories/movie_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class SearchMovieUsecase implements UseCase<List<MovieEntity>, Map<String, dynamic>>{
  final MovieRepository movieRepository;

  SearchMovieUsecase({@required this.movieRepository});

  @override
  Future<List<MovieEntity>> call(Map<String, dynamic> _payload) {
    return movieRepository.searchMovies(_payload['title'], _payload['year']);
  }

}