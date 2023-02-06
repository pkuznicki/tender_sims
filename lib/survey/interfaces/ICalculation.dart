import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tender_sims/survey/helpers/result.dart';
import 'package:tender_sims/survey/helpers/textutils.dart';
import 'package:tender_sims/survey/widgets/chartWidget.dart' as chart;
import 'package:tender_sims/survey/widgets/playChart.dart';
import 'package:tender_sims/survey/widgets/playerSeries.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tender_sims/survey/widgets/playerSeries.dart';
import 'package:tender_sims/survey/widgets/sampleChart.dart';

abstract class ICalculation {
  String getTitle();
  List<Widget> get_log();
  List<charts.Series<OrdinalSales, String>> getSeries();
  ICalculation(QuerySnapshot qs);
  Map<String, Map<String, dynamic>> calculatedData();
}
