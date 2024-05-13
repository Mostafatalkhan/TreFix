import 'package:treflix/models/move.dart';

class Person {
  final int id;
  final String original_name;
  final String name;
  final String department;
  final String profile_path;
  final List<Movie> movieWorks;

  Person(
      {required this.id,
      required this.original_name,
      required this.name,
      required this.department,
      required this.profile_path,
      required this.movieWorks});

  factory Person.fromJson(jsonData) {
    List<Movie> movies = [];
    if (jsonData['known_for'] != null) {
      for (var movieData in jsonData['known_for']) {
        Movie movie = Movie.fromJson(movieData);
        movies.add(movie);
      }
    }
    return Person(
      id: jsonData['id'] ?? 0,
      original_name: jsonData['original_name'] ?? '',
      name: jsonData['name'] ?? '',
      department: jsonData['known_for_department'] ?? '',
      profile_path:
          jsonData['profile_path'] ?? '/qYiaSl0Eb7G3VaxOg8PxExCFwon.jpg',
      movieWorks: movies,
    );
  }
}
