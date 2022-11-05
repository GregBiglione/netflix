import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/model/movie.dart';
import 'package:netflix/repository/data_repository.dart';
import 'package:netflix/ui/widget/action_button.dart';
import 'package:netflix/ui/widget/movie_info.dart';
import 'package:netflix/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widget/casting_card.dart';
import '../widget/gallery_card.dart';
import '../widget/video_player.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;

  const DetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Movie? movie;

  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  //****************************************************************************
  // Get movie data
  //****************************************************************************

  getMovieData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    Movie _movie = await dataProvider.getMovieDetails(movie: widget.movie);

    setState(() {
      movie = _movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
      ),
      body: movie == null
          ? Center(
              child: SpinKitFadingCircle(
                color: kPrimaryColor,
                size: 20,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: movie!.videos!.isEmpty
                        ? Center(
                            child: Text(
                              AppLocalizations.of(context)!.videoNotAvailable,
                              style: GoogleFonts.poppins(
                                color: kWhite,
                              ),
                            ),
                          )
                        : VideoPlayer(movieId: movie!.videos!.first),
                  ),
                  MovieInfo(movie: movie!),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                    label: AppLocalizations.of(context)!.play,
                    icon: Icons.play_arrow,
                    bgColor: kWhite,
                    color: kBackgroundColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                    label: AppLocalizations.of(context)!.downloadVideo,
                    icon: Icons.download,
                    bgColor: Colors.grey.withOpacity(0.3),
                    color: kWhite,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  movie!.description.isEmpty
                      ? Center(
                          child: Text(
                            AppLocalizations.of(context)!.synopsisNotAvailable,
                            style: GoogleFonts.poppins(
                              color: kWhite,
                            ),
                          ),
                        )
                      : Text(
                          movie!.description,
                          style: GoogleFonts.poppins(
                            color: kWhite,
                            fontSize: 15,
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!.casting,
                    style: GoogleFonts.poppins(
                      color: kWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movie!.casting!.length,
                      itemBuilder: (context, int index) {
                        return movie!.casting![index].imageUrl == null
                            ? const Center()
                            : CastingCard(actor: movie!.casting![index]);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!.gallery,
                    style: GoogleFonts.poppins(
                      color: kWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movie!.images!.length,
                      itemBuilder: (context, int index) {
                        return GalleryCard(posterPath: movie!.images![index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
