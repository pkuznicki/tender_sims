import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IQuestionStep.dart';
import 'package:tender_sims/survey/steps/CustomStep.dart';
import 'package:flutter/material.dart';

class QuestionStepTeamName extends IQuestionStep {
  QuestionStepTeamName()
      : super(
          stepIdentifier: StepIdentifier(id: 'team_name'),
          title: 'Please Choose a Name for your Team.',
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Polaris Labs', value: 'polaris'),
              TextChoice(text: 'River Pharma', value: 'river'),
              TextChoice(text: 'Beach BioScience', value: 'beach'),
              TextChoice(text: 'Sunset Pharma', value: 'sunset'),
              TextChoice(text: 'Centerfield Inc.', value: 'centerfield'),
            ],
          ),
        );
}
