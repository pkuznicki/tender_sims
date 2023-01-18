import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

            Future<List<Object?>> getData() async {
              // Get docs from collection reference
              QuerySnapshot querySnapshot = await _collectionRef.get();

              // Get data from docs and convert map to List
              final allData =
                  querySnapshot.docs.map((doc) => doc.data()).toList();

              return allData;
            }

            await getData().then((value) => print(value));
          },
          child: const Text('See Results.'),
        ),
      ),
    );
  }
}
