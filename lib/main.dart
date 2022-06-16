import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';
import 'survey/interfaces/ISurveyConnector.dart';
import 'survey/concretegames/TenderSimsGame01.dart';
import 'package:tender_sims/survey/widgets/surveyWidget.dart';
import 'survey/concretegames/concretesteps/QuestionStepTeamName.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: SurveyWidget()),
    );
  }

  // Note used as this does not work.
  Future<Task> getJsonTask() async {
    final taskJson = await rootBundle.loadString('assets/tender_sims.json');
    final taskMap = json.decode(taskJson);
    return Task.fromJson(taskMap);
  }
}
