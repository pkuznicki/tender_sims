import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Result {
  QuerySnapshot data;
  String game_id;

  Result({required this.data, this.game_id = 'no_game_id'});
}
