import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tender_sims/survey/helpers/result.dart';
import 'package:tender_sims/survey/widgets/chartWidget.dart' as chart;
import 'package:tender_sims/survey/widgets/playChart.dart';
import 'playerSeries.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuerySnapshot data_chart =
        ModalRoute.of(context)!.settings.arguments as QuerySnapshot;

    //List<PlayerSeries> data_chart =  ModalRoute.of(context)!.settings.arguments as QuerySnapshot;
    // ModalRoute.of(context)!.settings.arguments as List<PlayerSeries>;

    List<PlayerSeries> result_data = [];
    data_chart.docs.forEach(
      (team_result) {
        result_data.add(
          PlayerSeries(
            team_name: team_result['team_name'],
            price: double.parse(team_result['price_zipper']),
            barColor: charts.ColorUtil.fromDartColor(Colors.blue),
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Center(
        child: chart.HomeView(data: result_data),
      ),
    );
  }
}
