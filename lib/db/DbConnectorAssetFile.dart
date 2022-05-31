import 'dart:convert';
import 'package:survey_kit/src/task/task.dart';
import 'package:tender_sims/db/IDbConnector.dart';
import 'package:flutter/services.dart';

class DbConnectorAssetFile implements IDbConector {
  @override
  Future<Task> getJsonTask() async {
    final taskJson = await rootBundle.loadString('assets/tender_sims.json');
    final taskMap = json.decode(taskJson);

    return Task.fromJson(taskMap);
  }
}
