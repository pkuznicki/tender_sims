import 'package:survey_kit/survey_kit.dart';

abstract class ISurveyConnector {
  List<Step> getSteps();
}
