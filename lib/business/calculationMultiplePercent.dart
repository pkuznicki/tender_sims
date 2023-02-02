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

class CalculationMultiplePercent implements ICalculation {
  late QuerySnapshot qs;
  List<charts.Series<OrdinalSales, String>> result_data = [];
  String game_id_prv = 'no_game_id';
  List<MapEntry<String, dynamic>> winners = [];
  Map<String, int> awarded_volumes = {};

  CalculationMultiplePercent(
      {required QuerySnapshot qs, required String game_id}) {
    this.qs = qs;
    this.game_id_prv = game_id;
  }

  @override
  List<charts.Series<OrdinalSales, String>> getSeries() {
    List<OrdinalSales> salesdata = [];
    List<OrdinalSales> cogsdata = [];
    List<OrdinalSales> profitdata = [];

    // // //
    // Calculate qualitiative criteria Wave 3
    //

    // Order by perceived bidding price
    Map<String, double> map = {};
    qs.docs.forEach((team_result) {
      String team_id = team_result['team_name_str'];
      map[team_id] = double.parse(team_result['price_zipper']);
    });

    winners = Sort.sortMapByValue(map);

    // Calculate Awarded Volumes
    if (winners.length > 0) {
      awarded_volumes[winners[0].key] = (3000000 * 0.5).round();
    }
    if (winners.length > 1) {
      awarded_volumes[winners[1].key] = (3000000 * 0.3).round();
    }
    if (winners.length > 2) {
      awarded_volumes[winners[2].key] = (3000000 * 0.2).round();
    }
    // Add losing teams
    tn_const.tnConstants.get_team_names().forEach((team_id, team_name) {
      if (awarded_volumes.containsKey(team_id) == false) {
        awarded_volumes[team_id] = 0;
      }
    });

    // Generate Chart data
    qs.docs.forEach(
      (team_result) {
        double price = double.parse(team_result['price_zipper']);
        String team_name = team_result['team_name_str'];
        int volume = awarded_volumes[team_name] ?? -1;
        double cogs = tn_const.tnConstants.get_cogs(team_id: team_name);

        salesdata.add(
          OrdinalSales(team_name, (volume * price).round()),
        );

        cogsdata.add(
          OrdinalSales(team_name, (volume * cogs).round()),
        );

        profitdata.add(
          OrdinalSales(team_name, (volume * (price - cogs)).round()),
        );
      },
    );

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
            if (Map.fromIterable(winners).keys.contains(sales.year)) {
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
            if (Map.fromIterable(winners).keys.contains(sales.year)) {
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
            if (Map.fromIterable(winners).keys.contains(sales.year)) {
              return charts.ColorUtil.fromDartColor(Colors.green.shade50);
            }
            return charts.ColorUtil.fromDartColor(Colors.blue.shade50);
          })
    ];
  }

  @override
  String getTitle() {
    String result = '';
    Map.fromIterable(winners).forEach((key, value) {
      result += 'Team: ' + key.toString();
      result += ' Price: ' + value.toString();
      result += ' ';
    });
    return result;
  }
}
