import 'package:survey_kit/survey_kit.dart';

abstract class IDbConector {
  Future<Task> getJsonTask() async {
    throw UnimplementedError();
  }
}
