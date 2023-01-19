import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tender_sims/survey/helpers/result.dart';
import 'package:tender_sims/survey/widgets/chartWidget.dart' as chart;

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    List<String> lst_teams = [];
    List<Float> lst_prices = [];

    final result = ModalRoute.of(context)!.settings.arguments as Result;

    result.data.forEach((team_result) {
      lst_teams.add(team_result?['team_id']);
      lst_prices.add(team_result?['price_zipper']);
    });
*/

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Center(
        child: chart.HomeView(),
      ),
    );
  }
}
