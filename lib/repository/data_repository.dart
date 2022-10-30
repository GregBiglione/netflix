import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netflix/service/api_service.dart';

import '../model/movie.dart';

class DataRepository with ChangeNotifier{
  final ApiService apiService = ApiService();
  final List<Movie> _popularMovieList = [];
  int _popularMoviePageNumber = 1;

  //****************************************************************************
  // Getters
  //****************************************************************************

  List<Movie> get popularMovieList => _popularMovieList;

  Future getPopularMovies() async {
    try {
      List<Movie> movies = await apiService.getPopularMovies(pageNumber: _popularMoviePageNumber);
      _popularMovieList.addAll(movies);
      _popularMoviePageNumber++;
      notifyListeners();
    } on Response catch (response) {
      print("Error: ${response.statusCode}");
      rethrow;
    }
  }

  Future initData() async {
    await getPopularMovies();
  }
}