import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tender_sims/survey/widgets/adminResultWidget.dart';
import 'package:tender_sims/survey/helpers/result.dart';
import 'package:tender_sims/survey/helpers/result.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tender Sims Admin Screen'),
      ),
      body: Center(
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

            CollectionReference _collectionRef =
                FirebaseFirestore.instance.collection(game_id);

            Future<QuerySnapshot> getData() async {
              // Get docs from collection reference
              QuerySnapshot querySnapshot = await _collectionRef.get();

              return querySnapshot;
            }

            // Print Result
            await getData().then((qs) {
              Navigator.of(context).pushNamed('/results',
                  arguments: Result(game_id: game_id, data: qs));
            });
          },
          child: const Text('See Results.'),
        ),
      ),
    );
  }
}
