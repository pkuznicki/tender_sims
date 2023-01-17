import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/ICompletionStep.dart';
import 'package:tender_sims/survey/steps/CustomStep.dart';
import 'package:flutter/material.dart';

class CompletionStepEndGame extends ICompletionStep {
  CompletionStepEndGame()
      : super(
            stepIdentifier: StepIdentifier(id: 'error_end_game'),
            title: 'Error No Step Found!',
            text: 'Click NEXT to send the results.');
}
