import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tender_sims/survey/helpers/result.dart';
import 'package:tender_sims/survey/widgets/chartWidget.dart' as chart;
import 'package:tender_sims/survey/widgets/playChart.dart';
import 'playerSeries.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<PlayerSeries> data_chart =
        ModalRoute.of(context)!.settings.arguments as List<PlayerSeries>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Center(
        child: chart.HomeView(data: data_chart),
      ),
    );
  }
}
