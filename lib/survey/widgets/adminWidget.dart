import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:tender_sims/survey/helpers/helper.dart';
import 'package:tender_sims/survey/helpers/maps.dart';
import 'package:tender_sims/survey/widgets/adminResultWidget.dart';
import 'package:tender_sims/survey/helpers/result.dart';
import 'playerSeries.dart';
import 'dart:html' as html;

class AdminScreen extends StatefulWidget {
  @override
  State<AdminScreen> createState() => AdminScreenState();
}

class AdminScreenState extends State<AdminScreen> {
  String game_id = 'no_game_id';
  String game_name = 'No Game';
  String page_route = 'no_route';
  List<Widget> lst_game_buttons = [];

  @override
  void initState() {
    super.initState();

    // Get Game ID
    final docRef_settings =
        FirebaseFirestore.instance.collection("settings").doc("main");
    docRef_settings.get().then((DocumentSnapshot doc) {
      game_id = doc['game_id'];
      game_name = maps.map_games[game_id] ?? 'No Game';

      maps().games().forEach((key, value) {
        lst_game_buttons.add(Column(
          children: [
            Container(
              height: 5,
            ),
            Container(
              height: 20,
              width: 300,
              child: ElevatedButton(
                onPressed: () async {
                  await docRef_settings.set({'game_id': key}).then((value) {
                    game_id = key;
                    game_name = maps.map_games[game_id] ?? 'No Game';
                    setState(() {});
                    //html.window.location.reload();
                  });
                },
                child: Text(value),
              ),
            ),
          ],
        ));
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tender Sims Admin Screen'),
      ),
      body: Center(
        child: Row(
          children: [
            Container(
              width: 300,
            ),
            Column(
              children: [
                Container(
                  height: 25,
                ),
                Text(
                  'Current Game: $game_name',
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  height: 25,
                ),
                Container(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/results/$game_id');
                    },
                    child: Text('See Results'),
                  ),
                ),
                Container(
                  height: 25,
                ),
                Container(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                        onPressed: () {
                          /* final docRef = FirebaseFirestore.instance
                              .collection(game_id)
                              .snapshots()
                              .forEach((element) {
                            for (QueryDocumentSnapshot docSnapshot
                                in element.docs) {
                              docSnapshot.reference.delete();
                            }
                          });
                          game_name = 'Deleted!';
                          setState(() {}); */
                        },
                        child: Text('Delete Current Game'))),
              ],
            ),
            Container(
              width: 25,
            ),
            Column(
              children: lst_game_buttons,
            )
          ],
        ),
      ),
    );
  }
}
