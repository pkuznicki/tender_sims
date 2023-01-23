import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/widgets/adminResultWidget.dart';
import 'firebase_options.dart';
import 'survey/interfaces/ISurveyConnector.dart';
import 'survey/concretegames/TenderSimsGame01.dart';
import 'package:tender_sims/survey/widgets/surveyWidget.dart';
import 'survey/concretegames/concretesteps/QuestionStepTeamName.dart';
import 'package:tender_sims/survey/widgets/adminWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String game_id = 'no_game_id';
  final docRef_settings =
      FirebaseFirestore.instance.collection("settings").doc("main");

  await docRef_settings.get().then((DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    game_id = doc['game_id'];
  });

  runApp(MyApp(game_id));
}

class MyApp extends StatefulWidget {
  String game_id_prv = 'no game_id';
  MyApp(String game_id) {
    game_id_prv = game_id;
  }
  @override
  _MyAppState createState() => _MyAppState(game_id_prv);
}

class _MyAppState extends State<MyApp> {
  String game_id_prv = 'no game_id';
  _MyAppState(String game_id) {
    game_id_prv = game_id;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tender Simulations Game ## SIMS ##',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Scaffold(body: SurveyWidget(game_id_prv)),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/admin': (context) => const AdminScreen(),
        '/results': (context) => const ResultsScreen(),
      },
    );
  }

  // Note used as this does not work.
  Future<Task> getJsonTask() async {
    final taskJson = await rootBundle.loadString('assets/tender_sims.json');
    final taskMap = json.decode(taskJson);
    return Task.fromJson(taskMap);
  }
}



//home: Scaffold(body: SurveyWidget(game_id_prv)),
