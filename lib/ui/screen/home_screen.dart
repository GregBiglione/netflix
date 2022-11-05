import 'package:flutter/material.dart';
import 'package:netflix/repository/data_repository.dart';
import 'package:netflix/ui/widget/movie_card.dart';
import 'package:netflix/ui/widget/movie_category.dart';
import 'package:netflix/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          kLogo2
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 500,
            child: MovieCard(movie: dataProvider.popularMovieList.first),
          ),
          MovieCategory(
            label: AppLocalizations.of(context)!.currentTrends,
            movieList: dataProvider.popularMovieList,
            imageWidth: 110,
            imageHeight: 160,
            callback: dataProvider.getPopularMovies,
          ),
          MovieCategory(
            label: AppLocalizations.of(context)!.currentlyAtTheCinema,
            movieList: dataProvider.nowPlayingList,
            imageWidth: 220,
            imageHeight: 320,
            callback: dataProvider.getNowPlaying,
          ),
          MovieCategory(
            label: AppLocalizations.of(context)!.availableSoon,
            movieList: dataProvider.availableSoonList,
            imageWidth: 110,
            imageHeight: 160,
            callback: dataProvider.getAvailableSoon,
          ),
          MovieCategory(
            label: AppLocalizations.of(context)!.animations,
            movieList: dataProvider.animationMovieList,
            imageWidth: 220,
            imageHeight: 320,
            callback: dataProvider.getAnimationMovies,
          ),
          MovieCategory(
            label: AppLocalizations.of(context)!.adventure,
            movieList: dataProvider.adventureMovieList,
            imageWidth: 110,
            imageHeight: 160,
            callback: dataProvider.getAdventureMovies,
          ),
        ],
      ),
    );
  }
}
