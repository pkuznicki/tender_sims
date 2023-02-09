import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:tender_sims/survey/helpers/result.dart';
import 'package:tender_sims/survey/helpers/textutils.dart';
import 'package:tender_sims/survey/widgets/chartWidget.dart' as chart;
import 'package:tender_sims/survey/widgets/playChart.dart';
import 'playerSeries.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tender_sims/survey/helpers/maps.dart';
import 'dart:html' as html;

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen(this.game_id_prv);
  String game_id_prv = 'no_game_id';

  late QuerySnapshot data_chart;
  List<PlayerSeries> result_data = [];
  double price_winning = 10000;
  String team_winning = 'no_team';
  double value_winning = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade800,
        title: const Text('Tender Simulations Game ## SIMS ##'),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            height: 20,
          ),
          Container(
            height: 10,
          ),
          Text(
            maps.map_games[game_id_prv] as String,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Image.asset(
              'assets/tn_logo.png',
              scale: 3,
              fit: BoxFit.scaleDown,
            ),
          ),
          Container(
            height: 10,
          ),
          Container(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800),
                onPressed: () {
                  context.go('/$game_id_prv');
                },
                child: Text(
                  'Start Game',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              )),
          Container(
            height: 10,
          ),
          Container(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800),
                onPressed: () {
                  html.window.location.reload();
                },
                child: Text(
                  'Next Game',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              )),
          Container(
            height: 25,
          ),
          Container(
              height: 25,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.grey),
                onPressed: () {
                  context.go('/admin');
                },
                child: Text(
                  'Admin Panel',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              )),
          Container(
            height: 30,
          ),
        ],
      )),
    );
  }
}
