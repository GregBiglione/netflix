import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:netflix/ui/screen/home_screen.dart';
import 'package:netflix/utils/constant.dart';
import 'package:provider/provider.dart';

import '../../repository/data_repository.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    initData();
  }

  //****************************************************************************
  // Initialize the different lists
  //****************************************************************************

  initData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    await dataProvider.initData();
    goToHomeScreen();
  }

  //****************************************************************************
  // Go to HomeScreen
  //****************************************************************************

  goToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(kLogo1),
          SpinKitFadingCircle(
            color: kPrimaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}
