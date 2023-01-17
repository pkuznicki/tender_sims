import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/concretegames/w1g2.dart';
import '../interfaces/ISurveyConnector.dart';
import 'package:tender_sims/survey/concretegames/TenderSimsGame01.dart' as game;
import 'package:tender_sims/survey/concretegames/w1g1.dart' as w1g1;
import 'package:tender_sims/survey/concretegames/w1g0.dart' as w1g0;
import 'package:tender_sims/survey/concretegames/w1g2.dart' as w1g2;
import 'package:tender_sims/survey/concretegames/w1g3.dart' as w1g3;

class SurveyWidget extends StatelessWidget {
  String game_id_prv = 'no game_id';

  SurveyWidget(String game_id) {
    game_id_prv = game_id;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 5, 55, 96),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.center,
        child: FutureBuilder<Task>(
          future: getTask(context, game_id_prv),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null) {
              final task = snapshot.data!;
              return SurveyKit(
                onResult: (SurveyResult result) {
                  Map<String, String> map_result = new Map<String, String>();

                  String id_no_null(String? myString) {
                    if (myString == null) {
                      return 'nodata';
                    }

                    return myString;
                  }

                  for (StepResult sr in result.results) {
                    for (QuestionResult qr in sr.results) {
                      map_result[id_no_null(sr.id?.id)] = qr.result.toString();
                    }
                  }
                  map_result['game_id'] = game_id_prv;
                  String team_id = id_no_null(map_result['team_name']);

                  //Write results
                  final docRef_survey = FirebaseFirestore.instance
                      .collection(game_id_prv)
                      .doc(team_id);
                  docRef_survey
                      .set(map_result)
                      .onError((e, _) => print("Error writing document: $e"));
                },
                task: task,
                showProgress: true,
                localizations: const {
                  'cancel': 'Cancel',
                  'next': 'Next',
                },
                themeData: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.blue,
                  ).copyWith(
                    onPrimary: Colors.white,
                  ),
                  primaryColor: Color.fromARGB(
                      255, 35, 0, 212), // Progress Bar and Button text
                  backgroundColor: Colors.white, // Background
                  appBarTheme: const AppBarTheme(
                    color: Color.fromARGB(255, 193, 195, 250), // Top Bar color
                    iconTheme: IconThemeData(
                      color: Color.fromARGB(255, 35, 0, 212),
                    ),
                    titleTextStyle: TextStyle(
                      color: Color.fromARGB(255, 35, 0, 212),
                    ),
                  ),
                  iconTheme: const IconThemeData(
                    color: Color.fromARGB(255, 35, 0, 212),
                  ),
                  textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: Color.fromARGB(255, 35, 0, 212),
                    selectionColor: Color.fromARGB(255, 35, 0, 212),
                    selectionHandleColor: Color.fromARGB(255, 35, 0, 212),
                  ),
                  cupertinoOverrideTheme: const CupertinoThemeData(
                    primaryColor: Color.fromARGB(255, 35, 0, 212),
                  ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(150.0, 60.0),
                      ),
                      side: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> state) {
                          if (state.contains(MaterialState.disabled)) {
                            return const BorderSide(
                              color: Colors.grey,
                            );
                          }
                          return const BorderSide(
                            color: Color.fromARGB(255, 35, 0, 212),
                          );
                        },
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      textStyle: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> state) {
                          if (state.contains(MaterialState.disabled)) {
                            return Theme.of(context).textTheme.button?.copyWith(
                                  color: Colors.grey,
                                );
                          }
                          return Theme.of(context).textTheme.button?.copyWith(
                                color: Color.fromARGB(255, 35, 0, 212),
                              );
                        },
                      ),
                    ),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                        Theme.of(context).textTheme.button?.copyWith(
                              color: Color.fromARGB(255, 35, 0, 212),
                            ),
                      ),
                    ),
                  ),
                  textTheme: const TextTheme(
                    headline2: TextStyle(
                      fontSize: 28.0,
                      color: Color.fromRGBO(13, 33, 207, 100),
                    ),
                    headline5: TextStyle(
                      fontSize: 24.0,
                      color: Color.fromRGBO(13, 33, 207, 100),
                    ),
                    bodyText2: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromRGBO(13, 33, 207, 100)),
                    subtitle1: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                surveyProgressbarConfiguration: SurveyProgressConfiguration(
                  backgroundColor: Colors.white,
                  borderRadius: BorderRadius.zero,
                  padding: const EdgeInsets.all(0),
                ),
              );
            }
            return const Text('Thank you..');
          },
        ),
      ),
    );
  }
}

Future<Task> getTask(BuildContext context, String game_id) {
  ISurveyConnector tendersurvey = game.TenderSimsGame01();

  if (game_id == 'w1g0') {
    tendersurvey = w1g0.w1g0();
  }
  if (game_id == 'w1g1') {
    tendersurvey = w1g1.w1g1();
  }
  if (game_id == 'w1g2') {
    tendersurvey = w1g2.w1g2();
  }
  if (game_id == 'w1g3') {
    tendersurvey = w1g3.w1g3();
  }

  var task = OrderedTask(
    id: TaskIdentifier(),
    steps: tendersurvey.getSteps(context),
  );
  return Future.value(task);
}
