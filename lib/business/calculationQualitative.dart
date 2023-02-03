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
import 'package:tender_sims/business/constants.dart' as cst;

class CalculationQualitative implements ICalculation {
  late QuerySnapshot qs;
  List<charts.Series<OrdinalSales, String>> result_data = [];
  String game_id_prv = 'no_game_id';
  Map<String, double> team_qc_norm_score = {};
  Map<String, double> team_perceived_bp = {};
  List<MapEntry<String, dynamic>> winners = [];
  Map<String, int> awarded_volumes = {};
  Map<String, String> team_upgrades = {};
  List<Widget> log = [];

  CalculationQualitative({required QuerySnapshot qs, required String game_id}) {
    this.qs = qs;
    this.game_id_prv = game_id;
    this.log.add(Text('Calculation Wave 4 Started.'));
  }

  @override
  List<charts.Series<OrdinalSales, String>> getSeries() {
    List<OrdinalSales> salesdata = [];
    List<OrdinalSales> cogsdata = [];
    List<OrdinalSales> profitdata = [];

    // // //
    // Calculate qualitiative criteria Wave 4
    //

    // Get upgrade info from survey
    qs.docs.forEach((team_result) {
      String team_id = team_result['team_name_str'];
      String arr_qc = team_result['qual_crit_str'];
      team_upgrades[team_id] = arr_qc;
    });

    // Calculate normalized scores

    tn_const.tnConstants.get_team_names().forEach((team_id, team_name) {
      double team_norm_score = 0;
      tn_const.tnConstants.get_qc_weight_map().forEach((crit, weight) {
        double score =
            ((tn_const.tnConstants.get_points_map)()[team_id]?[crit] ?? 0);
        team_norm_score = team_norm_score + weight * (score - 1) / 5;
        //Upgrades
        if ((team_upgrades[team_id] ?? '').contains(crit) && (score < 6)) {
          team_norm_score += 0.2;
        }
      });
      team_qc_norm_score[team_id] = team_norm_score;
      log.add(Text('Normalized Score w/ Upgrades. Team: ' +
          team_name +
          ' .Score: ' +
          double.parse(team_norm_score.toString()).toStringAsFixed(2)));
    });

    // Calluate perceived bidding price
    qs.docs.forEach(
      (team_result) {
        String team_id = team_result['team_name_str'];
        double price = double.parse(team_result['price_zipper']);
        team_perceived_bp[team_id] = (1 - team_qc_norm_score[team_id]!) * price;

        log.add(Text('Bidding Price. Team: ' +
            team_id +
            ': ' +
            double.parse(price.toString()).toStringAsFixed(3)));

        log.add(Text('Perceived Bidding Prices. Team: ' +
            team_id +
            ': ' +
            double.parse(team_perceived_bp[team_id].toString())
                .toStringAsFixed(3)));
      },
    );

    // Order by perceived bidding price
    Map<String, double> map = {};
    qs.docs.forEach((team_result) {
      String team_id = team_result['team_name_str'];
      map[team_id] = team_perceived_bp[team_id] ?? -1;
    });

    winners = Sort.sortMapByValue(map);
    List<String> winner_ids = [];
    winners.forEach((element) {
      winner_ids.add(element.key.toString());
    });

    // Calculate Awarded Volumes
    if (winners.length > 0) {
      awarded_volumes[winners[0].key] = (3000000 * 0.5).round();
      log.add(Text('Awarded volume. Winner 1 ' +
          winners[0].key +
          ': ' +
          awarded_volumes[winners[0].key].toString()));
    }
    if (winners.length > 1) {
      awarded_volumes[winners[1].key] = (3000000 * 0.3).round();
      log.add(Text('Awarded volume. Winner 2 ' +
          winners[1].key +
          ': ' +
          awarded_volumes[winners[1].key].toString()));
    }
    if (winners.length > 2) {
      awarded_volumes[winners[2].key] = (3000000 * 0.2).round();
      log.add(Text('Awarded volume. Winner 3 ' +
          winners[2].key +
          ': ' +
          awarded_volumes[winners[2].key].toString()));
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
        double additional_costs = 1000000 *
            ((team_result['qual_crit_str'] as String)
                .allMatches(',')
                .length) as double;

        salesdata.add(
          OrdinalSales(team_name, (volume * price).round()),
        );

        cogsdata.add(
          OrdinalSales(
              team_name, (volume * cogs).round() - additional_costs as int),
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
      result += ' ' + cst.tnConstants.get_team_names()[winner.key.toString()]!;
      result += ' PB Price: ' + ((winner.value * 100).round() / 100).toString();
      result += '';
    });
    return result;
  }

  @override
  List<Widget> get_log() {
    return log;
  }
}
