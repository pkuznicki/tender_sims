import 'package:flutter/material.dart';

import 'package:tender_sims/survey/widgets/playerSeries.dart';
import 'package:tender_sims/survey/widgets/playChart.dart';

class HomeView extends StatelessWidget {
  List<PlayerSeries> data;

  HomeView({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: PlayerChart(
        data: data,
      )),
    );
  }
}
