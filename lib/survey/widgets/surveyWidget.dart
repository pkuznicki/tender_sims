import 'dart:html';

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
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2,
            color: Colors.white,
            child: Align(
              alignment: Alignment.center,
              child: FutureBuilder<Task>(
                future: getTask(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData &&
                      snapshot.data != null) {
                    final task = snapshot.data!;
                    return SurveyKit(
                      onResult: (SurveyResult result) {
                        print(result.finishReason);
                        print(result.results.toString());
                      },
                      task: task,
                      showProgress: true,
                      localizations: const {
                        'cancel': 'Cancel',
                        'next': 'Next',
                      },
                      themeData: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.fromSwatch(
                          primarySwatch: Colors.cyan,
                        ).copyWith(
                          onPrimary: Colors.white,
                        ),
                        primaryColor: Colors.cyan,
                        backgroundColor: Colors.white,
                        appBarTheme: const AppBarTheme(
                          color: Colors.white,
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
                                  return Theme.of(context)
                                      .textTheme
                                      .button
                                      ?.copyWith(
                                        color: Colors.grey,
                                      );
                                }
                                return Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.copyWith(
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
                        textTheme: TextTheme(
                          headline2: TextStyle(
                            fontSize: 28.0,
                            color: Colors.black,
                          ),
                          headline5: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                          ),
                          bodyText2: TextStyle(
                            fontSize: 18.0,
                            color: Colors.red,
                          ),
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
                      surveyProgressbarConfiguration:
                          SurveyProgressConfiguration(
                        backgroundColor: Colors.white,
                        borderRadius: BorderRadius.zero,
                        padding: const EdgeInsets.all(0),
                      ),
                    );
                  }
                  return CircularProgressIndicator.adaptive();
                },
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2,
          ),
        ],
      ),
    );
  }
}

Future<Task> getTask() {
  ISurveyConnector tendersurvey = TenderSimsGame01();

  var task = NavigableTask(
    id: TaskIdentifier(),
    steps: tendersurvey.getSteps(),
  );
  task.addNavigationRule(
    forTriggerStepIdentifier: task.steps[6].stepIdentifier,
    navigationRule: ConditionalNavigationRule(
      resultToStepIdentifierMapper: (input) {
        switch (input) {
          case "Yes":
            return task.steps[0].stepIdentifier;
          case "No":
            return task.steps[7].stepIdentifier;
          default:
            return null;
        }
      },
    ),
  );
  return Future.value(task);
}
