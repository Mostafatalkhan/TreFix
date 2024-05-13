class Movie {
  final String title;
  final int id;
  final String overview;
  final String originalTitle;
  final String backdropPath;
  final String posterPath;
  final String releaseDate;
  final dynamic voteAverage;

  Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.originalTitle,
      required this.backdropPath,
      required this.posterPath,
      required this.releaseDate,
      required this.voteAverage});
  factory Movie.fromJson(jsonData) {
    return Movie(
        id: jsonData['id'] ?? '',
        title: jsonData['title'] ?? jsonData['name'] ?? '',
        overview: jsonData['overview'] ?? 'Sorry There`s no overview now',
        originalTitle: jsonData['original_title'] ?? '',
        backdropPath:
            jsonData['backdrop_path'] ?? jsonData['poster_path'] ?? '',
        posterPath: jsonData['poster_path'] ?? '',
        releaseDate:
            jsonData['release_date'] ?? jsonData['first_air_date'] ?? '',
        voteAverage: jsonData['vote_average'] ?? '0');
  }
}
