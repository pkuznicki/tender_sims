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

class CalculationSingle implements ICalculation {
  late QuerySnapshot qs;
  List<charts.Series<OrdinalSales, String>> result_data = [];
  double price_winning = 10000;
  String team_winning = 'no_team';
  double value_winning = 0;
  String game_id_prv = 'no_game_id';

  CalculationSingle({required QuerySnapshot qs, required String game_id}) {
    this.qs = qs;
    this.game_id_prv = game_id;
  }

  @override
  List<charts.Series<OrdinalSales, String>> getSeries() {
    List<OrdinalSales> salesdata = [];
    List<OrdinalSales> cogsdata = [];
    List<OrdinalSales> profitdata = [];

    // // //
    // Calculate single winner wave 1
    //

    if (game_id_prv.substring(1, 2) == '1') {
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

      qs.docs.forEach(
        (team_result) {
          double price = double.parse(team_result['price_zipper']);
          int volume = 1000000;
          String team_name = team_result['team_name_str'];
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
    } // eo single winner

    return [
      charts.Series<OrdinalSales, String>(
          id: 'Revenue',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: salesdata,
          labelAccessorFn: (OrdinalSales sales, _) =>
              '${sales.sales.toString()}',
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
              '${sales.sales.toString()}',
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
              '${sales.sales.toString()}',
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
}
