import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tender_sims/survey/widgets/adminResultWidget.dart';
import 'package:tender_sims/survey/helpers/result.dart';
import 'playerSeries.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

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
            onPressed: () async {
              // Get Game ID
              String game_id = 'no_game_id';
              final docRef_settings =
                  FirebaseFirestore.instance.collection("settings").doc("main");
              await docRef_settings.get().then((DocumentSnapshot doc) {
                final data = doc.data() as Map<String, dynamic>;
                game_id = doc['game_id'];
              });

              // Get Data
              QuerySnapshot result_data;
              final CollectionReference _collectionRef =
                  FirebaseFirestore.instance.collection(game_id);

              await _collectionRef.get().then(
                (qs) {
                  Navigator.of(context).pushNamed('/results', arguments: qs);
                },
              );
            },
            child: const Text('Results'),
          ),
        ),
      ),
    );
  }
}
