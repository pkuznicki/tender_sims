import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tender_sims/survey/widgets/playerSeries.dart';
import 'package:tender_sims/survey/widgets/playChart.dart';

class HomeView extends StatelessWidget {
  final List<PlayerSeries> data = [
    PlayerSeries(
      year: "2017",
      players: 60000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    PlayerSeries(
      year: "2018",
      players: 50600,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    PlayerSeries(
      year: "2019",
      players: 38500,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    PlayerSeries(
      year: "2020",
      players: 35000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    PlayerSeries(
      year: "2021",
      players: 12000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    PlayerSeries(
      year: "2022",
      players: 11000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
  ];
  HomeView({Key? key}) : super(key: key);
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
