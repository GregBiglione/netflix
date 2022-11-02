import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netflix/service/api_service.dart';

import '../model/movie.dart';

class DataRepository with ChangeNotifier{
  final ApiService apiService = ApiService();
  final List<Movie> _popularMovieList = [];
  int _popularMoviePageNumber = 1;
  final List<Movie> _nowPlayingList = [];
  int _nowPlayingPageNumber = 2;
  final List<Movie> _availableSoonList = [];
  int _availableSoonPageNumber = 2;
  final List<Movie> _animationMovieList = [];
  int _animationMoviesPageNumber = 1;
  final List<Movie> _adventureMovieList = [];
  int _adventureMoviesPageNumber = 1;

  //****************************************************************************
  // Getters
  //****************************************************************************

  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlayingList => _nowPlayingList;
  List<Movie> get availableSoonList => _availableSoonList;
  List<Movie> get animationMovieList => _animationMovieList;
  List<Movie> get adventureMovieList => _adventureMovieList;

  //****************************************************************************
  // Get popular movies
  //****************************************************************************

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

  //****************************************************************************
  // Get now playing
  //****************************************************************************

  Future getNowPlaying() async {
    try {
      List<Movie> movies = await apiService.getNowPlaying(pageNumber: _nowPlayingPageNumber);
      _nowPlayingList.addAll(movies);
      _nowPlayingPageNumber++;
      notifyListeners();
    } on Response catch (response) {
      print("Error: ${response.statusCode}");
      rethrow;
    }
  }

  //****************************************************************************
  // Get available soon
  //****************************************************************************

  Future getAvailableSoon() async {
    try {
      List<Movie> movies = await apiService.getAvailableSoon(pageNumber: _availableSoonPageNumber);
      _availableSoonList.addAll(movies);
      _availableSoonPageNumber++;
      notifyListeners();
    } on Response catch (response) {
      print("Error: ${response.statusCode}");
      rethrow;
    }
  }

  //****************************************************************************
  // Get animation movies
  //****************************************************************************

  Future getAnimationMovies() async {
    try {
      List<Movie> movies = await apiService.getAnimationMovies(pageNumber: _animationMoviesPageNumber);
      _animationMovieList.addAll(movies);
      _animationMoviesPageNumber++;
      notifyListeners();
    } on Response catch (response) {
      print("Error: ${response.statusCode}");
      rethrow;
    }
  }

  //****************************************************************************
  // Get animation movies
  //****************************************************************************

  Future getAdventureMovies() async {
    try {
      List<Movie> movies = await apiService.getAdventureMovies(pageNumber: _adventureMoviesPageNumber);
      _adventureMovieList.addAll(movies);
      _adventureMoviesPageNumber++;
      notifyListeners();
    } on Response catch (response) {
      print("Error: ${response.statusCode}");
      rethrow;
    }
  }

  Future initData() async {
    await getPopularMovies();
    await getNowPlaying();
    await getAvailableSoon();
    await getAnimationMovies();
    await getAdventureMovies();
  }
}