import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/model/movie.dart';
import 'package:netflix/ui/screen/detail_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailScreen(movie: movie);
            },
          ),
        );
      },
      child: CachedNetworkImage(
        imageUrl: movie.posterUrl(),
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Center(
          child: Icon(Icons.error),
        ),
      ),
    );
  }
}
