import 'package:charts_flutter/flutter.dart' as charts;

class PlayerSeries {
  final String team_name;
  final double price;
  final charts.Color barColor;
  PlayerSeries(
      {required this.team_name, required this.price, required this.barColor});
}
