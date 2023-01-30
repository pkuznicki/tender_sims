import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tender_sims/business/calculationSingle.dart';
import 'package:tender_sims/business/calculationQualitative.dart';
import 'package:tender_sims/business/calculationMultiplePercent.dart';
import 'package:tender_sims/survey/widgets/sampleChart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tender_sims/survey/interfaces/ICalculation.dart';

class ResultScreen extends StatefulWidget {
  String game_id_prv = 'no_game_id';

  ResultScreen({required String game_id}) {
    game_id_prv = game_id;
  }

  @override
  State<ResultScreen> createState() => ResultScreenState(game_id: game_id_prv);
}

class ResultScreenState extends State<ResultScreen> {
  List<charts.Series<OrdinalSales, String>> result_data = [];
  String game_id_prv = 'no_game_id';
  String title = 'no_title';

  ResultScreenState({required String game_id}) {
    game_id_prv = game_id;
  }

  @override
  void initState() {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(game_id_prv);

    collectionRef.get().then((qs) {
      ICalculation cs;

      // Calculation Wave 1
      if (game_id_prv.substring(1, 2) == '1') {
        cs = CalculationSingle(qs: qs, game_id: game_id_prv);
        result_data = cs.getSeries();
        this.title = cs.getTitle();
      }
      // Calculation Wave3
      if (game_id_prv.substring(1, 2) == '3') {
        cs = CalculationMultiplePercent(qs: qs, game_id: game_id_prv);
        result_data = cs.getSeries();
        this.title = cs.getTitle();
      }
      // Calculation Wave 4
      if (game_id_prv.substring(1, 2) == '4') {
        cs = CalculationQualitative(qs: qs, game_id: game_id_prv);
        result_data = cs.getSeries();
        this.title = cs.getTitle();
      }

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Center(
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
          )
        ],
      )),
    );
  }
}
