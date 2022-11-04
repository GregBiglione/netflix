import 'package:dio/dio.dart';
import 'package:netflix/model/actor.dart';
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

  //****************************************************************************
  // Get adventure movies
  //****************************************************************************

  Future getAdventureMovies({required int pageNumber}) async{
    Response response = await getData(
        "/discover/movie",
        params: {
          "page": pageNumber,
          "with_genres": "12",
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
  // Get movie details
  //****************************************************************************

  Future<Movie> getMovieDetails({required Movie movie}) async{
    Response response = await getData(
        "/movie/${movie.id}",
    );

    if(response.statusCode == 200){
      Map<String, dynamic> _data = response.data;
      var genres = _data["genres"] as List;
      List<String> genreList = genres.map((genre){
        return genre["name"] as String;
      }).toList();

      Movie detailedMovie = movie.copyWith(
        genres: genreList,
        releaseDate: _data["release_date"],
        vote: _data["vote_average"],
      );

      return detailedMovie;
    }
    else{
      throw response;
    }
  }

  //****************************************************************************
  // Get movie video
  //****************************************************************************

  Future<Movie> getMovieVideos({required Movie movie}) async {
    Response response = await getData(
      "/movie/${movie.id}/videos"
    );

    if(response.statusCode == 200) {
      Map _data = response.data;
      List<String> videoKeys = _data["results"].map<String>((dynamic videoJson) {
        return videoJson["key"] as String;
      }).toList();

      return movie.copyWith(videos: videoKeys);
    }
    else {
      throw response;
    }
  }

  //****************************************************************************
  // Get movie casting
  //****************************************************************************

  Future<Movie> getMovieCasting({required Movie movie}) async {
    Response response = await getData(
        "/movie/${movie.id}/credits"
    );

    if(response.statusCode == 200) {
      Map _data = response.data;
      List<Actor> _casting = _data["cast"].map<Actor>((dynamic actorJson) {
        return Actor.fromJson(actorJson);
      }).toList();

      return movie.copyWith(casting: _casting);
    }
    else {
      throw response;
    }
  }
}