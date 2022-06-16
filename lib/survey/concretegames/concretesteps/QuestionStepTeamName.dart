import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IQuestionStep.dart';
import 'package:tender_sims/survey/steps/CustomStep.dart';
import 'package:flutter/material.dart';

class QuestionStepTeamName extends IQuestionStep {
  QuestionStepTeamName()
      : super(
          title: 'Please Choose a Name for your Team.',
          answerFormat: TextAnswerFormat(
            maxLines: 1,
            validationRegEx: "^(?!\s*\$).+",
          ),
        );
}
