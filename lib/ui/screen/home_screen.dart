import 'package:flutter/material.dart';
import 'package:netflix/repository/data_repository.dart';
import 'package:netflix/ui/widget/movie_card.dart';
import 'package:netflix/ui/widget/movie_category.dart';
import 'package:netflix/utils/constant.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Image.asset(
          "assets/images/netflix_logo_2.png"
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 500,
            child: MovieCard(movie: dataProvider.popularMovieList.first),
          ),
          MovieCategory(
            label: "Tendances actuelles",
            movieList: dataProvider.popularMovieList,
            imageWidth: 110,
            imageHeight: 160,
            callback: dataProvider.getPopularMovies,
          ),
          MovieCategory(
            label: "Actuellement au cinéma",
            movieList: dataProvider.nowPlayingList,
            imageWidth: 220,
            imageHeight: 320,
            callback: dataProvider.getNowPlaying,
          ),
          MovieCategory(
            label: "Bientôt disponible",
            movieList: dataProvider.availableSoonList,
            imageWidth: 110,
            imageHeight: 160,
            callback: dataProvider.getAvailableSoon,
          ),
        ],
      ),
    );
  }
}
