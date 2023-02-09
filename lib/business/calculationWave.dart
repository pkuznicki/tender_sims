import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tender_sims/survey/helpers/maps.dart';
import 'package:tender_sims/survey/helpers/result.dart';
import 'package:tender_sims/survey/helpers/textutils.dart';
import 'package:tender_sims/survey/interfaces/ICalculation.dart';
import 'package:tender_sims/survey/widgets/chartWidget.dart' as chart;
import 'package:tender_sims/survey/widgets/playChart.dart';
import 'package:tender_sims/survey/widgets/playerSeries.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tender_sims/survey/widgets/sampleChart.dart';
import 'package:tender_sims/business/constants.dart' as tn_const;
import 'package:tender_sims/survey/helpers/sort.dart';
import 'package:intl/intl.dart';

class CalculationWave implements ICalculation {
  List<charts.Series<OrdinalSales, String>> result_data = [];
  double price_winning = 10000;
  String team_winning = 'no_team';
  double value_winning = 0;
  String wave_id_prv = 'no_wave_id';
  List<Widget> log = [];
  Map<String, Map<String, dynamic>> calculatedDataPrv = {};
  Map<String, Map<String, double>> map_summary_prv = {};

  CalculationWave(
      {required String wave_id,
      required Map<String, Map<String, double>> map_summary}) {
    this.wave_id_prv = wave_id;
    this.map_summary_prv = map_summary;
  }

  @override
  List<charts.Series<OrdinalSales, String>> getSeries() {
    List<OrdinalSales> salesdata = [];
    List<OrdinalSales> cogsdata = [];
    List<OrdinalSales> profitdata = [];

    // // //
    // Calculate single winner wave 1
    //

    log.add(Text('Winning Team: ' + team_winning));
    log.add(Text('Winning Price: ' + price_winning.toString()));

    map_summary_prv.forEach((team_id, map) {
      map.forEach((metric, value) {
        if (metric == 'salesdata') {
          salesdata.add(
            OrdinalSales(team_id, value.toInt()),
          );
        }

        if (metric == 'cogsdata') {
          cogsdata.add(
            OrdinalSales(team_id, value.toInt()),
          );
        }

        if (metric == 'profitdata') {
          profitdata.add(
            OrdinalSales(team_id, value.toInt()),
          );
        }
      });
    });

    var f = NumberFormat();
    return [
      charts.Series<OrdinalSales, String>(
          id: 'Revenue',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: salesdata,
          labelAccessorFn: (OrdinalSales sales, _) =>
              '${f.format(sales.sales)}',
          colorFn: (OrdinalSales sales, _) {
            if (sales.year == team_winning) {
              return charts.ColorUtil.fromDartColor(Colors.green.shade300);
            }
            return charts.ColorUtil.fromDartColor(Colors.blue.shade300);
          }),
      charts.Series<OrdinalSales, String>(
          id: 'Costs',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: cogsdata,
          labelAccessorFn: (OrdinalSales sales, _) =>
              '${f.format(sales.sales)}',
          colorFn: (OrdinalSales sales, _) {
            if (sales.year == team_winning) {
              return charts.ColorUtil.fromDartColor(Colors.green.shade100);
            }
            return charts.ColorUtil.fromDartColor(Colors.blue.shade100);
          }),
      charts.Series<OrdinalSales, String>(
          id: 'Profit',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: profitdata,
          labelAccessorFn: (OrdinalSales sales, _) =>
              '${f.format(sales.sales)}',
          colorFn: (OrdinalSales sales, _) {
            if (sales.year == team_winning) {
              return charts.ColorUtil.fromDartColor(Colors.green.shade50);
            }
            return charts.ColorUtil.fromDartColor(Colors.blue.shade50);
          })
    ];
  }

  @override
  String getTitle() {
    return team_winning;
  }

  @override
  List<Widget> get_log() {
    return log;
  }

  @override
  Map<String, Map<String, dynamic>> calculatedData() {
    return calculatedDataPrv;
  }
}
