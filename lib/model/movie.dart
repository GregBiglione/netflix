import 'package:netflix/service/api.dart';

class Movie {
  final int id;
  final String name;
  final String description;
  final String? posterPath;

//<editor-fold desc="Data Methods">

  Movie({
    required this.id,
    required this.name,
    required this.description,
    this.posterPath,
  });

  Movie copyWith({
    int? id,
    String? name,
    String? description,
    String? posterPath,
  }) {
    return Movie(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      posterPath: posterPath ?? this.posterPath,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      name: map['title'] as String,
      description: map['overview'] as String,
      posterPath: map['poster_path'] as String,
    );
  }

  // Poster url ****************************************************************

  String posterUrl() {
    Api api = Api();

    return api.baseImageUrl + posterPath!;
  }

//</editor-fold>
}