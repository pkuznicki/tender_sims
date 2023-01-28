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
  @override
  State<ResultScreen> createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  String game_id = 'no_game_id';
  late QuerySnapshot data_chart;
  List<PlayerSeries> result_data = [];
  double price_winning = 10000;
  String team_winning = 'no_team';
  double value_winning = 0;

  @override
  void initState() {
    // Get Game ID
    final docRef_settings =
        FirebaseFirestore.instance.collection("settings").doc("main");

    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('no_game');

    docRef_settings.get().then((DocumentSnapshot doc) {
      game_id = doc['game_id'];

      collectionRef = FirebaseFirestore.instance.collection(game_id);
      collectionRef.get().then((qs) {
        data_chart = qs;

        // Get Single Winner
        data_chart.docs.forEach(
          (team_result) {
            double price = double.parse(team_result['price_zipper']);
            if (price < price_winning) {
              price_winning = price;
              value_winning = price * 1000000;
              team_winning = team_result['team_name'];
            }
          },
        );
        data_chart.docs.forEach(
          (team_result) {
            charts.Color color_bar = charts.ColorUtil.fromDartColor(Colors.red);
            if (team_result['team_name'] == team_winning) {
              color_bar = charts.ColorUtil.fromDartColor(Colors.green);
            }
            result_data.add(
              PlayerSeries(
                  team_name: team_result['team_name'],
                  price: double.parse(team_result['price_zipper']),
                  barColor: color_bar),
            );
          },
        );
      });
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
