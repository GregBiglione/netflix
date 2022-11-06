import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:netflix/model/actor.dart';
import 'package:netflix/model/movie.dart';
import 'package:netflix/service/api.dart';
import 'package:netflix/utils/utils.dart';

class ApiService {
  final Api api = Api();
  final Dio dio = Dio();
  Locale deviceLocale = window.locale;
  
  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    String url = api.baseUrl + path;
    Map<String, dynamic> query = {
      "api_key": api.apiKey,
      "language": Utils.convertLocale(deviceLocale),
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
  // Get movie details, videos, casting, gallery with a single call
  //****************************************************************************

  Future<Movie> getMovie({required Movie movie}) async {
    Response response = await getData(
      "/movie/${movie.id}",
      params: {
        "include_image_language": "null",
        "append_to_response": "videos,images,credits",
      },
    );

    if(response.statusCode == 200) {
      Map _data = response.data;

      // Get genres ************************************************************
      List<String> genres = _data["genres"].map<String>((dynamic genreJson){
        return genreJson["name"] as String;
      }).toList();

      // Get videos ************************************************************
      List<String> videoKeys = _data["videos"]["results"].map<String>((dynamic videoJson) {
        return videoJson["key"] as String;
      }).toList();

      // Get casting ***********************************************************
      List<Actor> _casting = _data["credits"]["cast"].map<Actor>((dynamic actorJson) {
        return Actor.fromJson(actorJson);
      }).toList();

      // Get gallery ***********************************************************
      List<String> imagePath = _data["images"]["backdrops"].map<String>((dynamic imageJson) {
        return imageJson["file_path"] as String;
      }).toList();

      return movie.copyWith(
        genres: genres,
        releaseDate: _data["release_date"],
        vote: _data["vote_average"],
        videos: videoKeys,
        casting: _casting,
        images: imagePath,
      );
    }
    else {
      throw response;
    }
  }
}