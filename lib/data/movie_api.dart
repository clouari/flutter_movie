import 'dart:convert';

import 'package:flutter_movie/model/movie.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  Future<List<Movie>> fetchMovies(String query) async {
    String url =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR&page=1';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Movie.listToMovie(jsonDecode(response.body)['results']);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
