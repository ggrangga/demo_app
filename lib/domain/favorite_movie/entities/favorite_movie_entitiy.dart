class FavoriteMovieEntity {
  String id;
  String title;
  String year;
  bool viewed;
  String poster;
  int priority;
  int rating;
  int timestamp;
  String label;

  FavoriteMovieEntity({this.id, this.title, this.year, this.viewed, this.poster, this.priority, this.rating, this.timestamp, this.label});

  FavoriteMovieEntity copyWith(
    String id,
    String title,
    String year,
    bool viewed, 
    String poster,
    int priority, 
    int rating, 
    int timestamp,
    String label,
  ) => FavoriteMovieEntity(
    id: id ?? this.id,
    title: title ?? this.title, 
    year: year ?? this.year, 
    viewed: viewed ?? this.viewed,
    poster: poster ?? this.poster, 
    priority: priority ?? this.priority,
    rating: rating ?? this.rating, 
    timestamp: timestamp ?? this.timestamp,
    label: label ?? this.label,
  );
}
