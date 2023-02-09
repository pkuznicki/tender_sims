import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tender_sims/business/calculationSingle.dart';
import 'package:tender_sims/business/calculationQualitative.dart';
import 'package:tender_sims/business/calculationMultiplePercent.dart';
import 'package:tender_sims/survey/widgets/sampleChart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tender_sims/survey/interfaces/ICalculation.dart';
import 'package:tender_sims/business/calculationMultipleVolume.dart';
import 'package:tender_sims/survey/widgets/detailsWidget.dart' as pop;
import 'package:tender_sims/business/constants.dart' as cst;

class ResultScreen extends StatefulWidget {
  String wave_id_prv = 'no_wave_id';

  ResultScreen({required String wave_id}) {
    wave_id_prv = wave_id;
  }

  @override
  State<ResultScreen> createState() => ResultScreenState(wave_id: wave_id_prv);
}

class ResultScreenState extends State<ResultScreen> {
  List<charts.Series<OrdinalSales, String>> result_data = [];
  String wave_id_prv = 'no_wave_id';
  String title = 'no_title';
  bool data_exists = false;
  List<Widget> logWidget = [];
  ResultScreenState({required String wave_id}) {
    wave_id_prv = wave_id;
  }

  @override
  void initState() {
    // Waves Summary

    // Initiate Map
    Map<String, Map<String, double>> map_summary = {};
    List<String> lst_metrics = ['cogsdata', 'profitdata', 'salesdata'];
    List<String> lst_team_ids = cst.tnConstants.get_team_names().keys.toList();
    for (String metric in lst_metrics) {
      for (String team in lst_team_ids) {
        if (map_summary.containsKey(team) == false) {
          map_summary[team] = {};
        }
        map_summary[team]?[metric] = 0;
      }
    }

    var collection = FirebaseFirestore.instance.collection('results');
    collection.get().then((qs) {
      qs.docs.forEach((doc) {
        if (doc.id.contains(wave_id_prv) || (wave_id_prv == 'all')) {
          doc.data().forEach((team, map_values) {
            (map_values as Map).forEach((metric, value) {
              map_summary[team]?[metric] =
                  ((map_summary[team]?[metric]) ?? 0) + value;
            });
          });
        }
      });
    }); //eo thenn

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget result_widget = Text('No data');

    if (data_exists == true) {
      result_widget = Center(
          child: Column(
        children: [
          Container(
            height: 10,
          ),
          Text(style: TextStyle(fontSize: 20), 'Winning Team: $title'),
          Container(
            height: 500,
            width: 1000,
            child: charts.BarChart(
              vertical: false,
              result_data,
              animate: true,
              barRendererDecorator: new charts.BarLabelDecorator<String>(),
              behaviors: [
                charts.SeriesLegend(
                  position: charts.BehaviorPosition.end,
                  outsideJustification: charts.OutsideJustification.endDrawArea,
                  horizontalFirst: false,
                  desiredMaxRows: 2,
                  cellPadding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
                  entryTextStyle: const charts.TextStyleSpec(
                      color: charts.Color(r: 127, g: 63, b: 191),
                      fontFamily: 'Georgia',
                      fontSize: 11),
                )
              ],
              barGroupingType: charts.BarGroupingType.grouped,
            ),
          ),
        ],
      ));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Results'),
        ),
        body: result_widget);
  }
}
