import 'dart:convert';

import 'package:demo_app/domain/favorite_movie/entities/favorite_movie_entitiy.dart';

class FavoriteMovie extends FavoriteMovieEntity{
  FavoriteMovie({String id, String title, String year, bool viewed, String poster, int priority, int rating, int timestamp, String label}) 
  : super(id : id, title : title, year : year, viewed : viewed, poster : poster, priority : priority, rating : rating, timestamp : timestamp, label : label);

  factory FavoriteMovie.fromJson(Map<String, dynamic> json){
    return FavoriteMovie(
      id: json['id'],
      title: json['Title'],
      year: json['Year'],
      viewed: json['Viewed'],
      poster: json['Poster'],
      priority: json['Priority'],
      rating: json['Rating'],
      timestamp: json['Timestamp'],
      label: json['Label']
    );
  }

  factory FavoriteMovie.fromJsonDemoApi(Map<String, dynamic> json){
    return FavoriteMovie(
      id: json['id'],
      title: json['title'],
      year: json['year'],
      viewed: json['viewed'],
      poster: json['poster'],
      priority: json['priority'],
      rating: json['rating'],
      timestamp: json['timestamp'],
      label: json['label']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'title' : title,
      'year' : year,
      'viewed' : viewed,
      'poster' : poster,
      'priority' : priority,
      'rating' : rating,
      'timestamp' : timestamp,
      'label' : label
    };
  }

  String toString(){
    return jsonEncode(toJson());
  }
}
