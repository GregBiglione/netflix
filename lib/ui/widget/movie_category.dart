import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/movie.dart';
import 'movie_card.dart';

class MovieCategory extends StatelessWidget {
  final String label;
  final List<Movie> movieList;
  final double imageWidth;
  final double imageHeight;
  final Function callback;

  const MovieCategory({Key? key, required this.label, required this.movieList,
    required this.imageWidth, required this.imageHeight,
    required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15,),
        Text(
          label,
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 5,),
        SizedBox(
          height: imageHeight,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollNotification) {
              final currentPosition = scrollNotification.metrics.pixels;
              final maxPosition = scrollNotification.metrics.maxScrollExtent;

              if(currentPosition >= maxPosition / 2){
                callback();
              }
              return true;
            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieList.length,
              itemBuilder: (context, index) {
                return Container(
                  width: imageWidth,
                  margin: const EdgeInsets.only(right: 8),
                  child: movieList.isEmpty
                      ? Center(
                          child: Text(index.toString()),
                        )
                      : MovieCard(movie: movieList[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
