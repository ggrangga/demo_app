class ImageDetailModel  {
  String id;
  String title;
  String year;
  String poster;
  String label;
  int priority;
  bool viewed;
  int rating;
  int timestamp;

  ImageDetailModel(
    this.id, 
    this.title, 
    this.year, 
    this.poster, 
    this.label, 
    this.priority, 
    this.viewed, 
    this.rating, 
    this.timestamp);
  ImageDetailModel.fromJson(Map<String, dynamic> parseJson)
    : id = parseJson['id'],
      title = parseJson['title'],
      year = parseJson['year'],
      poster = parseJson['poster'],
      label = parseJson['label'],
      priority = parseJson['priority'],
      viewed = parseJson['viewed'],
      rating = parseJson['rating'],
      timestamp = parseJson['timestamp'];
}