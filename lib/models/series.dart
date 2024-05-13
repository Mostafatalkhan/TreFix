class Series {
  final String name;
  final int id;
  final String original_name;
  final String overview;
  String backdrop_path;
  final String poster_path;
  final String first_air_date;
  final dynamic vote_average;

  Series(
      {required this.name,
      required this.id,
      required this.original_name,
      required this.overview,
      required this.backdrop_path,
      required this.poster_path,
      required this.first_air_date,
      required this.vote_average});

  factory Series.fromJson(jsonData) {
    return Series(
        id: jsonData['id'] ?? '',
        name: jsonData['name'] ?? '',
        overview: jsonData['overview'] ?? 'No onerview yet',
        original_name: jsonData['original_name'] ?? '',
        backdrop_path: jsonData['backdrop_path'] ?? jsonData['poster_path'],
        poster_path: jsonData['poster_path'] ?? '',
        first_air_date: jsonData['first_air_date'] ?? '',
        vote_average: jsonData['vote_average'] ?? '');
  }
}
