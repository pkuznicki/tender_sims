import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/steps/CustomStep.dart';

abstract class IInstructionStep extends CustomStep {
  IInstructionStep(super.topWidget, super.bottomWidget,
      {required super.id, required super.title, required super.text});
}
