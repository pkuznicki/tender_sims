import 'package:charts_flutter/flutter.dart' as charts;

class PlayerSeries {
  final String year;
  final int players;
  final charts.Color barColor;
  PlayerSeries(
      {required this.year, required this.players, required this.barColor});
}
