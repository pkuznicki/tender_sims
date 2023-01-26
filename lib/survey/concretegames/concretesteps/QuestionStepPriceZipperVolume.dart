import 'package:survey_kit/survey_kit.dart';
import 'package:tender_sims/survey/interfaces/IQuestionStep.dart';
import 'package:tender_sims/survey/steps/CustomStep.dart';
import 'package:flutter/material.dart';

class QuestionStepPriceZipperVolume extends IQuestionStep {
  QuestionStepPriceZipperVolume()
      : super(
            stepIdentifier: StepIdentifier(id: 'price_zipper_volume'),
            title: 'Please Select Your Bidding Volume..',
            answerFormat: IntegerAnswerFormat(
                defaultValue: 1000000,
                hint: 'Please select a value below 1.000.000'));
}
