import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';
import 'survey/ISurveyConnector.dart';
import 'survey/TenderSimsGame01.dart';
import 'surveyWidget.dart';

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

  Future<Task> getJsonTask() async {
    final taskJson = await rootBundle.loadString('assets/tender_sims.json');
    final taskMap = json.decode(taskJson);
    return Task.fromJson(taskMap);
  }
}
