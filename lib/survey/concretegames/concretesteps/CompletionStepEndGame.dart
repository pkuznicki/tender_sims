import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/ICompletionStep.dart';
import 'package:tender_sims/survey/steps/CustomStep.dart';
import 'package:flutter/material.dart';

class CompletionStepEndGame extends ICompletionStep {
  CompletionStepEndGame()
     : super(
            stepIdentifier: StepIdentifier(id: 'end_game'),
            title: 'End of Game!',
            text: 'Click FINAL SUBMISSION to send the results.',
            buttonText: 'Final submission'
            );
}
