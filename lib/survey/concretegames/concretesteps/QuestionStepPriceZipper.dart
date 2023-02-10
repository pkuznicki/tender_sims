import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IQuestionStep.dart';
import 'package:tender_sims/survey/steps/CustomStep.dart';
import 'package:flutter/material.dart';

class QuestionStepPriceZipper extends IQuestionStep {
  QuestionStepPriceZipper()
      : super(
          stepIdentifier: StepIdentifier(id: 'price_zipper'),
          title: 'Please Select Your Bidding Price in \$.',
          answerFormat: ScaleAnswerFormat(
              step: 0.1,
              minimumValue: 0.1,
              maximumValue: 50,
              defaultValue: 25,
              minimumValueDescription: '0',
              maximumValueDescription: '50'),
              enum_format: enum_scale_format.price),
        );
}
