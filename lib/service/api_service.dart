import 'package:dio/dio.dart';
import 'package:netflix/model/movie.dart';
import 'package:netflix/service/api.dart';

class ApiService {
  final Api api = Api();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    String url = api.baseUrl + path;
    Map<String, dynamic> query = {
      "api_key": api.apiKey,
      "language": "fr-FR",
    };

    if(params != null) {
      query.addAll(params);
    }

    final response = await dio.get(url, queryParameters: query);

    if(response.statusCode == 200) {
      return response;
    }
    else {
      throw response;
    }
  }

  //****************************************************************************
  // Get popular movies
  //****************************************************************************

  Future getPopularMovies({required int pageNumber}) async{
    Response response = await getData(
        "/movie/popular",
        params: {
          "page": pageNumber,
        }
    );

    if(response.statusCode == 200){
      Map data = response.data;
      List<dynamic> results = data["results"];
      List<Movie> movies = [];

      for(Map<String, dynamic> json in results){
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    }
    else{
      throw response;
    }
  }

  //****************************************************************************
  // Get now playing
  //****************************************************************************

  Future getNowPlaying({required int pageNumber}) async{
    Response response = await getData(
        "/movie/now_playing",
        params: {
          "page": pageNumber,
        }
    );

    if(response.statusCode == 200){
      Map data = response.data;
      List<Movie> movies = data["results"].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    }
    else{
      throw response;
    }
  }

  //****************************************************************************
  // Get available soon
  //****************************************************************************

  Future getAvailableSoon({required int pageNumber}) async{
    Response response = await getData(
        "/movie/upcoming",
        params: {
          "page": pageNumber,
        }
    );

    if(response.statusCode == 200){
      Map data = response.data;
      List<Movie> movies = data["results"].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    }
    else{
      throw response;
    }
  }

  //****************************************************************************
  // Get animation movies
  //****************************************************************************

  Future getAnimationMovies({required int pageNumber}) async{
    Response response = await getData(
        "/discover/movie",
        params: {
          "page": pageNumber,
          "with_genres": "16",
        }
    );

    if(response.statusCode == 200){
      Map data = response.data;
      List<Movie> movies = data["results"].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    }
    else{
      throw response;
    }
  }
}