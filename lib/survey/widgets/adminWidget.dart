import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tender_sims/survey/widgets/adminResultWidget.dart';
import 'package:tender_sims/survey/helpers/result.dart';
import 'playerSeries.dart';

class AdminScreen extends StatefulWidget {
  @override
  State<AdminScreen> createState() => AdminScreenState();
}

class AdminScreenState extends State<AdminScreen> {
  String game_id = 'no_game_id';
  String page_route = 'no_route';

  @override
  void initState() {
    super.initState();

    // Get Game ID
    final docRef_settings =
        FirebaseFirestore.instance.collection("settings").doc("main");
    docRef_settings.get().then((DocumentSnapshot doc) {
      game_id = doc['game_id'];

      Map<String, String> get_route = {
        'w1g1': '/results',
        'w1g2': '/results',
        'w1g3': '/results',
        'w2g1': '/results2',
        'w2g2': '/results2',
        'w2g3': '/results2',
        'w3g1': '/results3',
        'w3g2': '/results3',
        'w3g3': '/results3',
        'w4g1': '/results4',
        'w4g2': '/results4',
        'w4g3': '/results4',
      };
      if (get_route[game_id] != null) {
        page_route = get_route[game_id] as String;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tender Sims Admin Screen'),
        ),
        body: Center(
            child: Container(
                height: 50,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(page_route, arguments: game_id);
                  },
                  child: Text('See Results'),
                ))));
  }
}
