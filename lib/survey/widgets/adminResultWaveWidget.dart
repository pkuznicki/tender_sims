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
    for (var w = 0; w < 5; w++) {
      for (var g = 0; g < 4; g++) {
        var collection = FirebaseFirestore.instance.collection('results');
        var snapshots = collection.get().then(
          (qs) {
            for (var doc in qs.docs) {
              print(doc['salesdata']);
            }
          },
        );
      }
    }

    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(wave_id_prv);

    collectionRef.get().then((qs) {
      if (qs.size > 0) {}
    });

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
