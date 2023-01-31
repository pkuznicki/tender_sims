import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/helpers/helper.dart';
import 'package:tender_sims/survey/widgets/adminResultWidget.dart';
import 'package:tender_sims/survey/widgets/errorWidget.dart';
import 'package:tender_sims/survey/widgets/welcomeWidget.dart';
import 'firebase_options.dart';
import 'survey/interfaces/ISurveyConnector.dart';
import 'package:tender_sims/survey/widgets/surveyWidget.dart';
import 'survey/concretegames/concretesteps/QuestionStepTeamName.dart';
import 'package:tender_sims/survey/widgets/adminWidget.dart';
import 'package:go_router/go_router.dart';
import 'package:tender_sims/survey/helpers/maps.dart';
import 'package:tender_sims/survey/widgets/sampleChart.dart';
import 'package:intl/intl.dart';
// TODO
// Add results won revenue and color coding

void main() async {
  Intl.defaultLocale = 'en_US';
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

  List<GoRoute> routes = [];
  late GoRouter _router;

  @override
  void initState() {
    String game_id = 'no_game_id';

    //add routes for game ids
    maps.map_games.forEach((key, value) {
      routes.add(GoRoute(
        path: '/$key',
        builder: (BuildContext context, GoRouterState state) =>
            SurveyWidget(key),
      ));
      // add results route
      routes.add(GoRoute(
        path: '/results/$key',
        builder: (BuildContext context, GoRouterState state) => ResultScreen(
          game_id: key,
        ),
      ));
    });
    // add homepage
    routes.add(GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => WelcomeScreen(
        game_id_prv,
      ),
    ));
    // add admin route
    routes.add(GoRoute(
      path: '/admin',
      builder: (BuildContext context, GoRouterState state) => AdminScreen(),
    ));
    // add sample route
    routes.add(GoRoute(
      path: '/sample',
      builder: (BuildContext context, GoRouterState state) =>
          GroupedBarChart.withSampleData(),
    ));
    routes.add(GoRoute(
      path: '/error',
      builder: (BuildContext context, GoRouterState state) => errorWidget(),
    ));

    _router = GoRouter(routes: routes);
    super.initState();
  }

  _MyAppState(String game_id) {
    game_id_prv = game_id;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,

      title: 'Tender Simulations Game ## SIMS ##',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
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
