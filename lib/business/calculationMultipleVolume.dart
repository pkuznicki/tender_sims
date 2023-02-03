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

class CalculationMultipleVolume implements ICalculation {
  late QuerySnapshot qs;
  List<charts.Series<OrdinalSales, String>> result_data = [];
  String game_id_prv = 'no_game_id';
  List<MapEntry<String, dynamic>> winners = [];
  Map<String, int> awarded_volumes = {};
  Map<String, int> bidded_volumes = {};
  List<Widget> log = [];

  CalculationMultipleVolume(
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

    // Get Bidded Volumes

    qs.docs.forEach((team_result) {
      String team_id = team_result['team_name_str'];
      int bidded_volume = int.parse(team_result['price_zipper_volume']);
      bidded_volumes[team_id] = bidded_volume;
    });

    // Order by bidding price
    Map<String, double> map = {};
    qs.docs.forEach((team_result) {
      String team_id = team_result['team_name_str'];
      map[team_id] = double.parse(team_result['price_zipper']);
    });

    winners = Sort.sortMapByValue(map);
    List<String> winner_ids = [];
    winners.forEach((element) {
      winner_ids.add(element.key.toString());
    });

    // Calculate Awarded Volumes
    int cum_volume = 0;
    int i = 0;
    while ((cum_volume < 3000000) && (i < winners.length)) {
      cum_volume += bidded_volumes[winners[i].key]!;
      i += 1;
    }
    int tail = cum_volume - 3000000;

    // Assign awarded volumes
    for (int j = 0; j < i - 1; j += 1) {
      String team_id = winners[j].key;
      awarded_volumes[team_id] = bidded_volumes[team_id]!;
    }
    if (i - 1 < winners.length) {
      String team_id = winners[i - 1].key;
      if (tail < 0) {
        tail = 0;
      }
      awarded_volumes[team_id] = bidded_volumes[team_id]! - tail;
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
            if (winner_ids.contains(sales.year)) {
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
            if (winner_ids.contains(sales.year)) {
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
            if (winner_ids.contains(sales.year)) {
              return charts.ColorUtil.fromDartColor(Colors.green.shade50);
            }
            return charts.ColorUtil.fromDartColor(Colors.blue.shade50);
          })
    ];
  }

  @override
  String getTitle() {
    String result = '';
    winners.forEach((winner) {
      result += 'Team: ' + winner.key.toString();
      result += ' Price: ' + winner.value.toString();
      result += ' ';
    });
    return result;
  }

  @override
  List<Widget> get_log() {
    // TODO: implement get_log
    throw UnimplementedError();
  }
}
