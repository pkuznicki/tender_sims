import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tender_sims/survey/widgets/playerSeries.dart';

class PlayerChart extends StatelessWidget {
  final List<PlayerSeries> data;
  const PlayerChart({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<charts.Series<PlayerSeries, String>> series = [
      charts.Series(
          id: "players",
          data: data,
          domainFn: (PlayerSeries series, _) => series.team_name,
          measureFn: (PlayerSeries series, _) => series.price,
          colorFn: (PlayerSeries series, _) => series.barColor)
    ];
    return Container(
      height: 500,
      padding: const EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: [
              Text(
                "Bidding Prices by Team.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
