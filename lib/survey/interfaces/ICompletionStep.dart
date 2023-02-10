import 'package:survey_kit/survey_kit.dart';

abstract class ICompletionStep extends CompletionStep {
  ICompletionStep(
      {required super.stepIdentifier,
      required super.title,
      required super.text,
      required super.buttonText});
}
