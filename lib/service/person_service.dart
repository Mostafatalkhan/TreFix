import 'package:dio/dio.dart';
import 'package:treflix/constants.dart';
import 'package:treflix/models/person.dart';

class PersonApi {
  String url =
      'https://api.themoviedb.org/3/trending/person/day?api_key=${kApiKey}';
  Future<List<Person>> getPerson() async {
    final dio = Dio();
    Response response = await dio.get(url);
    List<dynamic> data = response.data['results'];
    // print(data);

    List<Person> personList = [];
    for (int i = 0; i < data.length; i++) {
      personList.add(Person.fromJson(data[i]));
    }
    print(personList[0].movieWorks[0].backdropPath);
    return personList;
  }
}
