import 'package:demo_app/common/models/usecase.dart';
import 'package:demo_app/domain/favorite_movie/entities/favorite_movie_entitiy.dart';
import 'package:demo_app/domain/favorite_movie/repositories/favorite_movie_repository.dart';
import 'package:demo_app/domain/movie/entities/movie_entitiy.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class GetAllFavoriteMovieUsecase implements UseCase<List<FavoriteMovieEntity>, NoPayload>{
  final FavoriteMovieRepository favoriteMovieRepository;

  GetAllFavoriteMovieUsecase({@required this.favoriteMovieRepository});

  @override
  Future<List<FavoriteMovieEntity>> call(NoPayload _) {
    return favoriteMovieRepository.getAllfavoriteMovies();
  }
}

@lazySingleton
@injectable
class CreateFavoriteMovieUsecase implements UseCase<void, MovieEntity>{
  final FavoriteMovieRepository favoriteMovieRepository;

  CreateFavoriteMovieUsecase({@required this.favoriteMovieRepository});

  @override
  Future<void> call(MovieEntity _payload) {
    return favoriteMovieRepository.addToFavoriteMovie(_payload);
  }
}

@lazySingleton
@injectable
class UpdateFavoriteMovieUsecase implements UseCase<void, FavoriteMovieEntity>{
  final FavoriteMovieRepository favoriteMovieRepository;

  UpdateFavoriteMovieUsecase({@required this.favoriteMovieRepository});

  @override
  Future<List<FavoriteMovieEntity>> call(FavoriteMovieEntity _payload) {
    return favoriteMovieRepository.updateFavoriteMovie(_payload);
  }
}

@lazySingleton
@injectable
class DeleteFavoriteMovieUsecase implements UseCase<void, FavoriteMovieEntity>{
  final FavoriteMovieRepository favoriteMovieRepository;

  DeleteFavoriteMovieUsecase({@required this.favoriteMovieRepository});

  @override
  Future<void> call(FavoriteMovieEntity _payload) {
    return favoriteMovieRepository.deleteFavoriteMovie(_payload);
  }
}

@lazySingleton
@injectable
class GetRecommendedMovieUsecase implements UseCase<FavoriteMovieEntity, NoPayload>{
  final FavoriteMovieRepository recommendedMovieRepository;

  GetRecommendedMovieUsecase({@required this.recommendedMovieRepository});

  @override
  Future<FavoriteMovieEntity> call(NoPayload _) {
    return recommendedMovieRepository.recommendedMovies();
  }
}

@lazySingleton
@injectable
class FavoriteMovieByIdUsecase implements UseCase<FavoriteMovieEntity, String>{
  final FavoriteMovieRepository favoriteMovieRepository;

  FavoriteMovieByIdUsecase({@required this.favoriteMovieRepository});

  @override
  Future<FavoriteMovieEntity> call(String id) {
    return favoriteMovieRepository.getAllfavoriteMovieById(id);
  }
}