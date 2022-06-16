import 'package:survey_kit/survey_kit.dart';

abstract class IQuestionStep extends QuestionStep {
  IQuestionStep({super.title, required super.answerFormat});
}
