import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tender_sims/survey/helpers/result.dart';
import 'package:tender_sims/survey/helpers/textutils.dart';
import 'package:tender_sims/survey/widgets/chartWidget.dart' as chart;
import 'package:tender_sims/survey/widgets/playChart.dart';
import 'playerSeries.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ResultScreen extends StatefulWidget {
  String game_id_prv = 'no_game_id';

  ResultScreen({required String game_id}) {
    game_id_prv = game_id;
  }

  @override
  State<ResultScreen> createState() => ResultScreenState(game_id: game_id_prv);
}

class ResultScreenState extends State<ResultScreen> {
  late QuerySnapshot data_chart;
  List<PlayerSeries> result_data = [];
  double price_winning = 10000;
  String team_winning = 'no_team';
  double value_winning = 0;
  String game_id_prv = 'no_game_id';

  ResultScreenState({required String game_id}) {
    game_id_prv = game_id;
  }

  @override
  void initState() {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(game_id_prv);

    collectionRef.get().then((qs) {
      data_chart = qs;

      // Get Single Winner
      qs.docs.forEach(
        (team_result) {
          double price = double.parse(team_result['price_zipper']);
          if (price < price_winning) {
            price_winning = price;
            value_winning = price * 1000000;
            team_winning = team_result['team_name_str'];
          }
        },
      );
      data_chart.docs.forEach(
        (team_result) {
          charts.Color color_bar = charts.ColorUtil.fromDartColor(Colors.red);
          if (team_result['team_name_str'] == team_winning) {
            color_bar = charts.ColorUtil.fromDartColor(Colors.green);
          }
          result_data.add(
            PlayerSeries(
                team_name: team_result['team_name_str'],
                price: double.parse(team_result['price_zipper']),
                barColor: color_bar),
          );
        },
      );
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
          Text(style: TextStyle(fontSize: 20), 'Winning Team: ' + team_winning),
          Text(
              style: TextStyle(fontSize: 20),
              'Awarded Value: ' + value_winning.toString()),
          chart.HomeView(data: result_data),
        ],
      )),
    );
  }
}
