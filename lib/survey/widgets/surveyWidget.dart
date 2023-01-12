import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';
import '../interfaces/ISurveyConnector.dart';
import 'package:tender_sims/survey/concretegames/TenderSimsGame01.dart';

class SurveyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 5, 55, 96),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.center,
        child: FutureBuilder<Task>(
          future: getTask(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null) {
              final task = snapshot.data!;
              return SurveyKit(
                onResult: (SurveyResult result) {
                  //get game id
                  String game_id = 'no_game_id';
                  final docRef_settings = FirebaseFirestore.instance
                      .collection("settings")
                      .doc("main");

                  docRef_settings.get().then(
                    (DocumentSnapshot doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      game_id = doc['game_id'];

                      Map<String, String> map_result =
                          new Map<String, String>();

                      String id_no_null(String? myString) {
                        if (myString == null) {
                          return 'nodata';
                        }

                        return myString;
                      }

                      for (StepResult sr in result.results) {
                        for (QuestionResult qr in sr.results) {
                          map_result[id_no_null(sr.id?.id)] =
                              qr.result.toString();
                        }
                      }
                      map_result['game_id'] = game_id;
                      String team_id = id_no_null(map_result['team_name']);

                      //Write results
                      final docRef_survey = FirebaseFirestore.instance
                          .collection(game_id)
                          .doc(team_id);
                      docRef_survey.set(map_result).onError(
                          (e, _) => print("Error writing document: $e"));
                    },
                    onError: (e) => print("Error getting document: $e"),
                  );
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
                      255, 212, 0, 173), // Progress Bar and Button text
                  backgroundColor: Colors.white, // Background
                  appBarTheme: const AppBarTheme(
                    color: Color.fromARGB(255, 71, 142, 46), // Top Bar color
                    iconTheme: IconThemeData(
                      color: Colors.cyan,
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.cyan,
                    ),
                  ),
                  iconTheme: const IconThemeData(
                    color: Colors.cyan,
                  ),
                  textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: Colors.cyan,
                    selectionColor: Colors.cyan,
                    selectionHandleColor: Colors.cyan,
                  ),
                  cupertinoOverrideTheme: const CupertinoThemeData(
                    primaryColor: Colors.cyan,
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
                            color: Colors.cyan,
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
                                color: Colors.cyan,
                              );
                        },
                      ),
                    ),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                        Theme.of(context).textTheme.button?.copyWith(
                              color: Colors.cyan,
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

Future<Task> getTask(BuildContext context) {
  ISurveyConnector tendersurvey = TenderSimsGame01();

  var task = OrderedTask(
    id: TaskIdentifier(),
    steps: tendersurvey.getSteps(context),
  );
  return Future.value(task);
}
