import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IQuestionStep.dart';
import 'package:tender_sims/survey/steps/CustomStep.dart';
import 'package:flutter/material.dart';

class QuestionStepPriceZipper extends IQuestionStep {
  QuestionStepPriceZipper()
      : super(
          title: 'Please Select Your Bidding Price in \$.',
          answerFormat: ScaleAnswerFormat(
            step: 1,
            minimumValue: 10,
            maximumValue: 50,
            defaultValue: 10,
            minimumValueDescription: '10',
            maximumValueDescription: '50',
          ),
        );
}
