import 'package:survey_kit/survey_kit.dart';

class CustomResult extends QuestionResult<String> {
  late String customData;
  late String valueIdentifier;
  late Identifier identifier;
  late DateTime startDate;
  late DateTime endDate;
  late String value;

  CustomResult(
      {required super.id,
      required super.startDate,
      required super.endDate,
      required super.valueIdentifier,
      required super.result}); //Custom value
}
