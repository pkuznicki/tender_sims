import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tender_sims/business/calculationSingle.dart';
import 'package:tender_sims/business/calculationQualitative.dart';
import 'package:tender_sims/business/calculationMultiplePercent.dart';
import 'package:tender_sims/survey/widgets/sampleChart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tender_sims/survey/interfaces/ICalculation.dart';
import 'package:tender_sims/business/calculationMultipleVolume.dart';
import 'package:tender_sims/survey/widgets/detailsWidget.dart' as pop;
import 'package:tender_sims/business/constants.dart' as cst;

class ResultScreen extends StatefulWidget {
  String game_id_prv = 'no_game_id';

  ResultScreen({required String game_id}) {
    game_id_prv = game_id;
  }

  @override
  State<ResultScreen> createState() => ResultScreenState(game_id: game_id_prv);
}

class ResultScreenState extends State<ResultScreen> {
  List<charts.Series<OrdinalSales, String>> result_data = [];
  String game_id_prv = 'no_game_id';
  String title = 'no_title';
  bool data_exists = false;
  List<Widget> logWidget = [];
  ResultScreenState({required String game_id}) {
    game_id_prv = game_id;
  }

  @override
  void initState() {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(game_id_prv);

    collectionRef.get().then((qs) {
      if (qs.size > 0) {
        data_exists = true;
        ICalculation cs;
        Map<String, dynamic> resMap = {};

        // Calculation Wave 1
        if (game_id_prv.substring(1, 2) == '1') {
          cs = CalculationSingle(qs: qs, game_id: game_id_prv);
          result_data = cs.getSeries();
          this.title = cs.getTitle();
          this.logWidget = cs.get_log();
          resMap = cs.calculatedData() as Map<String, dynamic>;
        }
        // Calculation Wave 2
        if (game_id_prv.substring(1, 2) == '2') {
          cs = CalculationMultipleVolume(qs: qs, game_id: game_id_prv);
          result_data = cs.getSeries();
          this.title = cs.getTitle();
          this.logWidget = cs.get_log();
          resMap = cs.calculatedData() as Map<String, dynamic>;
        }
        // Calculation Wave 3
        if (game_id_prv.substring(1, 2) == '3') {
          cs = CalculationMultiplePercent(qs: qs, game_id: game_id_prv);
          result_data = cs.getSeries();
          this.title = cs.getTitle();
          this.logWidget = cs.get_log();
          resMap = cs.calculatedData() as Map<String, dynamic>;
        }
        // Calculation Wave 4
        if (game_id_prv.substring(1, 2) == '4') {
          //Get qual criteria from previous games to be added now but without costs
          if (game_id_prv == 'w4g3') {
            CollectionReference collectionRef1 =
                FirebaseFirestore.instance.collection('w4g1');

            CollectionReference collectionRef2 =
                FirebaseFirestore.instance.collection('w4g2');

            Map<String, String> map_qual_crit_old = {};
            collectionRef1.get().then((qs) {
              // Get upgrade info from survey
              if (qs.size > 0) {
                qs.docs.forEach((team_result) {
                  String team_id = team_result['team_name_str'];
                  String arr_qc = team_result['qual_crit_str'];
                  map_qual_crit_old[team_id] = arr_qc;
                });
              }

              Map<String, String> map_qual_crit_old2 = {};
              collectionRef2.get().then((qs) {
                // Get upgrade info from survey
                if (qs.size > 0) {
                  qs.docs.forEach((team_result) {
                    String team_id = team_result['team_name_str'];
                    String arr_qc = team_result['qual_crit_str'];
                    map_qual_crit_old2[team_id] = arr_qc;
                  });
                }

                //Combine both maps
                Map<String, String> map_qual_crit_old3 = {};
                cst.tnConstants.get_team_names().forEach(
                  (team_id, value) {
                    if (map_qual_crit_old.containsKey(team_id)) {
                      map_qual_crit_old3[team_id] =
                          map_qual_crit_old[team_id] ?? '';
                    }
                  },
                );
                cst.tnConstants.get_team_names().forEach(
                  (team_id, value) {
                    if (map_qual_crit_old2.containsKey(team_id)) {
                      map_qual_crit_old3[team_id] =
                          (map_qual_crit_old3[team_id] ?? '') +
                              (map_qual_crit_old2[team_id] ?? '');
                    }
                  },
                );

                // Calculate
                cs = CalculationQualitative(
                    qs: qs,
                    game_id: game_id_prv,
                    map_old_qual_crit: map_qual_crit_old3);
                result_data = cs.getSeries();
                this.title = cs.getTitle();
                this.logWidget = cs.get_log();
                resMap = cs.calculatedData() as Map<String, dynamic>;
              });
            });
          } //eo w4g3

          //Get qual criteria from previous games to be added now but without costs
          if (game_id_prv == 'w4g2') {
            CollectionReference collectionRef1 =
                FirebaseFirestore.instance.collection('w4g1');

            Map<String, String> map_qual_crit_old = {};
            collectionRef1.get().then((qs) {
              // Get upgrade info from survey
              if (qs.size > 0) {
                qs.docs.forEach((team_result) {
                  String team_id = team_result['team_name_str'];
                  String arr_qc = team_result['qual_crit_str'];
                  map_qual_crit_old[team_id] = arr_qc;
                });
              }

              collectionRef1.get().then((qs) {
                // Calculate
                cs = CalculationQualitative(
                    qs: qs,
                    game_id: game_id_prv,
                    map_old_qual_crit: map_qual_crit_old);
                result_data = cs.getSeries();
                this.title = cs.getTitle();
                this.logWidget = cs.get_log();
                resMap = cs.calculatedData() as Map<String, dynamic>;
              });

              //Write results
              resMap['info'] = {'ts': Timestamp.now()};
              final docRef_result = FirebaseFirestore.instance
                  .collection('results')
                  .doc(game_id_prv);
              docRef_result.set(resMap).then((value) {
                setState(() {});
              });
            });
          } //eo w4g2
        } // eo Wave 4

        if (int.parse(game_id_prv.substring(1, 2)) < 4) {
          //Write results
          resMap['info'] = {'ts': Timestamp.now()};
          final docRef_result =
              FirebaseFirestore.instance.collection('results').doc(game_id_prv);
          docRef_result.set(resMap).then((value) {
            setState(() {});
          });
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget result_widget = Text('No data');

    if (data_exists == true) {
      result_widget = Center(
          child: Column(
        children: [
          Container(
            height: 10,
          ),
          Text(style: TextStyle(fontSize: 20), 'Winning Team: $title'),
          Container(
            height: 500,
            width: 1000,
            child: charts.BarChart(
              vertical: false,
              result_data,
              animate: true,
              barRendererDecorator: new charts.BarLabelDecorator<String>(),
              behaviors: [
                charts.SeriesLegend(
                  position: charts.BehaviorPosition.end,
                  outsideJustification: charts.OutsideJustification.endDrawArea,
                  horizontalFirst: false,
                  desiredMaxRows: 2,
                  cellPadding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
                  entryTextStyle: const charts.TextStyleSpec(
                      color: charts.Color(r: 127, g: 63, b: 191),
                      fontFamily: 'Georgia',
                      fontSize: 11),
                )
              ],
              barGroupingType: charts.BarGroupingType.grouped,
            ),
          ),
          Container(
            height: 30,
          ),
          Container(
            height: 50,
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.grey.shade300, // background (button) color
                foregroundColor: Colors.white, // foreground (text) color
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      pop.buildPopupDialog(context, this.logWidget),
                );
              },
              child: Text('Calculation Details'),
            ),
          ),
        ],
      ));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Results'),
        ),
        body: result_widget);
  }
}
